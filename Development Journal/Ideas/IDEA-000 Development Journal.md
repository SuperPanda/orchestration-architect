# IDEA-000 Development Journal
    
    **Resource Id**: OA-IDEA.000
    **Description**: Track development such that the fragments of knowledge map to goals
    **Created**: 22/03/2025
    **Status**: Draft
    **Tags**: #Journal #Requirements #Tasks #Kanban #Notes 
    **Related Resources**: OA:PROJECTS#LIT-SPEC OA:IDEA:000

**Related Resources**:

- [OA-PROJECT.LIT-SPEC](../Projects/Kanban/LIT-SPEC Self-Bootstrap Literate Specifications.md): Kanban for the Literate Specification Project

- [OA-IDEA.001](./IDEA-001 Literate Document.md): The ideas behind Literate Writing.

## Rationale

We define a goal as the active effort to reduce the differences between the current state and the desired state. This is achieved through the persistent application of resources, such as writing ideas, working through tasks, and modeling designs. By structuring objects and tasks in a way that allows reconstruction through arrow-object duality, we ensure continuity and coherence.

This idea is inspired by Minsky’s (2008) work, specifically the chapters on Common Sense and Thinking. Additionally, it draws from efforts to develop a category-theoretic model of the SWEBOK Requirements Engineering Process, as well as insights from Software Engineering: A Practitioner's Approach by Pressman and Maxim (2020).

Furthermore, the concept leverages in-document linking through shortcodes and semantic metadata. This enables the dynamic generation of an ontology that facilitates traceability and tracking within a UI, whether web-based or terminal-based (TUI).

## Specifications

All journals will container an unique resource identifer within naming convention: 

> For FS it will be `«JOURNAL TYPE»-«3-digit identifier»`. As `OA-NOTE-031` is NOTE-031.

> The Literate Tag will use `«JOURNAL-TYPE».«UID»` for example `IDEA.0`.

This ensures structural consistent labeling and independent entity tracking.

### The `Notes` Journal

The `Notes` journal will hold research notes, prototypes and working drafts. Ideally notes these should have inbound links while task is awaiting some notes to be prepared.

A `SUMMARY.md` that will be updated via a function that uses a functor inspired command to ensure:

- Renming is done by binding the replace(Summary Entry) morphism to the Move(Filename Stem). 
- The `SUMMARY.md` will organise the PART HEADINGS as desired.

### The `Ideas` Journal

The `Ideas` Journal contain a `SUMMARY.md`, and the `Ideas` Entry will be separed into parts,
The `Ideas` should cite possible resources to work on the tasks, by referring to Notes.
The `Ideas` Journal Entries will be checkmarks/crosses or blanks.


The command line interface will will run the MDBOOK for the Ideas `SUMMARY.md`

The `Tasks` Journal will contain a Kanban that is organised such that it maps the `KANBAN.md` Tasks, the `KANBAN.md` can have different Part headings to define *PROJECTS*. Such that the aim of the resources can be used to semantically map the purpose of the resource of why it was created.

### The `Project` Journal 

The `Project` Journal will hold the Individual Project Overviews hold the contain the scope of the tasks and `Project Overview` providing a shortcode changes and will define the original `Ideas` entry or `Retrospective` section and the commits/repositories/tasks related to the project. The Tasks/KANBAN will provide a summary and will link resources together. The Project Entry will contain the 
Project Outline (AIM), The List of Resources (Resources), and track the activity (The Continuous of the Activity.) 

A proposed structured could be a document that gets filled in with links to other documents. 

### The `Requirements` Journal 

The `Requirements` will be used to store requirements to a projects. The requirements is needed to link problem and goals to tasks. 

### The `Design` Journal will reify `Ideas` Entries into `Tasks`

The `Designs` should capture the `Requirements` by identifying a problem and an aim, with the structure detailing how the gap is minised by between `Aims`. The goal will model the problem and propose a way to use a resource to achieve an aim.

## The `Development Journal` Architecture 

```
Dev Journal {
    Projects: |md 

        # Project Summary 

        ## Active Projects

        - [PROJECT_TAG Kanban](./Kanban/PROJECT_TAG)        
    
        ## Inactive Projects 
        
        - [Backlog Project Kanban]() 
        - [PROJECT_TAG Paused Project Kanban](./Kanban/PROJECT_TAG)
        ...
    
        ## Concluded Projects 
        
        - [PROJECT_TAG Completed Project Kanban](./Kanban/PROJECT_TAG)
        
    |

    Project.Kanban:
        Example: |md
        
        # PROJECT_TAG PROJECT_TITLE Kanban

        ## Active Tasks 

        ### **Task 001**: TASK_TITLE 

        **Description**

        **Task Notes**
    
        - [NOTE-100: Task Notes for PROJECT_TAG.TASK_NUMBER](../Notes/DATE NOTE_UID Task - Notes for Task TASK_ID/Task LIT-SPEC.001.md)
        Alternatively Notes can be added here.

        **Deliverables**
        
        - [Example of Bootstrapable Specification SPEC](../Specfications/SPEC-000 Literate Specification.md)
                
        - [Example of Design DESIGN](../Designs/DESIGN-000 Specification.md)
        
        

        ## Inactive Tasks 
        
        ...

        ## Completed Tasks 

        ...
        |
    }

    Projects -> Project.Kanban    
    Project.Kanban.Task -> Notes.Task Note: add task notes
    Idea -> Notes.Idea Note -> Idea: refine idea in notes
    Idea -> Project.Kanban.Task -> Design: Add task to create design
    Design -> Project.Kanban.Task -> Specification: Add task to implement design
    Specification -> Implementation: All specifications can build its implementation

    Daily Notes -> {
        Idea; Projects; Projects.Kanban;
    }
}

```

## Requirements

Need to add Requirements Model.

## User Stories

### Pause and Resume Projects and Tasks

Open `Development Journal/Projects/Summary.md`.

The `Active Projects` point to the Kanban that shows `Active Tasks`.

When switching projects:

- move the current project from `Active Project` to `Inactive Project`

- move the project being worked on from `Inactive Project` to `Active Project`

Do the same in the Kanban when switching tasks.

To extend to multiple developers, add a field to track users and when no users are developing a project it moves.

The beauty of this is that pausing and resuming work on a project will maintain the current tasks so the project is managed upstream, so when resuming a project, the current tasks is preserved for that project.

Also when projects and tasks are moved, they are moved to the top of the Inactive or Active list, mapping the temporal pre-order to a spatial pre-order. The top of the sections are either recently paused, or least recently added (probably the core ideas).

### Adding Projects 

To add a candidate project, add it to the end of the `#inactive` projects with no link so that it can be adjusted easily.


