# Requirements


## Requirement: Command to Create Tasks

The command line tool should create a task.

**Command:**

    $ OA_DOCUMENTS_WORKSPACE="/home/$USER/repos/orchestration-architect/documentation"
    $ OA_TASKS_PATH="$OA_DOCUMENTS_WORKSPACE/Development Journals/Tasks"
    $ oa-task create "New Task"

**Output:**

    Successfully added task "[OA-TASK-000] New Task" to backlog "/home/user/Documents/Orchestration Architect/Development Journal/Tasks/2025-03-05 OA-TASK-000 Create CLI to manage tasks.md"

## Requirement: Command to Modify Tasks

The command line should allow for tasks to be modified.

**Command:**

    $ oa-tasks modify [OA-TASK-000] --title="Create CLI to manage tasks" --status="Ready for Development"

**Changes:**

```file:2025-03-05 [OA-TASK-000] New Task.md
# New Task
...
> **Status:** Backlog
```

to

```file:2025-03-05 [OA-TASK-000] Create CLI to manage tasks.md
# Create CLI to manage tasks
...
> **Status:** Ready for Development
```

## Requirement: Attach Resources to Task

**Commands**

   $ oa-tasks modify OA-TASK-000 --attach OA-REQUIREMENTS-000

**Changes:**

```
...
> **Related resources:** <urn:oa:requirements:000>
...
```

