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


# @+others
# @+node:ekr.20260926121726.1: *3* class GanttTask
class GanttTask:
    def __init__(self, gnx: str, id_: str, name: str, p: Position) -> None:
        self.gnx = gnx
        self.id_ = id_
        self.name = name
        self.position = p

        self.duration = 0
        # deps: Tasks that this tasks depends on.
        # They must all finish before this task can start.
        self.deps = []
        # successors:Tasks that depend on *this* task.
        # This task must finish before any of these can start.
        self.successors = []

        # Metrics
        self.es = -1  # Earliest Start
        self.ef = -1  # Earliest Finish
        self.ls = -1  # Latest Start
        self.lf = -1  # Latest Finish
        self.slack = -1

    def __repr__(self):
        id_, name = self.id_, self.name
        return f"GanttTask: id: {id_:6} name: {name}"


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
        result = [
            'gantt\n',
            f"{ws}title Product Launch Plan\n",
            f"{ws}dateFormat YYYY-MM-DD\n",
        ]

        # Define global data.
        d_gnx_to_task: dict[str, GanttTask] = {}
        d_id_to_task: dict[str, GanttTask] = {}  # Keys are task id_'s.
        d_task_to_deps: dict[str, list[GanttTask]] = {}  # Keys are task id_'s.
        d_task_to_succs: dict[str, list[GanttTask]] = {}  # Keys are task id_'s.
        tasks = []
        sorted_tasks = []
        n_tasks = 0

        # @+others
        # @+node:ekr.20260925131750.1: *5* function: calculate_critical_path
        def calculate_critical_path(
            tasks: list[GanttTask],
            sorted_tasks: list[GanttTask],
        ) -> tuple[int, list[GanttTask]]:

            # Forward Pass: Calculate ES and EF.
            for task in sorted_tasks:
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

            # Backward Pass: Calculate LF and LS.
            for task in reversed(sorted_tasks):
                successors = task.successors
                bad = [z.name for z in successors if z.lf == -1]
                assert not bad, bad
                task.lf = min(z.ls for z in successors) if successors else project_duration
                task.ls = task.lf - task.duration

                # Calculate the task's slack.
                task.slack = task.lf - task.ef

            # The critical path are those tasks with zero slack.
            critical_path = [task.name for task in sorted_tasks if task.slack == 0]

            return project_duration, critical_path

        # @+node:ekr.20260927064540.1: *5* function: label
        def label(p: Position) -> str:
            """Create a mermaid label from p.h"""
            return ''.join(z for z in p.h.replace(' ', '-').lower() if z.isalnum())

        # @+node:ekr.20260927064542.1: *5* function: to_mermaid
        def to_mermaid(p: Position) -> list[str]:
            lines = [z.strip() for z in g.splitLines(p.b)]
            lines = [z for z in lines if z and not z.startswith('#')]
            # Maybe? Add label?
            return lines

        # @+node:ekr.20260927065742.1: *5* function: make_deps
        def make_deps(root: Position, tasks: list[GanttTask]) -> None:
            pass  ###

        # @+node:ekr.20260927064646.1: *5* function: make_mermaid
        def make_mermaid(result: list[str]) -> None:
            for top_p in root.children():
                result.append(f"{ws}section {top_p.h.strip()}\n")
                for s in to_mermaid(top_p):
                    result.append(f"{ws}{ws}{s}\n")
                for p in top_p.subtree():
                    if lines := to_mermaid(p):
                        # Prepend p.h to the first line.
                        result.append(f"{ws}{ws}{p.h.strip()} {lines[0]}\n")
                        # All all other descendant lines.
                        for s in lines[1:]:
                            result.append(f"{ws}{ws}{s}\n")

        # @+node:ekr.20260927064818.1: *5* function: make_tasks
        def make_tasks(root) -> None:

            nonlocal n_tasks
            for p in root.subtree():
                n_tasks += 1
                id_ = f"task{n_tasks}"
                task = GanttTask(gnx=p.v.gnx, id_=id_, name=p.h.strip(), p=p.copy())
                tasks.append(task)
                d_gnx_to_task[p.v.gnx] = task
                d_id_to_task[id_] = task

        # @+node:ekr.20260927065200.1: *5* function: sort_tasks
        def sort_tasks(tasks) -> list[GanttTasks]:
            """Return an ordered list of tasks."""
            result = []
            visited = set()

            def visit(task):
                if task not in visited:
                    for dep in task.deps:
                        visit(dep)
                    visited.add(task)
                    result.append(task)

            for task in tasks:
                visit(task)

            return result

        # @-others

        # Create tasks.
        make_tasks(root)
        if 0:
            for task in tasks:
                print(task)

        # Create forward and backward dependencies.
        make_deps(root, tasks)
        if 1:
            print('Ordered tasks, with deps:')
            for z in sorted_tasks:
                print(f"{z.name} [{','.join(z2.name for z2 in z.deps)}]")
            print()
            print('Reversed ordered tasks, with successors:')
            for z in reversed(sorted_tasks):
                print(f"{z.name} [{','.join(z2.name for z2 in z.successors)}]")
            print()

        # Sort the tasks based on the dependencies.
        sorted_tasks = sort_tasks(tasks)
        if 1:
            for task in sorted_tasks:
                print(task)

        # Compute Task.metrics and critical path.
        project_duration, critical_path = calculate_critical_path(tasks, sorted_tasks)
        if 1:
            print()
            print(f"Project Duration: {project_duration} days")
            print(f"Critical Path: {' -> '.join(critical_path)}")
            print()

        # Pass 4: Compute mermaid text.
        make_mermaid(result)
        g.printObj(result)
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

        g.app.permanentScriptDict[key] = None
        # Allow the window to close
        event.accept()


# @-others

view = g.app.permanentScriptDict.get(key)
print(f"view? {bool(view)}")
if not view:
    g.app.permanentScriptDict[key] = view = GanttWebView()
controller = GanttController()
controller.view = view
view.setHtml(controller.update_gantt_content('gantt-root'))
view.show()
c.bodyWantsFocusNow()
# @@language python

# @-others
# @-leo
