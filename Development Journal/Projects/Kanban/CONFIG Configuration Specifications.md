# Kanban: Configuration Subsystem

**Project Objective**

Generate a *Configuration Framework* for the Creation, Management 
and Integration amongst the various systems. 

    **Document Type**: Kanban
    **Creation Date**: 2025-04-05
    **Project Code**: LIT_SPEC.CONFIG
    **Resource Identifer**: urn:oa:docs:kanban#LIT_SPEC.CONFIG

## Active Tasks

## Inactive Tasks

### Task CONFIG.004: Create requirements document for the existing configuration subsystem 

**Created**: 2025-05-10

**Description**: Create REQUIREMENTS document to detail the initial requirements 
to ensure the configurations defined in [Task CONFIG.003: Tools to View Projects and Kanban]
are captured, and the work used to create and automate live reloading 
on spec change is captured. The initial requirements for the requirements are:

0) Merge and close tasks [Task CONFIG.001] [Task CONFIG.002]

1) Define what work was done, why it was done, and what has changed because of it.

2) Evaluate the work done in CONFIG.003, and ensure the requirements 
   for its implementation are captured.

3) Evaluate the limitations of the implementation 
   - such as not having a lazy evaluated function 
   - and being limited to fish 

4) Define how this can be composed from different parts 
   - What is `TERMINAL_AI` related 
   - What is `PROJECT` related 
   - What is `ARCHITECTURE` related 
   - What is `TOOL` related

5) Add the requirements `POSIX Shell`  and `FISH` shells 

6) Add the consumers of the configurations 
   - NVIM 
   - SHELLS 
   - TerminalAI

7) Add additional requirements for tools 
   - `oa-monitor`
   - `nvim-orchestration-architect`
   - `terminal-ai`

The result should be a list of goals and problems and a quick 
validity and soundness check. 

The next step is to create tasks for: 1) the design document for the existing solutions, 
for the purposes of making a `LITERATE SPEC` to ensure the tools and 
implementation from work on [Task CONFIG.003: View Projects and Kanbans].

**Related Resources**:

[Task ARCHITECTURE.001](./ARCHITECTURE Kanban.md#task-architect-001)
must proceed before "CONFIG.004"

[Task LIT_SPEC.003](./LIT_SPEC Literate Specifications Kanban.md#task-lit_spec.003)
Very closely related as it is about setting 
environment variables.

### Task CONFIG.002: Build a DESIGN for Configurations

**Description**

To achieve the emergent capability of bootstrapping of literate specifications, we must:

- find previous work on literate specification
- cohere the in development literate specs.

**Notes**
- NOTE-31: urn:oa:docs:note#NOTE-031

**Related Resources**
- NOTE-30
- NOTE-16

RIGHT NOW CREATE A NOTE TO COPY OA-NOTE-31

### Task CONFIG.001: Create REQUIREMENTS DOC for Configurations

Literate Specification for Creating, Tracking and Managing Specifications

**Description**

Analyse the current specifications configuration, and aligh with `XDG_BASE_DIR`s

> **TODO** REVIEW TASK `LIT_SPEC.CONFIG.001` BY COMPLETING ALL THE CHECKLISTS

Prepare to create a `Configurations Literate Specification` updating `OA-NOTE-30` that:

    - [ ] Details the `$XDG_BASE_DIR` directories and their purpose

    - [ ] Details the the configuration of `$XDG_BASE_DIR`

    - [ ] Details the current configurations and contents used for TAI and OA

    - [ ] Details the desired configurations for TAI and OA

    - [ ] Contains `**Task**` labels to move current to desired state

    - [ ] Explore restricting secret variables to systemd secrets and detail the ideas

    - [ ] The `**Task**` are moved into the kanban as tasks to be added to the Literate Specifications.

    - [ ] Scan the repository for references to the current configuration.

    - [ ] Proposing a structure to be able to apply configurations to different shells.

    - [ ] Synced to `public` mirror repository

##  Tasks

### Task CONFIG.003: Tool to View Projects and Kanban**

**Created**: 2025-05-09

**Completed**: 2025-05-10

**Description** 

[Task Notes CONFIG.XXX](../../../../sandbox/CONFIG Sandpit/CONFIG Task Notes.md#task-notes-XXX)

**Resources**

- [Load Environment Script to apply shell with functions](../../../../sandbox/CONFIG Sandpit/oa-load-environment.fish)

- [Auto-Load Shell Config o Change Dev Tool](../../../../sandbox/CONFIG Sandpit/update-shell-config-on-change.md)

- [Orchestration Architect Shell Functions](../../../../sandbox/CONFIG Sandpit/shell-configurations/orchestration-architect.fish)

    - Set Paths for `OA_{WORKSPACE,DOCS,JOURNAL,TOOLS,NOTES,SANDBOX,KANBANS,PROJECTS}_PATH`
    
    - Added functions to navigate with `oa-{kanban,notes,sandbox,tools}`

    - Added `oa-list-projects function` to run `bat` on PROJECTS_OVERVIEW.md

    - Added `oa-find-{kanban,note}` (CAN STILL ADD)

    - Added `oa-display-projects` to display project lists and redraw if changed (using `entr`). 
`oa-load-environment.fish`, a literate `update-shell-config-on-change.md`

