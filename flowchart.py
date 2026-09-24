# @+leo-ver=5-thin
# @+node:ekr.20260924114930.1: * @file flowchart.py
# @@language python

# @+others
# @+node:ekr.20260922175054.5: ** @button flow-chart
# @@language python

"""Mermaid demo"""

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
# @+<< create the webchannel script >>
# @+node:ekr.20260922175054.9: *3* << create the webchannel script >>
# Bypass Chromium origin restrictions.
js_file = QFile(":/qtwebchannel/qwebchannel.js")
if not js_file.open(QIODevice.OpenModeFlag.ReadOnly):
    raise RuntimeError("Failed to locate qwebchannel.js within Qt resources.")

# The html references this script.
webchannel_script = js_file.readAll().data().decode('utf-8')
# @-<< create the webchannel script >>
# @+<< define html_template >>
# @+node:ekr.20260924040355.3: *3* << define html_template >>
html_template = """
    <!DOCTYPE html>
    <html>
    <head>
        <!-- Inline Qt WebChannel Script -->
        <script>webchannel_script</script>

        <script type="module">
            import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
            mermaid.initialize({ startOnLoad: true, securityLevel: 'loose' });
            
            // Explicitly attach to the global namespace
            window.mermaid = mermaid;
        </script>

    </head>
    <body>
        <div class="mermaid">
            mermaid_content
        </div>

        <script>
        
        window.pyCallback = function(nodeId) {
            if (window.pythonBackend) {
                window.pythonBackend.node_clicked(nodeId);
            } else {
                // console.error("IPC bridge not ready. 2");
            }
        };

        document.addEventListener("DOMContentLoaded", function() {
            if (typeof qt !== 'undefined' && qt.webChannelTransport) {
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    window.pythonBackend = channel.objects.mermaid_bridge;
                });
            }
        });

        window.pyCallback = function(nodeId) {
            if (!window.pythonBackend) {
                // console.error("IPC bridge not ready. 3");
                return;
            }

            let labelText = "Label Extraction Failed";

            // 1. Locate all rendered flowchart nodes
            let svgNodes = document.querySelectorAll('.node');

            // 2. Iterate to find the exact node ID match
            for (let i = 0; i < svgNodes.length; i++) {
                let svgNode = svgNodes[i];

                // Split the dynamically generated DOM ID on hyphens. 
                // This prevents false substring matches (e.g., node "A" matching node "AB").
                let idSegments = svgNode.id.split('-');

                if (svgNode.id === nodeId || idSegments.includes(nodeId)) {
                    // 3. Target the specific class Mermaid assigns to HTML labels
                    let labelElement = svgNode.querySelector('.nodeLabel');

                    if (labelElement) {
                        // Extract purely the text, stripping any embedded HTML
                        labelText = labelElement.textContent || labelElement.innerText;

                        // Mermaid sometimes injects extraneous whitespace/newlines into labels
                        labelText = labelText.trim();
                    }
                    break;
                }
            }

            // 4. Pass the dual-argument payload to Python
            window.pythonBackend.node_clicked(nodeId, labelText);
        };

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
                console.error("Mermaid re-render failed:", error);
            }
        };
        </script>
    </body>
    </html>
    """
# @-<< define html_template >>


# @+others
# @+node:ekr.20260924040355.1: *3* class LeoController
class LeoController:
    # @+<< define content >>
    # @+node:ekr.20260924040355.2: *4* << define content >>
    content = textwrap.dedent("""
    graph TD
        Root[Root]
        click Root call pyCallback()
    """).lstrip()
    # @-<< define content >>
    root_id = 'Root'
    n_nodes = 0
    id_dict: dict[str, str] = {}  # For uAs.
    moving = False

    def __init__(self, c: Cmdr) -> None:
        self.c = c

    # @+others
    # @+node:ekr.20260924042054.1: *4* LC.get_content
    def get_content(self) -> str:
        """Return the mermaid content corresponding to the 'planning-root' node."""
        h = 'planning-root'
        root = g.findNodeAnywhere(c, h)
        if not root:
            g.trace(f"Not found: {h}")
            g.app.permanentScriptDict['demo'] = None
            return

        result = ['graph TD\n']

        def add_link(parent_id: str, parent_h: str, child_id: str, child_h: str) -> None:
            result.append(f"    {parent_id}[{parent_h}] --> {child_id}[{child_h}]\n")

        def add_node(p: Position) -> str:
            n = self.n_nodes
            new_id = 'Root' if p == root else f"Node{n}"
            self.n_nodes += 1
            self.id_dict[new_id] = p.v.gnx
            result.append(f"    {new_id}[{p.h}]\n")
            result.append(f"    click {new_id} call pyCallback()\n")
            return new_id

        def build(parent: Position, parent_id: str, p: Position) -> None:
            p_id = add_node(p)
            if parent:
                add_link(parent_id, parent.h, p_id, p.h)
            for child in p.children():
                build(p, p_id, child)

        build(None, '', root)
        # g.printObj(result)
        return ''.join(result)

    # @+node:ekr.20260924040552.1: *4* LC.update_content
    def update_content(self) -> str:
        self.content = self.get_content()
        # g.printObj(self.content)
        g.trace(f"{self.content.count('\n')} lines")
        return html_template.replace('webchannel_script', webchannel_script).replace(
            'mermaid_content', self.content
        )

    # @-others


# @+node:ekr.20260924035448.1: *3* class MermaidWebView
class MermaidWebView(QWebEngineView):
    def __init__(self):
        super().__init__()
        self.setGeometry(50, 50, 700, 500)

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):

        g.app.permanentScriptDict['demo'] = None
        # Allow the window to close
        event.accept()


# @-others

view = g.app.permanentScriptDict.get('demo')
print(f"view? {bool(view)}")
if not view:
    g.app.permanentScriptDict['demo'] = view = MermaidWebView()
controller = LeoController(c)
controller.view = view
view.setHtml(controller.update_content())
view.show()
c.bodyWantsFocusNow()
# @-others
# @-leo
