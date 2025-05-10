# Kanban

    **Document Type**: Kanban
    **Creation Date**: 2025-04-04
    **Project Code**: LIT_SPEC
    **Resource Identifer**: [urn:oa:docs:kanban#LIT_SPEC]

## Introduction

 **Project Objective**

Generate a *Literate Specification* framework that 
facilitates the design of self-assembling specifications.

## Active Tasks 

## Inactive Tasks 

    

---

### Task LIT_SPEC.008: Finish the `RETROSPECTIVES.md` Literate Specification

**Created**: 2025-05-10

**Notes** [Task Notes LIT_SPEC.008](../../../../sandbox/LIT_SPEC Sandpit/LIT_SPEC Task Notes.md#task-lit-spec-008)

**Description**

The `$OA_RETROSPECTIVES_PATH` contains *drafts* in the [LIT_SPEC Sandbox](../../../../sandbox/LIT_SPEC Sandpit/).

### Task LIT_SPEC.006: Create `DESIGN-000 Literate Document`

**Created**: 2025-04-12

**Description**

Complete the `DESIGN-001` Literate Specification` so that it can be used to organise development.

This will generate a backlog of tasks. However, the goal is to resume **[`TASK.LIT_SPEC.003`](<LIT_SPEC Self-Bootstrapping Literate Specifications#Task LIT_SPEC.003: Focus Literate Spec Development>)**

```text
[ ] Added Diagrams
[ ] Review Content 
[ ] Generated a Template with descriptions
```




### Task LIT_SPEC.003: Focus Literate Spec Development 

**Created**: 2025-04-09

**Description**:
Focus on immediate capabilities.

*Capability: `Set Environment Variables`*

```bash,«default path configuration»
    #!/bin/bash

    # oa:env:config:paths#oa.config
    setenv OA_CONFIGS_PATH "$HOME/.config/orchestration-architect"

    # oa:env:config:paths:#oa.workspace 
    setenv OA_WORKSPACE_LOCATION "$HOME/repos/orchestration-architect"

    # oa:env:config:paths#oa.documents
    setenv OA_DOCS_PATH "$OA_WORKSPACE_PATH/documentation"

    # oa:env:config:paths#oa.dev-journals
    setenv OA_DEV_JOURNALS_PATH "$OA_DOCS_PATH/documentation/Development Journals"

    # oa:env:config:paths#oa.notes
    setenv OA_NOTES_PATH "$OA_DEV_JOURNAL_PATH/"
```

![Literate Specification Capability and Resource Model](../../Notes/2025-04-09 [OA-NOTE-031] Draft - Achieve Literate Competency OA-LIT_SPEC/lit-spec.svg]

**Deliverables**

```text
U+2022 • U+25E6 ◦ U+2714 ✔ U+2718 ✘

• [ ] Execute Literate Spec
• [ ] Default to using XDG Directories
• [ ] Resource: Bootstrapped `LIT_SPEC` generates:
• [ ] Executable tools for `zsh`, `bash` , `fish` executio    
    ◦ [ ] Orchestration of VIM operations      
    ◦ [ ] Configurations 
```

**Resource: VIM Literate Capability**

```text
- [ ] Copied Daily Note to **OA-NOTE-031**
- [ ] Organised the Literate Specification Development
- [ ] Can `ls` environment variable paths

```

**Notes**

```text
Configured path used in environment: 

- ["oa:env:config:paths","#oa.config"]

   "#oa"
    - "config"
    - "workspace"
    - "docs"
    - "dev-journals"
```
 
```
setenv OA_DOCUMENTS_PATH "$HOME/repos/orchestration-architect/documentation"

# oa.dev-journal
setenv OA_DEV_JOURNAL_PATH "$OA_DOCUMENTS/Development Journal"
setenv OA_NOTES_PATH "$OA_DEV_JOURNAL_PATH/Notes"

# oa.dev-journal.projects
setenv OA_PROJ_DOCS_PATH "$OA_DEV_JOURNAL_PATH/Projects"

# oa.dev-journals.ideas 
setenv OA_IDEAS_PATH: "$OA_DEV_JOURNAL_PATH/Ideas"
```

Applying the difference engine process to achieve literate capability between the lit specs and prototypes.

**Relevant Resources**

- [NOTE.30]()

- [NOTE.16]()

### Task LIT_SPEC.001: Generate a Demonstrative Literate Specification

**Description**

Build a self-bootstrapping literate specification example for a tool that allows deep seek transcript to be extracted from IndexedDB, that is executed by running a command in the specification.

**Status**: This may be merged into `OA-PROJECT.TAI`

**Deliverables**


```text
U+2022 • U+2714 ✔ U+2718 ✘

• [ ] A bootstrappable literate specification stored in `urn:oa:spec#tool.tai.import-browser-transcripts` (`$HOME/repos/orchestration-architect/documentation/Development Journal/Specifications/`) that has a `status` of `Active`

• [ ] Set up a configuration such that the specifications in the `$XDG_CONFIG_DIR/terminal-ai/config`

• [ ] Specification is mirrored publically

• [ ] A tool is generated and is stored in the `tools` worktree.

• [ ] Extracts directly from browser or manually from clipboard.
```


The current content of `$XDG_CONFIG_DIR/terminal-ai/config`

    TRANSCRIPT_PATHS=$HOME/repos/terminal-ai-transcripts/default/
    

The current content of `$XDG_CONFIG_DIR/fish/config.fish` 

```
if status is-interactive
    # Commands to run in interactive sessions can go here
    set OA_TOOLS_PATH $HOME/repos/orchestration-architect/tools
    set EDITOR nvim
    set -a PATH $OA_TOOLS_PATH
    set -a PATH $HOME/.local/bin
    set -a PATH $HOME/.cargo/bin
    source $OA_TOOLS_PATH/activate-terminal-ai.fish
end
```

Also note, I need to move the entry for fish config for terminal ai to`.


### Task LIT_SPEC.002: Generate Literate Specification for Literate Specifications 

**Description**

Write a self bootstrapping literate specification for literate specification that describes and uses as a starting point `urn:oa:docs:spec#tool.tai.import-browser-transcripts`.

The literate specification should define architectural structure be able to scaffold new literate specifications, and describe the operations allowed as primitives.

**Related Resources**

[Abstract Compositional Topology]()

**Deliverables**

- [ ] Import and attach related resources:
    - [ ] Literate specifcation experiment
    - [ ] Transcripts 
    - [ ] Other `OA-NOTES`

- [ ] The literate specification that can scaffold new literate specification
- [ ] The literate specification generates tools that can 

### Task LIT_SPEC.005: Add recursive macro resolution for `urn:oa:spec#oa.literate-specs`

**Description**

Previous experiments 

**Deliverables**

- [ ] Added related resources from notes
- [ ] Implements and details recursive macro resolution
- [ ] Notes from resources are used to add additional extensions 


**Notes** 

Some interesting experiments should allow things like: 

- [ ] Ctag integration (**TODO** move to new task)
- [ ] Tool to be able to verify 
- [ ] Rust Literate specifications (Weave and Tangles)
- [ ] Create commands to modify documents and keep them in sync 


## Completed Tasks

### Task LIT_SPEC.004: Check progress and take inventory

**Created**: 2025-04-09

**Completed**: 2025-04-09

**Description**

[Task Notes LIT_SPEC.004](../../../../sandbox/LIT_SPEC Sandpit/LIT_SPEC Task Notes.md#task-lit-spec-004)
> Prepare the project so that work can be continued later.

