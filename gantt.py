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
