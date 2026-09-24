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
</v>
<v t="ekr.20260923042421.1"><vh>@button backup</vh></v>
<v t="ekr.20260924050522.1"><vh>@button kill-flow-chart</vh></v>
</v>
<v t="ekr.20260924081724.1"><vh>Attic</vh>
<v t="ekr.20260922175054.8"><vh>class Controller</vh>
<v t="ekr.20260923044849.1"><vh>&lt;&lt; define content &gt;&gt;</vh></v>
<v t="ekr.20260923040212.1"><vh>&lt;&lt; define html_template &gt;&gt;</vh></v>
<v t="ekr.20260923132125.1"><vh>Controller.get_new_id</vh></v>
<v t="ekr.20260923041012.1"><vh>Controller.delete_node</vh></v>
<v t="ekr.20260923041013.1"><vh>Controller.insert_node</vh></v>
<v t="ekr.20260923162300.1"><vh>Controller.move_node &amp; move_node2</vh></v>
<v t="ekr.20260923042146.1"><vh>Controller.refresh</vh></v>
<v t="ekr.20260923171237.1"><vh>Controller.rename_dialog</vh></v>
<v t="ekr.20260923130657.1"><vh>Controller.rename_node</vh></v>
<v t="ekr.20260922175054.10"><vh>Controller.update_content</vh></v>
</v>
<v t="ekr.20260924081809.1"><vh>COPY: &lt;&lt; define html_template &gt;&gt;</vh></v>
<v t="ekr.20260924082334.1"><vh>COPY: class MermaidEventHandler</vh></v>
<v t="ekr.20260924082503.1"><vh>COPY: class LeoController</vh>
<v t="ekr.20260924082503.2"><vh>&lt;&lt; define content &gt;&gt;</vh></v>
<v t="ekr.20260924082503.3"><vh>&lt;&lt; define html_template &gt;&gt;</vh></v>
<v t="ekr.20260924082503.4"><vh>LC.delete_node</vh></v>
<v t="ekr.20260924082503.5"><vh>LC.get_content</vh></v>
<v t="ekr.20260924082503.6"><vh>LC.get_new_id</vh></v>
<v t="ekr.20260924082503.7"><vh>LC.insert_node</vh></v>
<v t="ekr.20260924082503.8"><vh>LC.move_node &amp; move_node2</vh></v>
<v t="ekr.20260924082503.9"><vh>LC.refresh</vh></v>
<v t="ekr.20260924082503.10"><vh>LC.rename_dialog</vh></v>
<v t="ekr.20260924082503.11"><vh>LC.rename_node</vh></v>
<v t="ekr.20260924082503.12"><vh>LC.update_content</vh></v>
</v>
</v>
<v t="ekr.20260922175054.1"><vh>Notes (do not delete)</vh>
<v t="ekr.20260923035124.1"><vh> To do</vh></v>
<v t="ekr.20260922175054.2"><vh>CPM algorithm</vh></v>
<v t="ekr.20260923130208.1"><vh>Critical path algorithm</vh></v>
<v t="ekr.20260922175054.3"><vh>Works: mermaid gantt in Qt</vh>
<v t="ekr.20260922175054.4"><vh>&lt;&lt; define content &gt;&gt;</vh></v>
</v>
</v>
<v t="ekr.20260924042736.1"><vh>planning-root</vh>
<v t="ekr.20260924042736.2"><vh>@section: steel</vh></v>
<v t="ekr.20260924042736.3"><vh>@lane: software engineers</vh></v>
<v t="ekr.20260924042736.4"><vh>@task blah blah</vh>
<v t="ekr.20260924042736.5"><vh>@task: buy tone: ne</vh>
<v t="ekr.20260924042736.6"><vh>@square</vh></v>
</v>
<v t="ekr.20260924042736.7"><vh>@square: s</vh></v>
<v t="ekr.20260924042736.8"><vh>@sqaure: se</vh></v>
<v t="ekr.20260924042736.9"><vh>@square: sw</vh></v>
</v>
</v>
<v t="ekr.20260924082951.1"><vh>=== recent</vh>
<v t="ekr.20260924040355.3"><vh>&lt;&lt; define html_template &gt;&gt;</vh></v>
<v t="ekr.20260924040355.1"><vh>class LeoController</vh>
<v t="ekr.20260924040355.2"><vh>&lt;&lt; define content &gt;&gt;</vh></v>
<v t="ekr.20260924042054.1"><vh>LC.get_content</vh></v>
<v t="ekr.20260924040552.1"><vh>LC.update_content</vh></v>
</v>
<v t="ekr.20260924040552.1"></v>
</v>
<v t="ekr.20260922175054.5"><vh>@command flow-chart</vh>
<v t="ekr.20260922175054.6"><vh>&lt;&lt; flow-chart: imports &gt;&gt;</vh></v>
<v t="ekr.20260922175054.9"><vh>&lt;&lt; create the webchannel script &gt;&gt;</vh></v>
<v t="ekr.20260924040355.3"></v>
<v t="ekr.20260924040355.1"></v>
<v t="ekr.20260924035448.1"><vh>class MermaidWebView</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="ekr.20260922175054.1"># Qt WebEngine is based on the open-source Chromium project and
# uses the Blink rendering engine.

# All code based on this gemini conversation:
# https://share.gemini.google/pyz22WW3idU7</t>
<t tx="ekr.20260922175054.10">def update_content(self, new_content: str = '') -&gt; str:
    
    if new_content:
        self.content = new_content
    return (
        self.html_template
        .replace('webchannel_script', webchannel_script)
        .replace('mermaid_content', self.content)
    )
</t>
<t tx="ekr.20260922175054.2">@language rest
@wrap

Google: critical path method algorithm

The critical path algorithm (Critical Path Method or CPM) is a step-by-step project management technique that finds the longest sequence of dependent tasks to determine the shortest possible project duration.

=== How the Algorithm Works

The algorithm uses a network diagram to map project activities, their durations, and their dependencies. It runs through four main phases:

**Forward Pass**: Moves from start to finish to calculate the Earliest Start (ES) and Earliest Finish (EF) times for each task (EF = ES + duration).

**Backward Pass**: Moves from the project end date back to the start to calculate the Latest Start (LS) and Latest Finish (LF) times (LS = LF - duration).

**Float Calculation**: Finds the slack or buffer time for each task using the formula: Float = LS - ES (or LF - EF).

**Path Identification**: Identifies the continuous chain of tasks that have zero float, which forms the critical path. Any delay on this path delays the entire project.</t>
<t tx="ekr.20260922175054.3">from PyQt6.QtCore import QUrl
from PyQt6.QtWebEngineWidgets import QWebEngineView

&lt;&lt; define content &gt;&gt;

view = QWebEngineView()
view.setHtml(html_content, QUrl("http://localhost"))
view.resize(800, 400)
view.show()
g.app.scriptDict['demo'] = view

</t>
<t tx="ekr.20260922175054.4">html_content = """
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
<t tx="ekr.20260922175054.5">@language python

"""Mermaid demo"""

&lt;&lt; flow-chart: imports &gt;&gt;
g.cls()
&lt;&lt; create the webchannel script &gt;&gt;
&lt;&lt; define html_template &gt;&gt;

@others

view = g.app.permanentScriptDict.get('demo')
print(f"view? {bool(view)}")
if not view:
    g.app.permanentScriptDict['demo'] = view = MermaidWebView()
    controller = LeoController(c)
    controller.view = view
    # channel = QWebChannel()
    # handler = MermaidEventHandler()
    # handler.controller = controller
    # channel.registerObject('mermaid_bridge', handler)
    # view.page().setWebChannel(channel)
    view.setHtml(controller.update_content())
    view.show()
c.bodyWantsFocusNow()
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
<t tx="ekr.20260922175054.8">class Controller:
    
    &lt;&lt; define content &gt;&gt;
    &lt;&lt; define html_template &gt;&gt;
    root_id = 'Root'
    n_nodes = 1
    id_dict: dict[str, str] = {}  # For uAs.
    moving = False

    @others
</t>
<t tx="ekr.20260922175054.9"># Bypass Chromium origin restrictions.
js_file = QFile(":/qtwebchannel/qwebchannel.js")
if not js_file.open(QIODevice.OpenModeFlag.ReadOnly):
    raise RuntimeError("Failed to locate qwebchannel.js within Qt resources.")

# The html references this script.
webchannel_script = js_file.readAll().data().decode('utf-8')
</t>
<t tx="ekr.20260923035124.1">@language rest

- Design the resource view.

@language python
</t>
<t tx="ekr.20260923040212.1">html_template = (
    """
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
            mermaid_content
        &lt;/div&gt;

        &lt;script&gt;
        window.pyCallback = function(nodeId) {
            if (window.pythonBackend) {
                window.pythonBackend.node_clicked(nodeId);
            } else {
                console.error("IPC bridge not ready.");
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
                console.error("IPC bridge not ready.");
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
    """)</t>
<t tx="ekr.20260923041012.1">def delete_node(self, node_id: str, label: str) -&gt; None:

    if node_id == self.root_id:
        g.es_print('Can not delete the root node', color='red')
        return
    lines = g.splitLines(self.content)
    # Find the parents of the to-be-deleted node.
    parent_pattern = re.compile(rf"\s*(\w+)\[(.*?)\]\s*--&gt;\s*{node_id}\[{label}\]")
    parents = []
    for s in lines:
        if m := parent_pattern.match(s):
            parents.append((m.group(1), m.group(2)))
    # g.trace(f"{parents=}")
    # Find children of the to-be-deleted node.
    child_pattern = re.compile(rf"^\s*{node_id}\[{label}\] --&gt; (\w+)\s*\[")
    children = []
    for s in lines:
        if m := child_pattern.match(s):
            children.append(m.group(1))
    # Switch links from the parent to all the children.
    for parent_tuple in parents:
        parent_id, parent_label = parent_tuple
        for child in children:
            link_from_pattern = re.compile(rf"^\s*{node_id}\[{label}\] --&gt; (\w+)\s*\[(.*?)\]")
            for i, s in enumerate(lines):
                if m := link_from_pattern.match(s):
                    lines[i] = f"    {parent_id}[{parent_label}] --&gt; {m.group(1)}[{m.group(2)}]\n"
                    break
    # Remove all references to the deleted node.
    node_pattern = re.compile(rf"^\s*{node_id}\s*\[{label}\]")
    click_pattern = re.compile(rf"^\s*click\s+{node_id}\s*call")
    link_to_pattern = re.compile(rf"^(.*?)--&gt;\s*{node_id}")
    result = []
    for s in lines:
        if not s.strip():
            continue  # Delete blank lines.
        if node_pattern.match(s):
            continue  # Delete the node itself.
        if click_pattern.match(s):
            continue  # Delete the node itself.
        m = link_to_pattern.match(s)
        if m:  # Delete the link to the node.
            new_line = m.group(1).rstrip() + '\n'
            if new_line not in result:
                result.append(new_line)
            continue  
        result.append(s)
    # Update and refresh.
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260923041013.1">def insert_node(self, node_id: str, label: str) -&gt; None:
    n = self.n_nodes
    new_id = f"Node{n}"
    self.n_nodes += 1
    self.id_dict[new_id] = self.get_new_id()
    result = g.splitLines(self.content)
    result.append(f"    {node_id}[{label}] --&gt; {new_id}[Node {n}]\n")
    result.append(f"    click {new_id} call pyCallback()\n")
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260923042146.1">def refresh(self) -&gt; None:
    """Update the screen."""
    
    # Don't sort lines: it changes screen order.
    #   lines = g.splitLines(self.content)
    #   self.content = ''.join([lines[0]] + list(sorted(lines[1:])))
    
    g.printObj(self.content, tag='refresh')
            
    # Escape backticks and backslashes to prevent JS syntax errors
    escaped_string = self.content.replace('\\', '\\\\').replace('`', '\\`')
    
    # Execute the JS function asynchronously
    self.view.page().runJavaScript(f"window.reRenderGraph(`{escaped_string}`);")
</t>
<t tx="ekr.20260923042416.1"></t>
<t tx="ekr.20260923042421.1">"""
Back up this .leo file.

os.environ['LEO_BACKUP'] must be the path to an existing (writable) directory.
"""
c.backup_helper(sub_dir='SpeedPlanning')

@language python
</t>
<t tx="ekr.20260923042704.1">flow-chart</t>
<t tx="ekr.20260923042755.1"></t>
<t tx="ekr.20260923044849.1">content = textwrap.dedent("""
graph TD
    Root[Root]
    click Root call pyCallback()
""").lstrip()
</t>
<t tx="ekr.20260923130208.1">class Task:
    def __init__(self, name, duration):
        self.name = name
        self.duration = duration
        self.dependencies = []
        
        # CPM Metrics
        self.es = 0   # Early Start
        self.ef = 0   # Early Finish
        self.ls = 0   # Late Start
        self.lf = 0   # Late Finish
        self.slack = 0

    def __repr__(self):
        return (f"Task({self.name}): ES={self.es}, EF={self.ef}, "
                f"LS={self.ls}, LF={self.lf}, Slack={self.slack}")


def calculate_critical_path(tasks):
    # 1. Topological Sort (Ensure dependencies are processed first)
    # Simple dependency resolution for DAGs
    ordered_tasks = []
    visited = set()
    
    def visit(task):
        if task not in visited:
            for dep in task.dependencies:
                visit(dep)
            visited.add(task)
            ordered_tasks.append(task)

    for task in tasks.values():
        visit(task)

    # 2. Forward Pass: Calculate ES and EF
    for task in ordered_tasks:
        if not task.dependencies:
            task.es = 0
        else:
            task.es = max(dep.ef for dep in task.dependencies)
        task.ef = task.es + task.duration

    # Find total project duration
    project_duration = max(task.ef for task in ordered_tasks)

    # 3. Backward Pass: Calculate LF and LS
    # We reverse the topological order to process dependencies backwards
    for task in reversed(ordered_tasks):
        # Find which tasks depend on the current task
        successors = [t for t in ordered_tasks if task in t.dependencies]
        
        if not successors:
            task.lf = project_duration
        else:
            task.lf = min(succ.ls for succ in successors)
        task.ls = task.lf - task.duration
        
        # 4. Calculate Slack / Float
        task.slack = task.lf - task.ef

    # 5. Extract the Critical Path (Tasks with 0 slack)
    critical_path = [task.name for task in ordered_tasks if task.slack == 0]
    
    return project_duration, critical_path


# --- Example Usage ---
if __name__ == "__main__":
    # Define tasks with names and durations
    data = {
        'A': Task('A', 3),
        'B': Task('B', 4),
        'C': Task('C', 2),
        'D': Task('D', 5),
        'E': Task('E', 3)
    }

    # Set up dependencies (e.g., B depends on A)
    data['B'].dependencies = [data['A']]
    data['C'].dependencies = [data['A']]
    data['D'].dependencies = [data['B']]
    data['E'].dependencies = [data['C'], data['D']]

    # Run Algorithm
    duration, path = calculate_critical_path(data)

    print(f"Total Project Duration: {duration} days\n")
    print("Task Details:")
    for name, task in data.items():
        print(task)
        
    print(f"\nCritical Path: {' -&gt; '.join(path)}")
</t>
<t tx="ekr.20260923130657.1">def rename_node(self, node_id: str, label: str) -&gt; None:
    """Rename the given node."""
    new_name = self.rename_dialog(label)
    if not new_name:
        return
    node_pattern = re.compile(rf"^\s*{node_id}\[{label}\]\n")
    link_from_pattern = re.compile(rf"^\s*{node_id}\[{label}\]\s*--&gt;\s*(\w+)\[(.*?)\]")
    link_to_pattern = re.compile(rf"^(.*?)--&gt;\s*{node_id}\[{label}\]")
    result = []
    ws = ' '*4
    for s in g.splitLines(self.content):
        m = node_pattern.match(s)
        if m:
            result.append(f"{ws}{node_id}[{new_name}]\n")
            continue
        m = link_from_pattern.match(s)
        if m:
            result.append(f"{ws}{node_id}[{new_name}] --&gt; {m.group(1)}[{m.group(2)}]\n")
            continue
        m = link_to_pattern.match(s)
        if m:
            result.append(f"{ws}{m.group(1).strip()} --&gt; {node_id}[{new_name}]\n")
            continue
        result.append(s)
    # Update and refresh.
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260923132125.1">def get_new_id(self) -&gt; str:
    """Get a new node index"""
    t = time.strftime('%Y-%m-%d-%H-%M-%S', time.localtime())
    return f"{g.app.leoID}:{t}"
</t>
<t tx="ekr.20260923162300.1">def move_node(self, node_id: str, label: str) -&gt; None:
    
    if node_id == self.root_id:
        g.es_print('Can not move the root node', color='red')
        return
    self.moving = True
    g.es_print('Select the new parent')

def move_node2(self, node_id: stri, label: str) -&gt; None:
    g.trace(node_id, label)
    self.moving = False
</t>
<t tx="ekr.20260923171237.1">def rename_dialog(self, old_name: str) -&gt; str:
    """Put up a dialog asking for a node's name"""
    dialog = QInputDialog()
    dialog.setWindowTitle('Rename node')
    dialog.setLabelText(f"New name for {old_name}:")
    dialog.raise_()
    ok = dialog.exec()
    return str(dialog.textValue()) if ok else ''

</t>
<t tx="ekr.20260924035448.1">class MermaidWebView(QWebEngineView):

    def __init__(self):
        super().__init__()

    # Override the native Qt event handler
    def closeEvent(self, event: QCloseEvent):
        
        g.app.permanentScriptDict['demo'] = None
        # Allow the window to close
        event.accept()
</t>
<t tx="ekr.20260924040355.1">class LeoController:

    &lt;&lt; define content &gt;&gt;
    root_id = 'Root'
    n_nodes = 0
    id_dict: dict[str, str] = {}  # For uAs.
    moving = False
    
    def __init__(self, c: Cmdr) -&gt; None:
        self.c = c

    @others
</t>
<t tx="ekr.20260924040355.2">content = textwrap.dedent("""
graph TD
    Root[Root]
    click Root call pyCallback()
""").lstrip()
</t>
<t tx="ekr.20260924040355.3">html_template = (
    """
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
            mermaid_content
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
    """)</t>
<t tx="ekr.20260924040552.1">def update_content(self) -&gt; str:
    self.content = self.get_content()
    # g.printObj(self.content)
    g.trace(f"{self.content.count('\n')} lines")
    return (
        html_template
        .replace('webchannel_script', webchannel_script)
        .replace('mermaid_content', self.content)
    )
</t>
<t tx="ekr.20260924042054.1">def get_content(self) -&gt; str:
    """Return the mermaid content corresponding to the 'planning-root' node."""
    h = 'planning-root'
    root = g.findNodeAnywhere(c, h)
    if not root:
        g.trace(f"Not found: {h}")
        g.app.permanentScriptDict['demo'] = None
        return
        
    result = ['graph TD\n']
        
    def add_link(parent_id: str, parent_h: str, child_id: str, child_h: str) -&gt; None:
        result.append(f"    {parent_id}[{parent_h}] --&gt; {child_id}[{child_h}]\n")
        
    def add_node(p: Position) -&gt; str:
        n = self.n_nodes
        new_id = 'Root' if p == root else f"Node{n}"
        self.n_nodes += 1
        self.id_dict[new_id] = p.v.gnx
        result.append(f"    {new_id}[{p.h}]\n")
        result.append(f"    click {new_id} call pyCallback()\n")
        return new_id
        
    def build(parent: Position, parent_id: str, p: Position) -&gt; None:
        p_id = add_node(p)
        if parent:
            add_link(parent_id, parent.h, p_id, p.h)
        for child in p.children():
            build(p, p_id, child)

    build(None, '', root)
    # g.printObj(result)
    return ''.join(result)
</t>
<t tx="ekr.20260924042736.1">@language rest
@wrap

=== Input program communicates with Leo

It insert a new task at a given point in the flowchart pane and
a magic script inserts an @task node in the proper place in the Leo outine.

=== Listener in Leo: listens for new tasks.

Update button: update (magically) creates three different web pages using one or more tasks.

=== Output Visual (Big whiteboards == web pages)
    
Flowchart pane, updated by elicitator. Data flows to Leo outline
Gantt chart
Resource spreadsheet

Export to Jira:
    
Kanban (almost a subsection of Agile)
Agile
Waterfall

=== Every task has name, description, resource list, length of time.

Dropdown list only for resource list.
Everything else entered on keyboard.
Usually only the name of the task.

=== If leo-web were an electron app would fix all file access problems.

We don't want an electron app because we want Python scripting.

=== Remote control might be part of the mix.

=== The real value is dynamic.

Dynamism create excitement &amp; clarity.
Speed is important.
Elicitation method guides the CEO. The CEO's clarity creates the tasks.
The instant feedback makes the whole project seem more real.
Everybody wants to contribute. Hands go up.
Part of value added is all the infrastruction.

=== Jira has plugin system.

Could be standalone or Jira plugin.</t>
<t tx="ekr.20260924042736.2"></t>
<t tx="ekr.20260924042736.3"></t>
<t tx="ekr.20260924042736.4">blah blah</t>
<t tx="ekr.20260924042736.5">:task: Two cases of toner.

:name: Jack T. Ripper

:time: 20 days.

:cost: 

</t>
<t tx="ekr.20260924042736.6"></t>
<t tx="ekr.20260924042736.7"></t>
<t tx="ekr.20260924042736.8"></t>
<t tx="ekr.20260924042736.9"></t>
<t tx="ekr.20260924050522.1">g.app.permanentScriptDict['demo'] = None</t>
<t tx="ekr.20260924081724.1"></t>
<t tx="ekr.20260924081809.1">html_template = (
    """
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
            mermaid_content
        &lt;/div&gt;

        &lt;script&gt;
        window.pyCallback = function(nodeId) {
            if (window.pythonBackend) {
                window.pythonBackend.node_clicked(nodeId);
            } else {
                console.error("IPC bridge not ready.");
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
                console.error("IPC bridge not ready.");
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
    """)</t>
<t tx="ekr.20260924082334.1">class MermaidEventHandler(QObject):
    
    @pyqtSlot(str, str)
    def node_clicked(self, node_id, label):
        
        controller = self.controller
        menu = QMenu()
        
        if controller.moving:
            controller.move_node2(node_id, label)
            controller.moving = False
            return

        # Incorporate both the internal ID and the visible label
        delete = move = None
        if node_id != controller.root_id:
            delete = menu.addAction('Delete this node')
        insert = menu.addAction('Insert child node')
        if node_id != controller.root_id:
            move = menu.addAction('Move this node')
        rename = menu.addAction('Rename this node')
        menu.addSeparator()
        menu.addAction("Cancel")

        action = menu.exec(QCursor.pos())
        if not action:
            return
        try:
            if action == delete:
                controller.delete_node(node_id, label)
            elif action == insert:
                controller.insert_node(node_id, label)
            elif action == move:
                controller.move_node(node_id, label)
            elif action == rename:
                controller.rename_node(node_id, label)
        except Exception:
            g.app.permanentScriptDict['demo'] = None
            g.es_exception()

</t>
<t tx="ekr.20260924082503.1">class LeoController:

    &lt;&lt; define content &gt;&gt;
    &lt;&lt; define html_template &gt;&gt;
    root_id = 'Root'
    n_nodes = 0
    id_dict: dict[str, str] = {}  # For uAs.
    moving = False
    
    def __init__(self, c: Cmdr) -&gt; None:
        self.c = c

    @others
</t>
<t tx="ekr.20260924082503.10">def rename_dialog(self, old_name: str) -&gt; str:
    """Put up a dialog asking for a node's name"""
    dialog = QInputDialog()
    dialog.setWindowTitle('Rename node')
    dialog.setLabelText(f"New name for {old_name}:")
    dialog.raise_()
    ok = dialog.exec()
    return str(dialog.textValue()) if ok else ''

</t>
<t tx="ekr.20260924082503.11">def rename_node(self, node_id: str, label: str) -&gt; None:
    """Rename the given node."""
    new_name = self.rename_dialog(label)
    if not new_name:
        return
    node_pattern = re.compile(rf"^\s*{node_id}\[{label}\]\n")
    link_from_pattern = re.compile(rf"^\s*{node_id}\[{label}\]\s*--&gt;\s*(\w+)\[(.*?)\]")
    link_to_pattern = re.compile(rf"^(.*?)--&gt;\s*{node_id}\[{label}\]")
    result = []
    ws = ' '*4
    for s in g.splitLines(self.content):
        m = node_pattern.match(s)
        if m:
            result.append(f"{ws}{node_id}[{new_name}]\n")
            continue
        m = link_from_pattern.match(s)
        if m:
            result.append(f"{ws}{node_id}[{new_name}] --&gt; {m.group(1)}[{m.group(2)}]\n")
            continue
        m = link_to_pattern.match(s)
        if m:
            result.append(f"{ws}{m.group(1).strip()} --&gt; {node_id}[{new_name}]\n")
            continue
        result.append(s)
    # Update and refresh.
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260924082503.12">def update_content(self) -&gt; str:
    self.content = self.get_content()
    g.printObj(self.content)
    return (
        self.html_template
        .replace('webchannel_script', webchannel_script)
        .replace('mermaid_content', self.content)
    )
</t>
<t tx="ekr.20260924082503.2">content = textwrap.dedent("""
graph TD
    Root[Root]
    click Root call pyCallback()
""").lstrip()
</t>
<t tx="ekr.20260924082503.3">html_template = (
    """
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
            mermaid_content
        &lt;/div&gt;

        &lt;script&gt;
        window.pyCallback = function(nodeId) {
            if (window.pythonBackend) {
                window.pythonBackend.node_clicked(nodeId);
            } else {
                console.error("IPC bridge not ready.");
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
                console.error("IPC bridge not ready.");
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
    """)</t>
<t tx="ekr.20260924082503.4">def delete_node(self, node_id: str, label: str) -&gt; None:

    if node_id == self.root_id:
        g.es_print('Can not delete the root node', color='red')
        return
    lines = g.splitLines(self.content)
    # Find the parents of the to-be-deleted node.
    parent_pattern = re.compile(rf"\s*(\w+)\[(.*?)\]\s*--&gt;\s*{node_id}\[{label}\]")
    parents = []
    for s in lines:
        if m := parent_pattern.match(s):
            parents.append((m.group(1), m.group(2)))
    # g.trace(f"{parents=}")
    # Find children of the to-be-deleted node.
    child_pattern = re.compile(rf"^\s*{node_id}\[{label}\] --&gt; (\w+)\s*\[")
    children = []
    for s in lines:
        if m := child_pattern.match(s):
            children.append(m.group(1))
    # Switch links from the parent to all the children.
    for parent_tuple in parents:
        parent_id, parent_label = parent_tuple
        for child in children:
            link_from_pattern = re.compile(rf"^\s*{node_id}\[{label}\] --&gt; (\w+)\s*\[(.*?)\]")
            for i, s in enumerate(lines):
                if m := link_from_pattern.match(s):
                    lines[i] = f"    {parent_id}[{parent_label}] --&gt; {m.group(1)}[{m.group(2)}]\n"
                    break
    # Remove all references to the deleted node.
    node_pattern = re.compile(rf"^\s*{node_id}\s*\[{label}\]")
    click_pattern = re.compile(rf"^\s*click\s+{node_id}\s*call")
    link_to_pattern = re.compile(rf"^(.*?)--&gt;\s*{node_id}")
    result = []
    for s in lines:
        if not s.strip():
            continue  # Delete blank lines.
        if node_pattern.match(s):
            continue  # Delete the node itself.
        if click_pattern.match(s):
            continue  # Delete the node itself.
        m = link_to_pattern.match(s)
        if m:  # Delete the link to the node.
            new_line = m.group(1).rstrip() + '\n'
            if new_line not in result:
                result.append(new_line)
            continue  
        result.append(s)
    # Update and refresh.
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260924082503.5">def get_content(self) -&gt; str:
    """Return the mermaid content corresponding to the 'planning-root' node."""
    h = 'planning-root'
    root = g.findNodeAnywhere(c, h)
    if not root:
        g.trace(f"Not found: {h}")
        g.app.permanentScriptDict['demo'] = None
        return
        
    result = ['graph TD\n']
        
    def add_link(parent_id: str, parent_h: str, child_id: str, child_h: str) -&gt; None:
        result.append(f"    {parent_id}[{parent_h}] --&gt; {child_id}[{child_h}]\n")
        
    def add_node(p: Position) -&gt; str:
        n = self.n_nodes
        new_id = 'Root' if p == root else f"Node{n}"
        self.n_nodes += 1
        self.id_dict[new_id] = p.v.gnx
        result.append(f"    {new_id}[{p.h}]\n")
        result.append(f"    click {new_id} call pyCallback()\n")
        return new_id
        
    def build(parent: Position, parent_id: str, p: Position) -&gt; None:
        p_id = add_node(p)
        if parent:
            add_link(parent_id, parent.h, p_id, p.h)
        for child in p.children():
            build(p, p_id, child)

    build(None, '', root)
    # g.printObj(result)
    return ''.join(result)
</t>
<t tx="ekr.20260924082503.6">def get_new_id(self) -&gt; str:
    """Get a new node index"""
    t = time.strftime('%Y-%m-%d-%H-%M-%S', time.localtime())
    return f"{g.app.leoID}:{t}"
</t>
<t tx="ekr.20260924082503.7">def insert_node(self, node_id: str, label: str) -&gt; None:
    n = self.n_nodes
    new_id = f"Node{n}"
    self.n_nodes += 1
    self.id_dict[new_id] = self.get_new_id()
    result = g.splitLines(self.content)
    result.append(f"    {node_id}[{label}] --&gt; {new_id}[Node {n}]\n")
    result.append(f"    click {new_id} call pyCallback()\n")
    self.content = ''.join(result)
    self.refresh()
</t>
<t tx="ekr.20260924082503.8">def move_node(self, node_id: str, label: str) -&gt; None:
    
    if node_id == self.root_id:
        g.es_print('Can not move the root node', color='red')
        return
    self.moving = True
    g.es_print('Select the new parent')

def move_node2(self, node_id: stri, label: str) -&gt; None:
    g.trace(node_id, label)
    self.moving = False
</t>
<t tx="ekr.20260924082503.9">def refresh(self) -&gt; None:
    """Update the screen."""
    
    # Don't sort lines: it changes screen order.
    #   lines = g.splitLines(self.content)
    #   self.content = ''.join([lines[0]] + list(sorted(lines[1:])))
    
    g.printObj(self.content, tag='refresh')
            
    # Escape backticks and backslashes to prevent JS syntax errors
    escaped_string = self.content.replace('\\', '\\\\').replace('`', '\\`')
    
    # Execute the JS function asynchronously
    self.view.page().runJavaScript(f"window.reRenderGraph(`{escaped_string}`);")
</t>
<t tx="ekr.20260924082951.1"></t>
</tnodes>
</leo_file>
