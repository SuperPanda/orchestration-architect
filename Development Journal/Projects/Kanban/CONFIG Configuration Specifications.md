# Kanban: Configuration Subsystem

Configuration Management 

**Configuration Management: Tracking and Management Configurations**

    **Document Type**: Kanban
    **Creation Date**: 2025-04-05
    **Project Code**: LIT_SPEC.CONFIG
    **Resource Identifer**: urn:oa:docs:kanban#LIT_SPEC.CONFIG

## Active Tasks

### Task ARCHITECTURE.001: CREATE A NOTE SPLIT INTO THE DIFFERENT DOMAINS AND ... USE THE COMPLETED TASK-CONFIG.003 TO START REQUIREMENTS -> DESIGN -> SPEC PROCESS 
 
**Created**: 2025-05-10

**Related Tasks**: [Task CONFIG.003](#task-config003-tool-to-view-projects-and-kanban)

STARTING FROM **TASK-CONFIG.003** INTEGRATE THE oa-shell-configuration and oa-tools Deliverables
                     PROTOTYPES, PERHAPS PUT IN REQUIREMENTS. 
                     

**Description** 

AND WHATS IN THE LATEST NOTES

ENSURE WORKSPACE SETUP IN SANDBOX.

Create a `NOTE-XXX` and create an `ARCHITECTURE` that captures the environment variables,
and the natural transformations; which the ARCHITECTURE WILL: (1) Put shell configuration tools in tools, (2)
the functionality added as requirements for project, (3) oa-tools will be where the tools go.. 

```
    USE THE TOOLS AND DOCUMENT HOW IT WORKS. SO THE OA-PROJECT DISPLAY, the fish functions to navigate, 
    the oa-monitor tool that is an OA_TOOLS Sandpit/prototype/oa-mintor... 

    ... INTEGRATE THAT INTO THE FFOLLOWING PROCESSES WHILE MODELLING ...

    **ARCHITECTURE -> OA_TOOLS: Adds SHELL TOOLS AND CONFIG FUNCTIONS FOR PROJECT STUFF**
1 ARCHITECTURE.NOTES <- SANDBOX.CONFIG.REQUIREMENTS_PROCESS: ADD MODELLING OF REQUIREMENTS PROCESS 
                                                             TO ARCH.NOTES, ADD RESEARCH 
                                                             FOR REQUIREMENTS. 
                        
2 ARCHITECTURE.NOTES <- TASK-CONFIG.003 DELIVERED RESULTS: SHOWS RELATIONSHIP BETWEEN DOCS.NOTES, SANDBOX, TASKS, DOCS,
                                REQUIREMENTS, DESIGNS, ... 
                        <- SANDBOX.OA_PROJECT.REQUIREMENTS_PROCESS
                        **REMOVE THE SANDPIT PREFIX**.

3 ARCHITECTURE.NOTES <- LIT-SPEC.DESIGN-001 Literate SPEC: LITERATE SPEC SHELL FUNCTS

3 ARCHITECTURE.NOTES -> LIT-SPEC.DESIGN: USE LIT_SPEC.SHELL_FUNCS DESIGN TO IMPLEMENT LITERATE SHELL FUNCTIONS...
    TO CREATE TOOLS TO CONFIGURE ENVIRONMENT AND CREATE TOOLS. 

4 ARCHITECTURE.NOTES <- NOTES THE ABSTRACT ARCHITECTURE PREORDER MATRIX FROM SOMEWHERE.

5 ARCHITECT.STRUCTURE -> LITERATE README TO GENERATE TOOLS 
6 ARCHITECTURE -> PROJECT.REQUIREMENTS / PROJECT.DESIGHN {GROUP BY ISOMORPHISMS, AND AND ADD PURPOSE AND DESIGN
        FOR REQUIREMENTS / DESIGN / SPECIFICATIONS /RETROSPECTIVES / PROJECTS->TASKS.
        DEMONSTRATE THE BRAIDING WITH THE BRAID DIAGRAM MADe (PROBABLY ON GISTS).
    
1. ARCHITECTURE <- LIT_SPEC FOR SHELL FUNCS DEMO**
ARCHITECTURE -> LITERATE READMES THAT GENERATE TOOLS
ARCHITECTURE -> PROJECT.REQUIREMENTS + PROJECTS.DESIGNS



    *** THESE ARE DELIVERED RESULTS FROM PROTOTYPING A FISH SHELL FUNCTION. 
- [Load Environment Script to apply shell with functions](../../../../sandbox/CONFIG Sandpit/oa-load-environment.fish)

- [Auto-Load Shell Config o Change Dev Tool](../../../../sandbox/CONFIG Sandpit/update-shell-config-on-change.md)

- [Orchestration Architect Shell Functions](../../../../sandbox/CONFIG Sandpit/shell-configurations/orchestration-architect.fish)

    - Set Paths for `OA_{WORKSPACE,DOCS,JOURNAL,TOOLS,NOTES,SANDBOX,KANBANS,PROJECTS}_PATH`
    
    - Added functions to navigate with `oa-{kanban,notes,sandbox,tools}`

    - Added `oa-list-projects function` to run `bat` on PROJECTS_OVERVIEW.md

    - Added `oa-find-{kanban,note}` (CAN STILL ADD)

    - Added `oa-display-projects` to display project lists and redraw if changed (using `entr`). 
`oa-load-environment.fish`, a literate `update-shell-config-on-change.md`



```

## Inactive Tasks

### Task CONFIG.004: USE THE COMPLETED TASK-CONFIG.003 TO START REQUIREMENTS -> DESIGN -> SPEC PROCESS 

**Created**: 2025-05-10

**Description**: After doing some architecture, return here and use the collesced structure, to write the requirements 
and specifications,  and monitoring.

**Related Tasks**: [Task ARCHITECTURE.001](./ARCHITECTURE Kanban.md#task-architect-001) must proceed before "CONFIG.004"

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

**Deliverables**

> **TODO** _ADD DELIVERABLES FOR `LIT_SPEC.CONFIG.001`

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

