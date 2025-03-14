# Orchestration Architect Development Journals

    **Purpose:** This document defines the kinds of development journals, and its uses within Orchestration Architect.

    **Version:** 0.8.0-1

    **Status:** Draft

    **Unique Identifier**: DOCUMENTS:READMES/Development_Journals

    **Tags:** #Journals #Documentation

## Introduction

The **Orchestration Architect - Development Journals** is a documentation system designed to organise different kinds of development documents to facilitate coherence between various development activities.

The intent of these Development Journals is that the information can be more easily addressed.

## Structure of Development Journals

The structure of development journals is to facilitate a semantic way of viewing, accessing and filtering information by users and tools. The development journals should use entry labels that have filenames prefixed with the current date to facilate lexiographical order (`2025-03-03 «Kind of Document» rev.000 - «Title»`). This is to facilitate a birds-eye view of recent activity providing context.

A directory can be used with the same name as the file for provide assets for that document (without the file extension). 

```
.
├── Designs
├── Notes
│   ├── 2025-02-28 Process - Setup Workspace using Worktrees.md
│   └── 2025-03-01 Research - Requirements Engineering Framework
│       ├── Figure 1 - Resource Model Sketch - Distilling SWEBOK Requirement Engineering Processes.dot
│       ├── Figure 1 - Resource Model Sketch - Distilling SWEBOK Requirement Engineering Processes.svg
│       ├── Figure 2 - Prototype - Requirement Process Model.dot
│       ├── Figure 2 - Prototype - Requirement Process Model.svg
│       ├── Prototype - 1 Elicitation - Requirements Engineering Framework.md
│       ├── Prototype - 2 Analysis - Requirements Engineering Framework.md
│       └── Study Notes.md
├── README.md
├── Requirements
│   └── 2025-03-01 Requirements Engineering Framework.md
├── Retrospectives
│   └── 2025-02-14.md
└── Tasks
```

## Development Journals

### Notes

The `Notes` Development Journal is used for prototyping, detailing processes, research and other such activities. The notes should be labelled using the `«Date YYYY-MM-DD» «Note Type» - «Title»`. Notes can be directories, in addition to files. A document that contains assets should make a directory with the same name as the document.

```
Notes/
├── 2025-02-28 Process - Setup Workspace using Worktrees.md
└── 2025-03-01 Research - Requirements Engineering Framework
```

### Requirements

The `Requirements` are documents that are part of the Requirements Engineering Process. The structure of the documents are design to facilitate a way of identifying requirements based on needs.

### Retrospectives

The `Retrospective` Development Journal stores the minutes used to facilitate the continuous improvement processes, and try to find ways to improve development proceses, and review the direction taken.

### Tasks

The `Tasks` Development Journal stores the tasks undergoing in this project.

### Designs

The `Designs` Development Journal stores the designs documents to implement a requirement.













    









