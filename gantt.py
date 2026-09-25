# @+leo-ver=5-thin
# @+node:ekr.20260925080314.1: * @file gantt.py
"""gantt.py: The code for @button gantt-chart."""
# @@language python
# @+others
# @+node:ekr.20260925080117.1: ** @button gantt-chart
# @@language python

from PyQt6.QtCore import QUrl
from PyQt6.QtWebEngineWidgets import QWebEngineView

# @+<< define gantt content >>
# @+node:ekr.20260925080225.1: *3* << define gantt content >>
html_content = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { margin: 0; padding: 20px; font-family: sans-serif; background: gray; }
    </style>
</head>
<body>

    <pre class="mermaid">
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
    </pre>

    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
        
        mermaid.initialize({ 
            startOnLoad: false, // Prevents premature parsing race conditions
            securityLevel: 'loose' 
        });
        
        // Explicitly trigger parsing once everything is mounted
        document.addEventListener('DOMContentLoaded', async () => {
            await mermaid.run();
        });
    </script>
</body>
</html>
"""
# @-<< define gantt content >>

view = QWebEngineView()
view.setHtml(html_content, QUrl("http://localhost"))
view.resize(800, 400)
view.show()
g.app.scriptDict['demo'] = view

# @-others
# @-leo
