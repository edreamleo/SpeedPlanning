# @+leo-ver=5-thin
# @+node:ekr.20260925173401.1: * @file buttons.py
"""critical_path.py: The code for all buttons"""

# @@language python
# @+others
# @+node:ekr.20260923130208.1: ** @button critical-path
"""Critical path algorithm"""

g.cls()


# @+others
# @+node:ekr.20260927064024.1: *3* calculate_critical_path (critical-path)
def calculate_critical_path(tasks: list[Task]) -> tuple[int, list[Task]]:

    trace = True

    # Sort the tasks: dependencies first.
    ordered_tasks = []
    visited = set()

    def visit(task):
        if task not in visited:
            for dep in task.deps:
                visit(dep)
            visited.add(task)
            ordered_tasks.append(task)

    for task in tasks:
        visit(task)

    if trace:
        print('Ordered tasks, with deps:')
        for z in ordered_tasks:
            print(f"{z.name} [{','.join(z2.name for z2 in z.deps)}]")
        print()

    # Forward Pass: Calculate ES and EF.
    for task in ordered_tasks:
        deps = task.deps
        bad = [z.name for z in deps if z.ef == -1]
        assert not bad, bad
        task.es = max(dep.ef for dep in deps) if deps else 0
        task.ef = task.es + task.duration

    # Find total project duration.
    project_duration = max(task.ef for task in tasks)

    # Calculate successors of all tasks.
    for task in tasks:
        task.successors = [z for z in tasks if task in z.deps]

    if trace:
        print('Reversed ordered tasks, with successors:')
        for z in reversed(ordered_tasks):
            print(f"{z.name} [{','.join(z2.name for z2 in z.successors)}]")
        print()

    # Backward Pass: Calculate LF and LS.
    for task in reversed(ordered_tasks):
        successors = task.successors
        bad = [z.name for z in successors if z.lf == -1]
        assert not bad, bad
        task.lf = min(z.ls for z in successors) if successors else project_duration
        task.ls = task.lf - task.duration

        # Calculate the task's slack.
        task.slack = task.lf - task.ef

    # The critical path are those tasks with zero slack.
    critical_path = [task.name for task in ordered_tasks if task.slack == 0]

    return project_duration, critical_path


# @+node:ekr.20260925131747.1: *3* class Task
class Task:
    def __init__(self, name: str, duration: int) -> None:
        self.name = name
        self.duration = duration
        # Tasks that this tasks depends on. They must all finish before this task can start.
        self.deps = []
        # Tasks that depend on *this* task. This task must finish before any of these can start.
        self.successors = []

        # CPM Metrics
        self.es = -1  # Earliest Start
        self.ef = -1  # Earliest Finish
        self.ls = -1  # Latest Start
        self.lf = -1  # Latest Finish
        self.slack = -1


# @+node:ekr.20260925183728.1: *3* report
def report(duration: int, path: list[Task], tasks: list[task]) -> None:

    print(f"Project Duration: {duration} days")
    print()
    print(f"Critical Path: {' -> '.join(path)}")
    print()
    pad2 = ' ' * 2
    pad3 = ' ' * 3
    print(f"Task Len{pad2}ES{pad2}EF{pad2}LS{pad2}LF{pad2}Slack")
    for task in tasks:
        print(
            f"{pad2}{task.name}{pad3}{task.duration:2}{pad2}{task.es:2}{pad2}{task.ef:2}"
            f"{pad2}{task.ls:2}{pad2}{task.lf:2}{pad3}{task.slack:2}"
        )


# @-others

# Define tasks.
a = Task('A', 3)
b = Task('B', 4)
c = Task('C', 2)
d = Task('D', 5)
e = Task('E', 3)
tasks = [a, b, c, d, e]

# Define dependencies.
b.deps = [a]
c.deps = [a]
d.deps = [b]
e.deps = [c, d]

# Run Algorithm.
duration, path = calculate_critical_path(tasks)

# Report result.
report(duration, path, tasks)

# @@language python
# @+node:ekr.20260922175054.5: ** @button flow-chart
"""Create a mermaid flowchart from the 'planning-root' node."""
# @+<< flow-chart: imports >>
# @+node:ekr.20260922175054.6: *3* << flow-chart: imports >>
import re
import sys
import textwrap
import time
from typing import TYPE_CHECKING

from PyQt6.QtWidgets import QMenu
from PyQt6.QtCore import QObject, pyqtSlot, QFile, QIODevice
from PyQt6.QtGui import QCloseEvent, QCursor
from PyQt6.QtWebChannel import QWebChannel
from PyQt6.QtWebEngineWidgets import QWebEngineView
from PyQt6.QtWidgets import QInputDialog

from leo.core import leoGlobals as g

if TYPE_CHECKING:
    from leo.core.leoCommands import Commands as Cmdr
    from leo.core.leoNodes import Position


# @-<< flow-chart: imports >>
g.cls()
# @+<< define flowchart template >>
# @+node:ekr.20260924040355.3: *3* << define flowchart template >>
flowchart_template = textwrap.dedent("""
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        mermaid.initialize({ startOnLoad: true, securityLevel: 'loose' });
    </script>
</head>
<body>
    <div class="mermaid">
        flowchart_content
    </div>
</body>
</html>
""")


# @-<< define flowchart template >>
# @+others
# @+node:ekr.20260924040355.1: *3* class FlowchartController
class FlowchartController:
    root_id = 'Root'
    n_nodes = 0
    id_dict: dict[str, str] = {}  # For uAs.

    # @+others
    # @+node:ekr.20260924042054.1: *4* FlowchartController.get_flowchart_content
    def get_flowchart_content(self, headline: str) -> str:
        """Return the mermaid flowchart content corresponding to the given node."""
        root = g.findNodeAnywhere(c, headline)
        if not root:
            g.trace(f"Not found: {headline}")
            g.app.permanentScriptDict['demo'] = None
            return

        def center(s: str) -> str:
            """Center justify s in the box"""
            return f"<div style='text-align:center;'>{s.strip()}</div>"

        def left(s: str) -> str:
            """Left justify s in the box"""
            return f"<div style='text-align:left;'>{s.rstrip()}</div>"

        def body_lines(p: Position) -> list[str]:
            """Return the desired lines of p.b."""
            # For now, filter out blank lines, Leo directives, and :xxx: lines.
            return [
                z.rstrip() for z in g.splitLines(p.b)
                if z.strip() and not z.strip().startswith(('@', ':'))
            ]  # fmt: skip

        def h(p: Position) -> str:
            """
            Return the effective headline for the box corresponding to p.
            *All* references to any node must use the *same* text!
            """
            lines = body_lines(p)
            return f"{center(p.h)} <br> {left(' <br> '.join(lines))}" if lines else p.h

        def add_link(parent: Position, parent_id: str, child: Position, child_id: str) -> None:
            """Add a link line to the mermaid sources"""
            result.append(f"{ws}{parent_id}[{h(parent)}] --> {child_id}[{h(child)}]\n")

        def add_node(p: Position) -> str:
            """Add two lines to the mermaid sources that represent a node"""
            n = self.n_nodes
            new_id = 'Root' if p == root else f"Node{n}"
            self.n_nodes += 1
            self.id_dict[new_id] = p.v.gnx
            result.append(f"{ws}{new_id}[{h(p)}]\n")
            result.append(f"{ws}click {new_id} call pyCallback()\n")
            return new_id

        result = ['graph TD\n']
        ws = ' ' * 4

        def build(parent: Position, parent_id: str, p: Position) -> None:
            """Create the meraid source lines for the parent position and all its descendants"""
            p_id = add_node(p)
            if parent:
                add_link(parent, parent_id, p, p_id)
            for child in p.children():
                build(p, p_id, child)

        # Start the recursion.
        build(None, '', root)
        # g.printObj(result)
        return ''.join(result)

    # @+node:ekr.20260924040552.1: *4* FlowchartController.update_flowchart_content
    def update_flowchart_content(self, headline: str) -> str:
        self.content = self.get_flowchart_content(headline)
        # g.printObj(self.content)
        g.trace(f"{self.content.count('\n')} lines")
        return flowchart_template.replace('flowchart_content', self.content)

    # @-others


# @+node:ekr.20260925082849.1: *3* class FlowchartWebView
class FlowchartWebView(QWebEngineView):
    def __init__(self):
        super().__init__()
        self.setGeometry(50, 50, 700, 500)

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):

        g.app.permanentScriptDict[key] = None
        # Allow the window to close
        event.accept()


# @-others

key = 'flow-chart'
view = g.app.permanentScriptDict.get(key)
print(f"view? {bool(view)}")
if not view:
    g.app.permanentScriptDict[key] = view = FlowchartWebView()
controller = FlowchartController()
controller.view = view
view.setHtml(controller.update_flowchart_content('planning-root'))
view.show()
c.bodyWantsFocusNow()
# @@language python
# @+node:ekr.20260925080117.1: ** @button gantt-chart
"""Create a mermaid Gantt chart from the 'planning-root' node."""
# @+<< gantt-chart: imports >>
# @+node:ekr.20260925080838.1: *3* << gantt-chart: imports >>
import re
import textwrap
from typing import TYPE_CHECKING

from PyQt6.QtCore import QUrl
from PyQt6.QtWebEngineWidgets import QWebEngineView

from leo.core import leoGlobals as g

if TYPE_CHECKING:
    from leo.core.leoNodes import Position


# @-<< gantt-chart: imports >>
g.cls()
# @+<< define gantt_template >>
# @+node:ekr.20260925080225.1: *3* << define gantt_template >>
gantt_template = textwrap.dedent("""
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { margin: 0; padding: 20px; font-family: sans-serif; background: gray; }
    </style>
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        mermaid.initialize({ startOnLoad: true, securityLevel: 'loose' });
    </script>
</head>
<body>
    <pre class="mermaid">
        gantt_content
    </pre>
</body>
</html>
""")


# @-<< define gantt_template >>
key = 'gantt-chart'
headline = 'gantt-root'

# Define global data.
g_mermaid_task_names_to_tasks: dict[str, list[GanttTask]] = {}
g_mermaid_task_names: list[str] = []  # Set of valid mermaid tasks.
g_n_tasks = 0


# @+others
# @+node:ekr.20260927100045.1: *3* function: clean_lines
def clean_lines(p: Position) -> list[str]:
    lines = [z.strip() for z in g.splitLines(p.b) if z.strip()]
    return [z for z in lines if not z.startswith(('#', '..'))]


# @+node:ekr.20260926121726.1: *3* class GanttTask
class GanttTask:
    # :active, proto, after reqs
    after_two_names_pat = re.compile(rf"^\:(\w+)\,\s+(\w+)\,after\s+(\w+)")
    # :testing, after proto
    # :milestone, after testing
    after_one_name_pat = re.compile(rf"^\:(\w+)\,\s*after\s+(\w+)")
    # :done, research
    no_after_pat = re.compile(rf"^\:(\w+)\,\s*(\w+)")
    duration_pat = re.compile(rf"^.*?\,\s*([0-9]+)\s*[dhm]")

    # @+others
    # @+node:ekr.20260928103315.1: *4* GanttTask.__repr__
    def __repr__(self):

        def show_list(tasks: list[GanttTask], tag: str) -> str:
            if not tasks:
                return ''
            result = []
            for task in tasks:
                if task.mermaid_task_names:
                    result.append(', '.join(task.mermaid_task_names))
            return f"{tag}: [{', '.join(result)}]" if result else ''

        if self.mermaid_task_names:
            m_task_names = f"[{','.join(self.mermaid_task_names)}]"
            m_tasks_s = f" {m_task_names:12}"
        else:
            m_tasks_s = ' ' * 13
        if self.after_mermaid_task_names:
            m_after_names = f"[{','.join(self.after_mermaid_task_names)}]"
            m_after_tasks_s = f" after: {m_after_names:14}"  ### if m_after_names else ''
        else:
            m_after_tasks_s = ' ' * 22

        deps_s = show_list(self.deps, tag='deps')
        deps_s = f"{deps_s:20}"
        if self.successors:
            succ_s = show_list(self.successors, tag='successors')
        else:
            succ_s = ''
        return f"GanttTask: {self.title:>18} time: {self.duration:2} {m_tasks_s}{m_after_tasks_s}{deps_s}{succ_s}"

    # @+node:ekr.20260928131306.1: *4* GanttTask.short_repr
    def short_repr(self) -> None:
        names = self.mermaid_task_names
        tasks_s = f"[{','.join(names)}]" if names else ''
        return f"GanttTask: {self.title:>18} time: {self.duration:2} {tasks_s}"

    # @+node:ekr.20260929065811.1: *4* GanttTask: init
    def init(self):
        """GanttTask.init: handle complex initialization."""

        def add_after_name(name: str) -> None:
            if name not in self.after_mermaid_tasks:
                self.after_mermaid_task_names.append(name)

        def add_m_name(name1: str, name2: str) -> None:
            name = name2 if name1 in ('active', 'done', 'milestone') else name1
            if not name:
                return  # Not an error. The line does not define mermaid task name.
            # Update self.mermaid_task_names.
            if name not in self.mermaid_task_names:
                self.mermaid_task_names.append(name)
            # Update global mermaid_task_names list.
            if name not in g_mermaid_task_names:
                g_mermaid_task_names.append(name)
            # Update global g_mermaid_task_names_to_tasks dict.
            aList = g_mermaid_task_names_to_tasks.get(name, [])
            if self not in aList:
                aList.append(self)
                g_mermaid_task_names_to_tasks[name] = aList

        # Find mermaid task names and update data structures.
        for s in self.lines:
            if m := self.after_two_names_pat.match(s):
                name1, name2, name3 = m.group(1), m.group(2), m.group(3)
                add_m_name(name1, name2)
                add_after_name(name3)
            elif m := self.after_one_name_pat.match(s):
                name1, name2 = m.group(1), m.group(2)
                add_m_name(name1, '')
                add_after_name(name2)
            elif m := self.no_after_pat.match(s):
                name1, name2 = m.group(1), m.group(2)
                add_m_name(name1, name2)

        # Set the duration.
        self.duration = 0
        for s in self.lines:
            if m := self.duration_pat.match(s):
                self.duration = int(m.group(1))
                break

    # @-others

    def __init__(self, p: Position) -> None:

        global g_n_tasks
        self.after_mermaid_task_names: list[str] = []  # Set below.
        self.after_mermaid_tasks: list[GanttTask] = []  # Set later.
        self.lines = clean_lines(p)
        self.task_n = g_n_tasks
        g_n_tasks += 1
        self.mermaid_task_names: list[str] = []  # Set below.
        self.mermaid_tasks: list[GanttTask] = []  # Set later.
        self.p = p.copy()
        # Clean titles so they don't confuse the regex parsers.
        self.title = p.h.strip().replace(':', ' ').replace(',', ' ')

        # Dependencies...

        # deps: Tasks that this tasks depends on.
        # They must all finish before this task can start.
        self.deps = []
        # successors:Tasks that depend on *this* task.
        # This task must finish before any of these can start.
        self.successors = []

        # Metrics
        self.duration = 0
        self.es = -1  # Earliest Start
        self.ef = -1  # Earliest Finish
        self.ls = -1  # Latest Start
        self.lf = -1  # Latest Finish
        self.slack = -1

        # Complete the init.
        self.init()

        if 0 and self.lines:
            g.trace(f"{self.title:20} {self.lines}")


# @+node:ekr.20260925081852.1: *3* class GanttController
class GanttController:
    # @+others
    # @+node:ekr.20260925081852.4: *4* GanttController.get_gantt_content
    def get_gantt_content(self, headline: str) -> str:
        """Return the mermaid Gantt content corresponding to the given node."""
        root = g.findNodeAnywhere(c, headline)
        if not root:
            g.trace(f"Not found: {headline}")
            g.app.permanentScriptDict['demo'] = None
            return

        ws = ' ' * 4

        # @+others
        # @+node:ekr.20260925131750.1: *5* function: calculate_critical_path
        def calculate_critical_path(
            tasks: list[GanttTask],
            sorted_tasks: list[GanttTask],
        ) -> tuple[int, list[GanttTask]]:

            # Forward Pass: Calculate ES and EF.
            for task in sorted_tasks:
                deps = task.deps
                bad = [z.title for z in deps if z.ef == -1]
                assert not bad, bad
                task.es = max(dep.ef for dep in deps) if deps else 0
                task.ef = task.es + task.duration

            # Find total project duration.
            project_duration = max(task.ef for task in tasks)

            # Calculate successors of all tasks.
            for task in tasks:
                task.successors = [z for z in tasks if task in z.deps]

            # Backward Pass: Calculate LF and LS.
            for task in reversed(sorted_tasks):
                successors = task.successors
                bad = [z.title for z in successors if z.lf == -1]
                assert not bad, bad
                task.lf = min(z.ls for z in successors) if successors else project_duration
                task.ls = task.lf - task.duration

                # Calculate the task's slack.
                task.slack = task.lf - task.ef

            # The critical path are those tasks with zero slack.
            critical_path = [task for task in sorted_tasks if task.slack == 0]

            return project_duration, critical_path

        # @+node:ekr.20260927064540.1: *5* function: label
        def label(p: Position) -> str:
            """Create a mermaid label from p.h"""
            return ''.join(z for z in p.h.replace(' ', '-').lower() if z.isalnum())

        # @+node:ekr.20260927064542.1: *5* function: to_mermaid
        def to_mermaid(p: Position) -> list[str]:
            return [z for z in clean_lines(p) if not z.startswith('#')]

        # @+node:ekr.20260927065742.1: *5* function: make_deps
        def make_deps(root: Position, tasks: list[GanttTask]) -> None:
            """Create task.deps and task.successors for all tasks."""

            # Create all deps and successors lists for Task t.
            # t.deps:       Tasks tz that must finish *before* Task t.
            # t.successors: Tasks tz that must start *after* Task t.
            for task in tasks:
                for after_name in task.after_mermaid_task_names:
                    # g.trace(f"{task.title:<20} after: {after_name}")
                    assert after_name in g_mermaid_task_names, (
                        f"{after_name} not in {g_mermaid_task_names}"
                    )
                    after_tasks = g_mermaid_task_names_to_tasks.get(after_name)
                    for after_task in after_tasks:
                        assert isinstance(after_task, GanttTask), repr(after_task)
                        # Update task.deps.
                        if after_task not in task.deps:
                            task.deps.append(after_task)
                        # Update after_task.successors.
                        if task not in after_task.successors:
                            after_task.successors.append(task)

        # @+node:ekr.20260927064646.1: *5* function: make_mermaid
        def make_mermaid(format: str, title: str) -> list[str]:

            result = [
                'gantt\n',
                f"{ws}title {title.strip()}\n",
                f"{ws}{format}\n",
            ]
            for top_p in root.children():
                result.append(f"{ws}section {top_p.h.strip()}\n")
                for s in to_mermaid(top_p):
                    result.append(f"{ws}{ws}{top_p.h.strip()} {s}\n")
                for p in top_p.subtree():
                    lines = to_mermaid(p)
                    for s in lines:
                        result.append(f"{ws}{ws}{p.h.strip()} {s}\n")
            return result

        # @+node:ekr.20260927064818.1: *5* function: make_tasks
        def make_tasks(root) -> list[GanttTask]:
            return [GanttTask(p) for p in root.subtree()]

        # @+node:ekr.20260928132246.1: *5* function: patch_mermaid
        def patch_mermaid(tasks: list[GanttTask], result: list[str]) -> None:

            names = []
            for task in tasks:
                names.extend(task.mermaid_task_names)
            for i, s in enumerate(result):
                if any(z in s for z in names) and ':' in s:
                    result[i] = s.replace(':', ':crit, ')

        # @+node:ekr.20260929072100.1: *5* function: show_short_deps
        def show_short_deps(tasks: list[GanttTask]) -> None:

            max_n = 5

            def mermaid_name(task: GanttTask) -> str:
                """Return the mermaid task name for this task."""
                nonlocal max_n
                names = task.mermaid_task_names
                result = names[0] if names else ''
                max_n = max(max_n, len(result))
                return result

            def name(task: GanttTask) -> str:
                """Return a short name for the task."""
                return f"T{task.task_n}"

            print()
            print('Ordered tasks, with deps:')
            for task in tasks:
                s = f"{mermaid_name(task):>10} {name(task):<3} [{','.join(name(z) for z in task.deps)}]"
                print(s.replace(':>10', f":>{max_n}"))

        # @+node:ekr.20260927065200.1: *5* function: sort_tasks
        def sort_tasks(tasks: list[GanttTasks]) -> list[GanttTasks]:
            """Return an ordered list of tasks."""

            result = []
            visited = set()

            def visit(task):
                if task not in visited:
                    visited.add(task)
                    if task not in result:
                        result.append(task)
                    for dep in task.deps:
                        visit(dep)

            for task in tasks:
                visit(task)

            return result

        # @-others

        # Create tasks.
        tasks = make_tasks(root)
        if 0:
            print()
            print('Tasks...')
            for z in tasks:
                print(z)
        if 1:
            print()
            print(f"Mermaid tasks names: {', '.join(sorted(g_mermaid_task_names))}")

        # Create forward and backward dependencies.
        make_deps(root, tasks)
        if 1:
            show_short_deps(tasks)

        # Sort the tasks based on the dependencies.
        sorted_tasks = sort_tasks(tasks)
        if 0:
            print()
            print('Sorted tasks...')
            for z in sorted_tasks:
                print(z)

        # Compute Task.metrics and critical path.
        project_duration, critical_path = calculate_critical_path(tasks, sorted_tasks)
        if 1:
            print()
            print(f"Project Duration: {project_duration} days")
            print()
            print('Critical path')
            for task in critical_path:
                print(f"  {task.short_repr()}")

        # Compute mermaid text.
        root_lines = [z for z in g.splitLines(root.b) if z.strip()]
        title = root_lines[0] if root_lines else 'Unknown Project Title'
        result = make_mermaid(format='dateFormat YYYY-MM-DD', title=title)
        patch_mermaid(critical_path, result)
        if 1:
            print()
            g.printObj(result, tag='mermaid lines')
        return ''.join(result)

    # @+node:ekr.20260925081852.6: *4* GanttController.update_gantt_content
    def update_gantt_content(self, headline: str) -> str:
        self.content = self.get_gantt_content(headline)
        # g.printObj(self.content)
        g.trace(f"{self.content.count('\n')} lines")
        return gantt_template.replace('gantt_content', self.content)

    # @-others


# @+node:ekr.20260924035448.1: *3* class GanttWebView
class GanttWebView(QWebEngineView):
    def __init__(self):
        super().__init__()
        self.setGeometry(50, 50, 700, 500)

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):

        g.trace()
        g.sleep(0.1)

        g.app.permanentScriptDict[key] = None
        # Allow the window to close
        event.accept()


# @-others

controller = GanttController()
if 0:
    controller.get_gantt_content(headline)
else:
    view = g.app.permanentScriptDict.get(key)
    print(f"view? {bool(view)}")
    if not view:
        g.app.permanentScriptDict[key] = view = GanttWebView()
    controller.view = view
    view.setHtml(controller.update_gantt_content(headline))
    view.show()
    c.bodyWantsFocusNow()
# @@language python

# @-others
# @-leo
