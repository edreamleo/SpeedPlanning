# @+leo-ver=5-thin
# @+node:ekr.20260925132547.1: * @file critical_path.py
"""critical_path.py: The code for @button critical-path."""

# @@language python
# @+others
# @+node:ekr.20260923130208.1: ** @button critical-path
"""Critical algorithm"""
# @+<< critical path algorithm >>
# @+node:ekr.20260922175054.2: *3* << critical path algorithm >>
# @@nocolor
"""
Google: critical path method algorithm

The critical path algorithm (Critical Path Method or CPM) is a step-by-step project management technique that finds the longest sequence of dependent tasks to determine the shortest possible project duration.

=== How the Algorithm Works

The algorithm uses a network diagram to map project activities, their durations, and their dependencies. It runs through four main phases:

**Forward Pass**: Moves from start to finish to calculate the Earliest Start (ES) and Earliest Finish (EF) times for each task (EF = ES + duration).

**Backward Pass**: Moves from the project end date back to the start to calculate the Latest Start (LS) and Latest Finish (LF) times (LS = LF - duration).

**Float Calculation**: Finds the slack or buffer time for each task using the formula: Float = LS - ES (or LF - EF).

**Path Identification**: Identifies the continuous chain of tasks that have zero float, which forms the critical path. Any delay on this path delays the entire project.
"""
# @-<< critical path algorithm >>
g.cls()


# @+others
# @+node:ekr.20260925131747.1: *3* class Task
class Task:
    def __init__(self, name, duration):
        self.name = name
        self.duration = duration
        self.dependencies = []

        # CPM Metrics
        self.es = 0  # Early Start
        self.ef = 0  # Early Finish
        self.ls = 0  # Late Start
        self.lf = 0  # Late Finish
        self.slack = 0

    def __repr__(self):
        return (
            f"Task({self.name}): ES:{self.es:2}, EF:{self.ef:2}, "
            f"LS:{self.ls:2}, LF:{self.lf:2}, Slack:{self.slack:2}"
        )


# @+node:ekr.20260925131750.1: *3* calculate_critical_path
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


# @-others

# Define tasks with names and durations
data = {
    'A': Task('A', 3),
    'B': Task('B', 4),
    'C': Task('C', 2),
    'D': Task('D', 5),
    'E': Task('E', 3),
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
print(f"\nCritical Path: {' -> '.join(path)}")

# @@language python
# @-others
# @-leo
