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
<v t="ekr.20260925084827.1"><vh>gantt-root</vh>
<v t="ekr.20260925091127.1"><vh>Planning</vh>
<v t="ekr.20260927021418.1"><vh>Market research</vh></v>
<v t="ekr.20260927021430.1"><vh>Requirements</vh></v>
</v>
<v t="ekr.20260925091130.1"><vh>Build</vh>
<v t="ekr.20260927023219.1"><vh>Design prototype</vh></v>
<v t="ekr.20260927023207.1"><vh>User testing</vh></v>
</v>
<v t="ekr.20260925091130.2"><vh>Launch</vh>
<v t="ekr.20260927023520.1"><vh>Marketing campaign</vh></v>
<v t="ekr.20260927023522.1"><vh>Release day</vh></v>
</v>
<v t="ekr.20260925121941.1"><vh>Celebrate</vh></v>
</v>
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
<t tx="ekr.20260923042704.1">gantt-chart
critical-path
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
<t tx="ekr.20260925084827.1">Product Launch Plan
</t>
<t tx="ekr.20260925091127.1"></t>
<t tx="ekr.20260925091130.1"></t>
<t tx="ekr.20260925091130.2"></t>
<t tx="ekr.20260925121941.1">:milestone, after marketing, 7d
</t>
<t tx="ekr.20260927021418.1">:done, research, 2024-03-01, 10d
</t>
<t tx="ekr.20260927021430.1">:done, reqs, after research, 7d
               
</t>
<t tx="ekr.20260927023207.1">:testing, after proto, 7d
</t>
<t tx="ekr.20260927023219.1">:active, proto, after reqs, 14d
                
</t>
<t tx="ekr.20260927023520.1">:marketing, after proto, 14d
</t>
<t tx="ekr.20260927023522.1">:milestone, after testing, 0d
</t>
</tnodes>
</leo_file>
