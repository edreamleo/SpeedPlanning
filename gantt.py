# @+leo-ver=5-thin
# @+node:ekr.20260925080314.1: * @file gantt.py
"""gantt.py: The code for @button gantt-chart."""

# @@language python
# @+others
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
gantt_template = """
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
        
        // Explicitly attach to the global namespace
        window.mermaid = mermaid;
    </script>
</head>
<body>
    <pre class="mermaid">
        gantt_content
    </pre>
    
    <script>
    window.reRenderGraph = async function(newGraphText) {
        const container = document.querySelector('.mermaid');
        try {
            // 1. Revert the container strictly to raw text, destroying the old SVG
            container.textContent = newGraphText;

            // 2. Remove the internal flag that prevents Mermaid from re-processing the div
            container.removeAttribute('data-processed');

            // 3. Trigger the native rendering pipeline on the specific container
            await window.mermaid.run({
                nodes: [container]
            });

        } catch (error) {
            console.error("Gantt re-render failed:", error);
        }
    };
    </script>
</body>
</html>
"""


# @-<< define gantt_template >>
# @+others
# @+node:ekr.20260925081852.1: *3* class GanttController
class GanttController:
    # @+others
    # @+node:ekr.20260925081852.4: *4* LC.get_gantt_content (to do)
    def get_gantt_content(self, headline: str) -> str:
        """Return the mermaid Gantt content corresponding to the given node."""
        if 1:  ### Temp.
            return textwrap.dedent("""
                gantt
                    title Product Launch Plan
                    dateFormat YYYY-MM-DD
                    section Planning
                        Market research      :done, research, 2024-03-01, 10d
                        Define requirements  :done, reqs, after research, 7d
                    section Build
                        Design prototype     :active, proto, after reqs, 14d
                        User testing         :testing, after proto, 7d
                    section Launch
                        Marketing campaign   :marketing, after proto, 14d
                        Release day          :milestone, after testing, 0d
            """).lstrip()

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

    # @+node:ekr.20260925081852.6: *4* LC.update_gantt_content
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
view.setHtml(controller.update_gantt_content('planning-root'))
view.show()
c.bodyWantsFocusNow()
# @@language python

# @-others
# @-leo
