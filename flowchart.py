# @+leo-ver=5-thin
# @+node:ekr.20260924114930.1: * @file flowchart.py
"""flowchart.py: The code for @button flow-chart."""

# @@language python
# @+others
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
# @-others
# @-leo
