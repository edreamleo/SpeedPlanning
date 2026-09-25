<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: https://leo-editor.github.io/leo-editor/leo_toc.html -->
<leo_file xmlns:leo="https://leo-editor.github.io/leo-editor/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2"/>
<globals/>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="ekr.20260923042416.1"><vh>Startup</vh>
<v t="ekr.20260923042755.1"><vh>@settings</vh>
<v t="ekr.20260923042704.1"><vh>@data history-list</vh></v>
<v t="ekr.20260924121154.1"><vh>Beautifying files</vh>
<v t="ekr.20260924121154.2"><vh>@bool beautify-python-code-on-write = True</vh></v>
<v t="ekr.20260924121154.3"><vh>@int black-line-length = 100</vh></v>
<v t="ekr.20260924121154.4"><vh>@string black-toml = None</vh></v>
</v>
</v>
<v t="ekr.20260923042421.1"><vh>@button backup</vh></v>
<v t="ekr.20260924050522.1"><vh>@button kill-flow-chart</vh></v>
<v t="ekr.20260925084334.1"><vh>@button kill-gantt-chart</vh></v>
</v>
<v t="ekr.20260925080653.1"><vh>Files...</vh>
<v t="ekr.20260924114454.1"><vh>@file attic.txt</vh></v>
<v t="ekr.20260924114930.1"><vh>@file flowchart.py</vh></v>
<v t="ekr.20260925080314.1"><vh>@file gantt.py</vh></v>
<v t="ekr.20260924115347.1"><vh>@file notes.txt</vh></v>
<v t="ekr.20260924114633.1"><vh>@file planning_root.txt</vh></v>
</v>
<v t="ekr.20260924042736.1"><vh>planning-root</vh>
<v t="ekr.20260924042736.2"><vh>Section: steel</vh></v>
<v t="ekr.20260924042736.3"><vh>Lane: software engineers</vh></v>
<v t="ekr.20260924042736.4"><vh>Group</vh>
<v t="ekr.20260924042736.5"><vh>Task 1</vh>
<v t="ekr.20260924042736.6"><vh>Task 1.1</vh></v>
<v t="ekr.20260924163445.1"><vh>Task 1.2</vh></v>
</v>
<v t="ekr.20260924042736.7"><vh>Task 2</vh></v>
</v>
</v>
<v t="ekr.20260922175054.5"><vh>@button flow-chart</vh>
<v t="ekr.20260922175054.6"><vh>&lt;&lt; flow-chart: imports &gt;&gt;</vh></v>
<v t="ekr.20260924040355.3"><vh>&lt;&lt; define flowchart template &gt;&gt;</vh></v>
<v t="ekr.20260924040355.1"><vh>class FlowchartController</vh>
<v t="ekr.20260924040355.2"><vh>&lt;&lt; define content &gt;&gt;</vh></v>
<v t="ekr.20260924042054.1"><vh>LC.get_flowchart_content</vh></v>
<v t="ekr.20260924040552.1"><vh>LC.update_flowchart_content</vh></v>
</v>
<v t="ekr.20260925082849.1"><vh>class FlowchartWebView</vh></v>
</v>
<v t="ekr.20260925080117.1"><vh>@button gantt-chart</vh>
<v t="ekr.20260925080838.1"><vh>&lt;&lt; gantt-chart: imports &gt;&gt;</vh></v>
<v t="ekr.20260925080225.1"><vh>&lt;&lt; define gantt_template &gt;&gt;</vh></v>
<v t="ekr.20260925081852.1"><vh>class GanttController</vh>
<v t="ekr.20260925081852.4"><vh>LC.get_gantt_content (to do)</vh></v>
<v t="ekr.20260925081852.6"><vh>LC.update_gantt_content</vh></v>
</v>
<v t="ekr.20260924035448.1"><vh>class GanttWebView</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="ekr.20260922175054.5">"""Create a mermaid flowchart from the 'planning-root' node."""
&lt;&lt; flow-chart: imports &gt;&gt;
g.cls()
&lt;&lt; define flowchart template &gt;&gt;
@others

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
@language python
</t>
<t tx="ekr.20260922175054.6">import re
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


</t>
<t tx="ekr.20260923042416.1"></t>
<t tx="ekr.20260923042421.1">"""
Back up this .leo file.

os.environ['LEO_BACKUP'] must be the path to an existing (writable) directory.
"""
c.backup_helper(sub_dir='SpeedPlanning')

@language python
</t>
<t tx="ekr.20260923042704.1">gantt-chart
flow-chart</t>
<t tx="ekr.20260923042755.1"></t>
<t tx="ekr.20260924035448.1">class GanttWebView(QWebEngineView):
    def __init__(self):
        super().__init__()
        self.setGeometry(50, 50, 700, 500)

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):

        g.app.permanentScriptDict[key] = None
        # Allow the window to close
        event.accept()


</t>
<t tx="ekr.20260924040355.1">class FlowchartController:
    &lt;&lt; define content &gt;&gt;
    root_id = 'Root'
    n_nodes = 0
    id_dict: dict[str, str] = {}  # For uAs.

    @others


</t>
<t tx="ekr.20260924040355.2">content = textwrap.dedent("""
graph TD
    Root[Root]
    click Root call pyCallback()
""").lstrip()
</t>
<t tx="ekr.20260924040355.3">html_template = """
    &lt;!DOCTYPE html&gt;
    &lt;html&gt;
    &lt;head&gt;
        &lt;!-- Inline Qt WebChannel Script --&gt;
        &lt;script&gt;webchannel_script&lt;/script&gt;

        &lt;script type="module"&gt;
            import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
            mermaid.initialize({ startOnLoad: true, securityLevel: 'loose' });
            
            // Explicitly attach to the global namespace
            window.mermaid = mermaid;
        &lt;/script&gt;

    &lt;/head&gt;
    &lt;body&gt;
        &lt;div class="mermaid"&gt;
            flowchart_content
        &lt;/div&gt;

        &lt;script&gt;
        
        window.pyCallback = function(nodeId) {
            if (window.pythonBackend) {
                window.pythonBackend.node_clicked(nodeId);
            } else {
                // console.error("IPC bridge not ready. 2");
            }
        };

        document.addEventListener("DOMContentLoaded", function() {
            if (typeof qt !== 'undefined' &amp;&amp; qt.webChannelTransport) {
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
            for (let i = 0; i &lt; svgNodes.length; i++) {
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
        &lt;/script&gt;
    &lt;/body&gt;
    &lt;/html&gt;
    """


</t>
<t tx="ekr.20260924040552.1">def update_flowchart_content(self, headline: str) -&gt; str:
    self.content = self.get_flowchart_content(headline)
    # g.printObj(self.content)
    g.trace(f"{self.content.count('\n')} lines")
    return html_template.replace('flowchart_content', self.content)

</t>
<t tx="ekr.20260924042054.1">def get_flowchart_content(self, headline: str) -&gt; str:
    """Return the mermaid flowchart content corresponding to the given node."""
    root = g.findNodeAnywhere(c, headline)
    if not root:
        g.trace(f"Not found: {headline}")
        g.app.permanentScriptDict['demo'] = None
        return

    def center(s: str) -&gt; str:
        """Center justify s in the box"""
        return f"&lt;div style='text-align:center;'&gt;{s.strip()}&lt;/div&gt;"

    def left(s: str) -&gt; str:
        """Left justify s in the box"""
        return f"&lt;div style='text-align:left;'&gt;{s.rstrip()}&lt;/div&gt;"

    def body_lines(p: Position) -&gt; list[str]:
        """Return the desired lines of p.b."""
        # For now, filter out blank lines, Leo directives, and :xxx: lines.
        return [
            z.rstrip() for z in g.splitLines(p.b)
            if z.strip() and not z.strip().startswith(('@', ':'))
        ]  # fmt: skip

    def h(p: Position) -&gt; str:
        """
        Return the effective headline for the box corresponding to p.
        *All* references to any node must use the *same* text!
        """
        lines = body_lines(p)
        return f"{center(p.h)} &lt;br&gt; {left(' &lt;br&gt; '.join(lines))}" if lines else p.h

    def add_link(parent: Position, parent_id: str, child: Position, child_id: str) -&gt; None:
        """Add a link line to the mermaid sources"""
        result.append(f"{ws}{parent_id}[{h(parent)}] --&gt; {child_id}[{h(child)}]\n")

    def add_node(p: Position) -&gt; str:
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

    def build(parent: Position, parent_id: str, p: Position) -&gt; None:
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

</t>
<t tx="ekr.20260924042736.1">@language rest
@wrap

</t>
<t tx="ekr.20260924042736.2">Line 1
</t>
<t tx="ekr.20260924042736.3"></t>
<t tx="ekr.20260924042736.4">Group text
</t>
<t tx="ekr.20260924042736.5">:task: Two cases of toner.

:name: Jack T. Ripper

:time: 20 days.

:cost: 

</t>
<t tx="ekr.20260924042736.6"></t>
<t tx="ekr.20260924042736.7"></t>
<t tx="ekr.20260924050522.1">g.app.permanentScriptDict['flow-chart'] = None</t>
<t tx="ekr.20260924121154.1"># These settings control ruff format, which is compatible with black.</t>
<t tx="ekr.20260924121154.2"># True: beautify all @&lt;file&gt; nodes in the outline using Leo's token-based beautifier.
# True can result in much slower writes.</t>
<t tx="ekr.20260924121154.3"># This setting overrides any value in pyproject.toml or ruff.toml
# Leo uses 120 for its own files.</t>
<t tx="ekr.20260924121154.4"># If given, this argument should be a full, absolute path to pyproject.toml or ruff.toml.
# If not given, Leo's beautifier uses Leo's pyproject.toml file.
</t>
<t tx="ekr.20260924163445.1"></t>
<t tx="ekr.20260925080117.1">"""Create a mermaid Gantt chart from the 'planning-root' node."""
&lt;&lt; gantt-chart: imports &gt;&gt;
g.cls()
&lt;&lt; define gantt_template &gt;&gt;
@others

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

# view = QWebEngineView()
# view.setHtml(html_content, QUrl("http://localhost"))
# view.resize(800, 400)
# view.show()
# g.app.scriptDict['demo'] = view
@language python

</t>
<t tx="ekr.20260925080225.1">gantt_template = """
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    &lt;meta charset="UTF-8"&gt;
    &lt;style&gt;
        body { margin: 0; padding: 20px; font-family: sans-serif; background: gray; }
    &lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;

    &lt;pre class="mermaid"&gt;
        gantt_content
    &lt;/pre&gt;

    &lt;script type="module"&gt;
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
        
        mermaid.initialize({ 
            startOnLoad: false, // Prevents premature parsing race conditions
            securityLevel: 'loose' 
        });
        
        // Explicitly trigger parsing once everything is mounted
        document.addEventListener('DOMContentLoaded', async () =&gt; {
            await mermaid.run();
        });
    &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
"""


</t>
<t tx="ekr.20260925080653.1"></t>
<t tx="ekr.20260925080838.1">import textwrap

from PyQt6.QtCore import QUrl
from PyQt6.QtWebEngineWidgets import QWebEngineView

from leo.core import leoGlobals as g

</t>
<t tx="ekr.20260925081852.1">class GanttController:
    @others


</t>
<t tx="ekr.20260925081852.4">def get_gantt_content(self, headline: str) -&gt; str:
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

    def center(s: str) -&gt; str:
        """Center justify s in the box"""
        return f"&lt;div style='text-align:center;'&gt;{s.strip()}&lt;/div&gt;"

    def left(s: str) -&gt; str:
        """Left justify s in the box"""
        return f"&lt;div style='text-align:left;'&gt;{s.rstrip()}&lt;/div&gt;"

    def body_lines(p: Position) -&gt; list[str]:
        """Return the desired lines of p.b."""
        # For now, filter out blank lines, Leo directives, and :xxx: lines.
        return [
            z.rstrip() for z in g.splitLines(p.b)
            if z.strip() and not z.strip().startswith(('@', ':'))
        ]  # fmt: skip

    def h(p: Position) -&gt; str:
        """
        Return the effective headline for the box corresponding to p.
        *All* references to any node must use the *same* text!
        """
        lines = body_lines(p)
        return f"{center(p.h)} &lt;br&gt; {left(' &lt;br&gt; '.join(lines))}" if lines else p.h

    def add_link(parent: Position, parent_id: str, child: Position, child_id: str) -&gt; None:
        """Add a link line to the mermaid sources"""
        result.append(f"{ws}{parent_id}[{h(parent)}] --&gt; {child_id}[{h(child)}]\n")

    def add_node(p: Position) -&gt; str:
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

    def build(parent: Position, parent_id: str, p: Position) -&gt; None:
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

</t>
<t tx="ekr.20260925081852.6">def update_gantt_content(self, headline: str) -&gt; str:
    self.content = self.get_gantt_content(headline)
    # g.printObj(self.content)
    g.trace(f"{self.content.count('\n')} lines")
    return gantt_template.replace('gantt_content', self.content)

</t>
<t tx="ekr.20260925082849.1">class FlowchartWebView(QWebEngineView):
    def __init__(self):
        super().__init__()
        self.setGeometry(50, 50, 700, 500)

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):

        g.app.permanentScriptDict[key] = None
        # Allow the window to close
        event.accept()


</t>
<t tx="ekr.20260925084334.1">g.app.permanentScriptDict['gantt-chart'] = None</t>
</tnodes>
</leo_file>
