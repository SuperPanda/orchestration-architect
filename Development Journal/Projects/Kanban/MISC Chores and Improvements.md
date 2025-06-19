# Kanban *MISC* Chores and Improvements

    **Document Type**: Kanban 
    **Creation Date**: 2025-04-05
    **Project Code**: MISC
    **Resource Identifer**: urn:oa:kanban#MISC
    **Linked Resources**: [*Task Notes* MISC Chores and Improvements](../../../../sandbox/MISC Sandpit/MISC.TASK-NOTES.md)

## Active Tasks

### Task MISC.008 Move `mdbook` stuff from Architecture to `LIT-SPEC`

### Task MISC.XXX: Clean up 

**Created** 2025-05-22

**Description**:
Organize the tasks 

    ```
    ---
    > [Task CONFIG.003](./CONFIG Configuration Specifications#task-config003-tool-to-view-projects-and-kanban)

    A lot of resources developed when building the the tool to view projects and kanban.

    Move the old research to `$OA_SANDBOX_PATH/archived-journals/notes/` and put in its place a symlink (or hardlink) to the 
    latest note. 

    and if easy `pandoc` to render markdown in browser automatically.



    ### Task LIT_SPEC.XXX: Create IDEA DOC for LIT_SPEC fragments.

    For example to include citations and references. Create citation template in `templates/cite-book.fragment.md`.

    Probably stored in a `Shared Data` or `LIBRARY` type directory. A *LitSpec* will probably be the result.

    ### Task OA_TOOLS.XXX: Create REQUIREMENT DOC for `oa-shell-configuration` 

    ### Task OA_TOOLS.XXX: Create REQUIREMENT DOC for `nvim-orchestration-architect`

    ### Task OA_TOOLS.XXX: Create REQUIREMENT DOC for existing `OA Tools`

    **Description**
    Write a requirements document incorporating existing tools.
    including `oa-monitor`, incorporate `oa-workspace` (to be renamed to `oa-setup-workspace`),
    and `oa-setup-shell`.
    For `oa-setup-shell`, see `oa-load-environment.fish` for *copying*, `orchestration-architect.fish` to *fish config*).
    and reference the POSIX SPEC.
    and ` **TASK-CONFIG.003** INTEGRATE THE oa-shell-configuration and oa-tools Deliverables
                         PROTOTYPES, PERHAPS PUT IN REQUIREMENTS. 


    ### TASK MISC.XXX: SORT THIS OUT

    Locate the D2 diagrams from the past. Make d2 automatically render on change with `entr`, 
    **Description** 


    Add the model  .. what model

    AND WHATS IN THE LATEST NOTES  

    ENSURE WORKSPACE SETUP IN SANDBOX.

    Create a `NOTE` for create an `ARCHITECTURE` that captures the environment variables,
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

    - Create a prototype web renderer for markdown and diagrams 
    - Start REQUIREMENTS DOC FOR ARCHITECTURE.
    ---
    ```


## Inactive Tasks 

### Task MISC.007: Imported Daily Notes 

**Description**

Migrate Daily Notes (See [**MISC `Task 007` Notes**]("./MISC.TASK-NOTES.md#MISC.TASK-007")

### Task MISC.001 TerminalAI, DeepSeek and other LLMs Transcript Literate Specification

**Description** Create a Literate Specification for Migrating TerminalAI 

### Task MISC.002: Move the processed transcripts into the transcripts repository.

**Description** Move transcripts from (1) OpenAI Web Export, (2) Playground and (3) DeepSeek. 

### Task MISC.003: Process Tasks Backlog

**Refer to [*MISC Project* Task Notes](./MISC.TASK-NOTES.md#misc.task-003)

## Completed/Discontinued Tasks

### Task MISC.004: TerminalAI NVIM Respond Later Tool *nvim-terminal-ai*

**Description** 

Make Orchestration Architect in Neovim To Add Questions that I want to know, but not right now,
like a passing thought written down and like getting a daily digest.

>   **Status** *Canceled* (reason: don't want to)

