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
<v t="ekr.20260924121154.2"><vh>@bool beautify-python-code-on-write = False</vh></v>
<v t="ekr.20260924121154.3"><vh>@int black-line-length = 100</vh></v>
<v t="ekr.20260924121154.4"><vh>@string black-toml = None</vh></v>
</v>
<v t="ekr.20261001131410.1"><vh>@data abbreviations</vh></v>
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
<v t="ekr.20260928115915.1"><vh>=== classes</vh>
<v t="ekr.20260925081852.1"><vh>class GanttController</vh>
<v t="ekr.20260925081852.4"><vh>GanttController.get_gantt_content</vh>
<v t="ekr.20260925131750.1"><vh>function: calculate_critical_path</vh></v>
<v t="ekr.20260927064540.1"><vh>function: label</vh></v>
<v t="ekr.20260927064542.1"><vh>function: to_mermaid</vh></v>
<v t="ekr.20260927065742.1"><vh>function: make_deps</vh></v>
<v t="ekr.20260927064646.1"><vh>function: make_mermaid</vh></v>
<v t="ekr.20260927064818.1"><vh>function: make_tasks</vh></v>
<v t="ekr.20260928132246.1"><vh>function: patch_mermaid</vh></v>
<v t="ekr.20260929072100.1"><vh>function: show_short_deps</vh></v>
<v t="ekr.20260927065200.1"><vh>function: sort_tasks</vh></v>
</v>
<v t="ekr.20260925081852.6"><vh>GanttController.update_gantt_content</vh></v>
</v>
<v t="ekr.20260926121726.1"><vh>class GanttTask</vh>
<v t="ekr.20260928103315.1"><vh>GanttTask.__repr__</vh></v>
<v t="ekr.20260928131306.1"><vh>GanttTask.short_repr</vh></v>
<v t="ekr.20260929065811.1"><vh>GanttTask: init</vh></v>
</v>
</v>
<v t="ekr.20260926121445.1"><vh>=== Recent</vh>
<v t="ekr.20261001131410.1"></v>
<v t="ekr.20260925084827.1"><vh>gantt-root</vh>
<v t="ekr.20260925091127.1"><vh>Planning</vh>
<v t="ekr.20260927021418.1"><vh>Market research</vh></v>
<v t="ekr.20260927021430.1"><vh>Requirements</vh></v>
</v>
<v t="ekr.20261001133331.1"><vh>Test</vh>
<v t="ekr.20261001133729.1"><vh>Test zero</vh></v>
<v t="ekr.20261001133732.1"><vh>Test one</vh></v>
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
<t tx="ekr.20260925081852.1">class GanttController:
    @others


</t>
<t tx="ekr.20260925081852.4">def get_gantt_content(self, headline: str) -&gt; str:
    """Return the mermaid Gantt content corresponding to the given node."""
    root = g.findNodeAnywhere(c, headline)
    if not root:
        g.trace(f"Not found: {headline}")
        g.app.permanentScriptDict['demo'] = None
        return

    ws = ' ' * 4

    @others

    # Create tasks.
    tasks = make_tasks(root)
    if 0:
        print()
        print('Tasks...')
        for z in tasks:
            print(z)
    if 1:
        print()
        print(f"Mermaid tasks names: {', '.join(sorted(g_mermaid_task_names))}")

    # Create forward and backward dependencies.
    make_deps(root, tasks)
    if 1:
        show_short_deps(tasks)

    # Sort the tasks based on the dependencies.
    sorted_tasks = sort_tasks(tasks)
    if 0:
        print()
        print('Sorted tasks...')
        for z in sorted_tasks:
            print(z)

    # Compute Task.metrics and critical path.
    project_duration, critical_path = calculate_critical_path(tasks, sorted_tasks)
    if 1:
        print()
        print(f"Project Duration: {project_duration} days")
        print()
        print('Critical path')
        for task in critical_path:
            print(f"  {task.short_repr()}")

    # Compute mermaid text.
    root_lines = [z for z in g.splitLines(root.b) if z.strip()]
    title = root_lines[0] if root_lines else 'Unknown Project Title'
    result = make_mermaid(format='dateFormat YYYY-MM-DD', title=title)
    patch_mermaid(critical_path, result)
    if 1:
        print()
        g.printObj(result, tag='mermaid lines')
    return ''.join(result)

</t>
<t tx="ekr.20260925081852.6">def update_gantt_content(self, headline: str) -&gt; str:
    self.content = self.get_gantt_content(headline)
    # g.printObj(self.content)
    g.trace(f"{self.content.count('\n')} lines")
    return gantt_template.replace('gantt_content', self.content)

</t>
<t tx="ekr.20260925084334.1">g.app.permanentScriptDict['gantt-chart'] = None</t>
<t tx="ekr.20260925084827.1">Product Launch Plan

@language rest
</t>
<t tx="ekr.20260925091127.1"></t>
<t tx="ekr.20260925091130.1"></t>
<t tx="ekr.20260925091130.2"></t>
<t tx="ekr.20260925121941.1">:milestone, after marketing, 7d
</t>
<t tx="ekr.20260925131750.1">def calculate_critical_path(
    tasks: list[GanttTask],
    sorted_tasks: list[GanttTask],
) -&gt; tuple[int, list[GanttTask]]:

    # Forward Pass: Calculate ES and EF.
    for task in sorted_tasks:
        deps = task.deps
        bad = [z.title for z in deps if z.ef == -1]
        assert not bad, bad
        task.es = max(dep.ef for dep in deps) if deps else 0
        task.ef = task.es + task.duration

    # Find total project duration.
    project_duration = max(task.ef for task in tasks)

    # Calculate successors of all tasks.
    for task in tasks:
        task.successors = [z for z in tasks if task in z.deps]

    # Backward Pass: Calculate LF and LS.
    for task in reversed(sorted_tasks):
        successors = task.successors
        bad = [z.title for z in successors if z.lf == -1]
        assert not bad, bad
        task.lf = min(z.ls for z in successors) if successors else project_duration
        task.ls = task.lf - task.duration

        # Calculate the task's slack.
        task.slack = task.lf - task.ef

    # The critical path are those tasks with zero slack.
    critical_path = [task for task in sorted_tasks if task.slack == 0]

    return project_duration, critical_path

</t>
<t tx="ekr.20260926121445.1"></t>
<t tx="ekr.20260926121726.1">class GanttTask:
    # :active, proto, after reqs
    after_two_names_pat = re.compile(rf"^\:(\w+)\,\s+(\w+)\,after\s+(\w+)")
    # :testing, after proto
    # :milestone, after testing
    after_one_name_pat = re.compile(rf"^\:(\w+)\,\s*after\s+(\w+)")
    # :done, research
    no_after_pat = re.compile(rf"^\:(\w+)\,\s*(\w+)")
    duration_pat = re.compile(rf"^.*?\,\s*([0-9]+)\s*[dhm]")

    @others

    def __init__(self, p: Position) -&gt; None:

        global g_n_tasks
        self.after_mermaid_task_names: list[str] = []  # Set below.
        self.after_mermaid_tasks: list[GanttTask] = []  # Set later.
        self.lines = clean_lines(p)
        self.task_n = g_n_tasks
        g_n_tasks += 1
        self.mermaid_task_names: list[str] = []  # Set below.
        self.mermaid_tasks: list[GanttTask] = []  # Set later.
        self.p = p.copy()
        # Clean titles so they don't confuse the regex parsers.
        self.title = p.h.strip().replace(':', ' ').replace(',', ' ')

        # Dependencies...

        # deps: Tasks that this tasks depends on.
        # They must all finish before this task can start.
        self.deps = []
        # successors:Tasks that depend on *this* task.
        # This task must finish before any of these can start.
        self.successors = []

        # Metrics
        self.duration = 0
        self.es = -1  # Earliest Start
        self.ef = -1  # Earliest Finish
        self.ls = -1  # Latest Start
        self.lf = -1  # Latest Finish
        self.slack = -1

        # Complete the init.
        self.init()

        if 0 and self.lines:
            g.trace(f"{self.title:20} {self.lines}")


</t>
<t tx="ekr.20260927021418.1">:done, research, 2024-03-01, 10d
.. comment
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
<t tx="ekr.20260927064540.1">def label(p: Position) -&gt; str:
    """Create a mermaid label from p.h"""
    return ''.join(z for z in p.h.replace(' ', '-').lower() if z.isalnum())

</t>
<t tx="ekr.20260927064542.1">def to_mermaid(p: Position) -&gt; list[str]:
    return [z for z in clean_lines(p) if not z.startswith('#')]

</t>
<t tx="ekr.20260927064646.1">def make_mermaid(format: str, title: str) -&gt; list[str]:

    result = [
        'gantt\n',
        f"{ws}title {title.strip()}\n",
        f"{ws}{format}\n",
    ]
    for top_p in root.children():
        result.append(f"{ws}section {top_p.h.strip()}\n")
        for s in to_mermaid(top_p):
            result.append(f"{ws}{ws}{top_p.h.strip()} {s}\n")
        for p in top_p.subtree():
            lines = to_mermaid(p)
            for s in lines:
                result.append(f"{ws}{ws}{p.h.strip()} {s}\n")
    return result

</t>
<t tx="ekr.20260927064818.1">def make_tasks(root) -&gt; list[GanttTask]:
    return [GanttTask(p) for p in root.subtree()]

</t>
<t tx="ekr.20260927065200.1">def sort_tasks(tasks: list[GanttTasks]) -&gt; list[GanttTasks]:
    """Return an ordered list of tasks."""

    result = []
    visited = set()

    def visit(task):
        if task not in visited:
            visited.add(task)
            if task not in result:
                result.append(task)
            for dep in task.deps:
                visit(dep)

    for task in tasks:
        visit(task)

    return result

</t>
<t tx="ekr.20260927065742.1">def make_deps(root: Position, tasks: list[GanttTask]) -&gt; None:
    """Create task.deps and task.successors for all tasks."""

    # Create all deps and successors lists for Task t.
    # t.deps:       Tasks tz that must finish *before* Task t.
    # t.successors: Tasks tz that must start *after* Task t.
    for task in tasks:
        for after_name in task.after_mermaid_task_names:
            # g.trace(f"{task.title:&lt;20} after: {after_name}")
            assert after_name in g_mermaid_task_names, (
                f"{after_name} not in {g_mermaid_task_names}"
            )
            after_tasks = g_mermaid_task_names_to_tasks.get(after_name)
            for after_task in after_tasks:
                assert isinstance(after_task, GanttTask), repr(after_task)
                # Update task.deps.
                if after_task not in task.deps:
                    task.deps.append(after_task)
                # Update after_task.successors.
                if task not in after_task.successors:
                    after_task.successors.append(task)

</t>
<t tx="ekr.20260928103315.1">def __repr__(self):

    def show_list(tasks: list[GanttTask], tag: str) -&gt; str:
        if not tasks:
            return ''
        result = []
        for task in tasks:
            if task.mermaid_task_names:
                result.append(', '.join(task.mermaid_task_names))
        return f"{tag}: [{', '.join(result)}]" if result else ''

    if self.mermaid_task_names:
        m_task_names = f"[{','.join(self.mermaid_task_names)}]"
        m_tasks_s = f" {m_task_names:12}"
    else:
        m_tasks_s = ' ' * 13
    if self.after_mermaid_task_names:
        m_after_names = f"[{','.join(self.after_mermaid_task_names)}]"
        m_after_tasks_s = f" after: {m_after_names:14}"  ### if m_after_names else ''
    else:
        m_after_tasks_s = ' ' * 22

    deps_s = show_list(self.deps, tag='deps')
    deps_s = f"{deps_s:20}"
    if self.successors:
        succ_s = show_list(self.successors, tag='successors')
    else:
        succ_s = ''
    return f"GanttTask: {self.title:&gt;18} time: {self.duration:2} {m_tasks_s}{m_after_tasks_s}{deps_s}{succ_s}"

</t>
<t tx="ekr.20260928115915.1"></t>
<t tx="ekr.20260928131306.1">def short_repr(self) -&gt; None:
    names = self.mermaid_task_names
    tasks_s = f"[{','.join(names)}]" if names else ''
    return f"GanttTask: {self.title:&gt;18} time: {self.duration:2} {tasks_s}"

</t>
<t tx="ekr.20260928132246.1">def patch_mermaid(tasks: list[GanttTask], result: list[str]) -&gt; None:

    names = []
    for task in tasks:
        names.extend(task.mermaid_task_names)
    for i, s in enumerate(result):
        if any(z in s for z in names) and ':' in s:
            result[i] = s.replace(':', ':crit, ')

</t>
<t tx="ekr.20260929065811.1">def init(self):
    """GanttTask.init: handle complex initialization."""

    def add_after_name(name: str) -&gt; None:
        if name not in self.after_mermaid_tasks:
            self.after_mermaid_task_names.append(name)

    def add_m_name(name1: str, name2: str) -&gt; None:
        name = name2 if name1 in ('active', 'done', 'milestone') else name1
        if not name:
            return  # Not an error. The line does not define mermaid task name.
        # Update self.mermaid_task_names.
        if name not in self.mermaid_task_names:
            self.mermaid_task_names.append(name)
        # Update global mermaid_task_names list.
        if name not in g_mermaid_task_names:
            g_mermaid_task_names.append(name)
        # Update global g_mermaid_task_names_to_tasks dict.
        aList = g_mermaid_task_names_to_tasks.get(name, [])
        if self not in aList:
            aList.append(self)
            g_mermaid_task_names_to_tasks[name] = aList

    # Find mermaid task names and update data structures.
    for s in self.lines:
        if m := self.after_two_names_pat.match(s):
            name1, name2, name3 = m.group(1), m.group(2), m.group(3)
            add_m_name(name1, name2)
            add_after_name(name3)
        elif m := self.after_one_name_pat.match(s):
            name1, name2 = m.group(1), m.group(2)
            add_m_name(name1, '')
            add_after_name(name2)
        elif m := self.no_after_pat.match(s):
            name1, name2 = m.group(1), m.group(2)
            add_m_name(name1, name2)

    # Set the duration.
    self.duration = 0
    for s in self.lines:
        if m := self.duration_pat.match(s):
            self.duration = int(m.group(1))
            break

</t>
<t tx="ekr.20260929072100.1">def show_short_deps(tasks: list[GanttTask]) -&gt; None:

    max_n = 5

    def mermaid_name(task: GanttTask) -&gt; str:
        """Return the mermaid task name for this task."""
        nonlocal max_n
        names = task.mermaid_task_names
        result = names[0] if names else ''
        max_n = max(max_n, len(result))
        return result

    def name(task: GanttTask) -&gt; str:
        """Return a short name for the task."""
        return f"T{task.task_n}"

    print()
    print('Ordered tasks, with deps:')
    for task in tasks:
        s = f"{mermaid_name(task):&gt;10} {name(task):&lt;3} [{','.join(name(z) for z in task.deps)}]"
        print(s.replace(':&gt;10', f":&gt;{max_n}"))

</t>
<t tx="ekr.20261001131410.1"># Definitions in @data abbreviation nodes override definitions in @data
# global-abbreviation nodes.

# Typically you would define @data global-abbreviation nodes
# in myLeoSettings.leo and @data abbreviation nodes in local files.

mm;;=@language python
\:# status: active or done
\:# date: starting date or after task
\::&lt;|optional status or milestone|&gt;, &lt;|task-name|&gt;, &lt;|date|&gt;, &lt;|duration (hdm)|&gt;</t>
<t tx="ekr.20261001133331.1"></t>
<t tx="ekr.20261001133729.1">@language python
# status: active or done
# date: starting date or after task
# task-name, after proto, 10d
:active, test1, after reqs, 10d

</t>
<t tx="ekr.20261001133732.1"># status: active or done
# task-name, after proto, 10d
# :active test2, after test1, 5d
</t>
</tnodes>
</leo_file>
