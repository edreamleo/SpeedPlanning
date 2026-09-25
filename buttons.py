# @+leo-ver=5-thin
# @+node:ekr.20260925173401.1: * @file buttons.py
"""critical_path.py: The code for all buttons"""

# @@language python
# @+others
# @+node:ekr.20260923130208.1: ** @button critical-path
"""Critical path algorithm"""

g.cls()


# @+others
# @+node:ekr.20260925131747.1: *3* class Task
class Task:
    def __init__(self, name: str, duration: int) -> None:
        self.name = name
        self.duration = duration
        self.deps = []  # Dependencies

        # CPM Metrics
        self.es = 0  # Early Start
        self.ef = 0  # Early Finish
        self.ls = 0  # Late Start
        self.lf = 0  # Late Finish
        self.slack = 0

    def __repr__(self):
        pad2 = ' ' * 2
        pad3 = ' ' * 3
        return (
            f"{pad2}{self.name}{pad3}{self.es:2}{pad2}{self.ef:2}"
            f"{pad2}{self.ls:2}{pad2}{self.lf:2}{pad3}{self.slack:2}"
        )


# @+node:ekr.20260925131750.1: *3* calculate_critical_path
def calculate_critical_path(tasks):

    # Visit dependencies first.
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

    # Forward Pass: Calculate ES and EF.
    for task in ordered_tasks:
        if not task.deps:
            task.es = 0
        else:
            task.es = max(dep.ef for dep in task.deps)
        task.ef = task.es + task.duration

    # Find total project duration
    project_duration = max(task.ef for task in ordered_tasks)

    # Backward Pass: Calculate LF and LS
    # Visit tasks in reverse the topological order.
    for task in reversed(ordered_tasks):
        # Find which tasks depend on the current task
        successors = [t for t in ordered_tasks if task in t.deps]
        if not successors:
            task.lf = project_duration
        else:
            task.lf = min(succ.ls for succ in successors)
        task.ls = task.lf - task.duration

        # Calculate slack.
        task.slack = task.lf - task.ef

    # The critical path are those tasks with zero slack.
    critical_path = [task.name for task in ordered_tasks if task.slack == 0]

    return project_duration, critical_path


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
print(f"Total Project Duration: {duration} days\n")
pad = ' ' * 2
print(f"Task{pad}ES{pad}EF{pad}LS{pad}LF{pad}Slack")
for task in tasks:
    print(task)
print(f"\nCritical Path: {' -> '.join(path)}")

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

from PyQt6.QtCore import QUrl
from PyQt6.QtWebEngineWidgets import QWebEngineView

from leo.core import leoGlobals as g

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
# @+others
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
        for p in root.subtree():
            result.append(f"{ws}section {p.h.strip()}\n")
            lines = [z.strip() for z in g.splitLines(p.b) if z.strip()]
            for s in lines:
                result.append(f"{ws}{ws}{s}\n")

        # g.printObj(result)
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

key = 'gantt-chart'
view = g.app.permanentScriptDict.get(key)
print(f"view? {bool(view)}")
if not view:
    g.app.permanentScriptDict['gantt-chart'] = view = GanttWebView()
controller = GanttController()
controller.view = view
view.setHtml(controller.update_gantt_content('gantt-root'))
view.show()
c.bodyWantsFocusNow()
# @@language python

# @-others
# @-leo
