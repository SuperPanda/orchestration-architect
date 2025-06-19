# Kanban: Architecture Design and Development

## Active Tasks

### Task Architecture.005: Add Architectural Diagrams Drafts

**Created** 2025-05-30

**Description**

The purpose is to identify architectural diagrams, 
and do architectural concept modelling; as well 
as identify the types of diagrams and models to be 
used.

* Requirements diagrams
* Development Work Process Models
* System Diagrams; Add the TIKZ/PGF ARCHITECTURE Matrix
* Add the Tasks, Braided Monoidal Category D2 Diagrams
* Component/Resource Diagrams 

### Task ARCHITECTURE.004: Architect Developer Journal Integration to `oa` Scheme Handler

**Created** 2025-05-30

**Description**

Setup service for accessing `oa-docs://` and proxy.

If needed replace the `tinyproxy` with custom rust implementation.

Provide deployment capabilities of books.

Provide User Guide for configuring documents.

Prepare the Scheme.

## Inactive Tasks

### Task ARCHITECTURE.001: Preparation for Architecture Development

**Created**: 2025-05-10

**Status**: REVISION_NEEDED

**Description**:

Generate new requirements. 

The task is to model this process `REQUIREMENTS -> DESIGN`, in preparation
for modelling the `ARCHITECTURE` requirements; achieved by reading SWEBOK for REQUIREMENTS and DESIGN (modelling) 
and architectural chapters.

The focus is identify underlying principles, and identify structural and functional relationships 
in the notes.

To begin, create `OA-NOTE` to hold the `Research` used for notes directly based on software engineering source materials.

Within the notes directory create `swe-requirement-notes.md`, `swe-design-notes.md`, and if needed `swe-architecture-notes.md`.

Diagrams should be created in a subdirectory under `assets/{swe-requirements,swe-design,swe-architecture}_figure<2 digit identifier>.d2`.
In the `ARCHITECTURE Sandpit` create `task_architect_001-diagrams`.

### Task ARCHITECTURE.002: Create REQUIREMENT DOC for Architecture Documents

**Description**
Using SWEBOK define what needs to be in Architecture Documents. Add to the `OA Note` created 

## Completed Tasks

### Task ARCHITECTURE.003: Setup Architecture Book Tooling

**Created**: 2025-05-26

**Completed**: 2025-05-30

**Description**: 

Create an `mdbook` in `$OA_SANDBOX_PATH/`. 

Add `d2` preprocessor. Add `run cmd` preprocessor.

**Notes**

Also, created `Daily Notes` for local system.
