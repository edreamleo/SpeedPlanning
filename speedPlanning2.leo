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
<v t="ekr.20260925173401.1"><vh>@file buttons.py</vh></v>
<v t="ekr.20260924115347.1"><vh>@file roots.txt</vh></v>
</v>
<v t="ekr.20260925173700.1"><vh>Notes</vh></v>
</vnodes>
<tnodes>
<t tx="ekr.20260923042416.1"></t>
<t tx="ekr.20260923042421.1">"""
Back up this .leo file.

os.environ['LEO_BACKUP'] must be the path to an existing (writable) directory.
"""
c.backup_helper(sub_dir='SpeedPlanning')

@language python
</t>
<t tx="ekr.20260923042704.1">critical-path
gantt-chart
flow-chart</t>
<t tx="ekr.20260923042755.1"></t>
<t tx="ekr.20260924050522.1">g.app.permanentScriptDict['flow-chart'] = None</t>
<t tx="ekr.20260924121154.1"># These settings control ruff format, which is compatible with black.</t>
<t tx="ekr.20260924121154.2"># True: beautify all @&lt;file&gt; nodes in the outline using Leo's token-based beautifier.
# True can result in much slower writes.</t>
<t tx="ekr.20260924121154.3"># This setting overrides any value in pyproject.toml or ruff.toml
# Leo uses 120 for its own files.</t>
<t tx="ekr.20260924121154.4"># If given, this argument should be a full, absolute path to pyproject.toml or ruff.toml.
# If not given, Leo's beautifier uses Leo's pyproject.toml file.
</t>
<t tx="ekr.20260925080653.1"></t>
<t tx="ekr.20260925084334.1">g.app.permanentScriptDict['gantt-chart'] = None</t>
<t tx="ekr.20260925173700.1">To do: design resource view.

Repo: https://github.com/edreamleo/SpeedPlanning

Qt WebEngine is based on the open-source Chromium project and uses the Blink rendering engine.

All code based on this gemini conversation: https://share.gemini.google/pyz22WW3idU7
</t>
</tnodes>
</leo_file>
