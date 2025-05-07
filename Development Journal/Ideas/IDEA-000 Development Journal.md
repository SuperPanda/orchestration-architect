# IDEA-000 Development Journal   

    **Resource Id**: IDEA-000
    **Description**: A natural coherent framework to braid development and project processes
    **Created**: 2025/03/22
    **Status**: Draft
    **Tags**: #Journal #Requirements #Tasks #Kanban #Notes #Resources
    **Linked Resources**: None (This needs to be moved to the end)

**Additional Resources**

[LIT_SPEC Literate Specfications Kanban]("../Projects/Kanban/LIT_SPEC Self-Bootstrap Literate Specifications.md")

[IDEA-001: Literate Document]("./IDEA-001 Literate Document.md")

[DESIGN-001: Literate Specification]("../Designs/DESIGN-001 Literate Specifications.md")

[Git log of this next commit](git:///srv/git/orchestration-architect#this commit_containing_this__change)

## Rationale

We define a goal as the active effort to reduce the differences between the current state and the desired state. This is achieved through the persistent application of resources, such as writing ideas, working through tasks, and modeling designs. By structuring objects and tasks in a way that allows reconstruction through arrow-object duality, we ensure continuity and coherence.

This idea is inspired by Minsky’s (2008) work, specifically the chapters on Common Sense and Thinking. Additionally, it draws from efforts to develop a category-theoretic model of the SWEBOK Requirements Engineering Process, as well as insights from Software Engineering: A Practitioner's Approach by Pressman and Maxim (2020).

Furthermore, the concept leverages in-document linking through shortcodes and semantic metadata. This enables the dynamic generation of an ontology that facilitates traceability and tracking within a UI, whether web-based or terminal-based (TUI).

A benefit of the standardisation is that it encourages toolchain development, as we will have coherent dynamic decoupled approach.

## Specifications

All journals will container an unique resource identifer within naming convention: 

Filenames will be `«JOURNAL TYPE»-«3-digit identifier»`. The label `OA-NOTE-031` will be renamed to `NOTE-031`,
due to the filenames being unpleasant to read in prior format.

The Literate Tag will use `«JOURNAL-TYPE.UID [name | identifer | location link]»` for example `«IDEA.1 Link»`,
and should return `[IDEA-001 Literate Document](../Ideas/IDEA-001 Literate Document.md`.

These will require a grammar, and any resolution of these tokens within documents, will need to be tracked 
in a table in the appendix. This will allow for flexibility to propagate changes, as the resolved tokens 
can use changes in the grammar to infer a token has been resolved.

This ensures structural consistent labeling and independent entity tracking.

### The `Notes` Journal

✖  The `Notes` journal will hold research notes, prototypes and working drafts. Ideally notes these should have inbound links while task is awaiting some notes to be prepared.

**The NOTES were to dense. Work will be made to depopulate the *NOTES*, notes can be made in the appropriate «NOTE.X».**


**The *DAILY NOTES* are not stored in the repository but *MAY* be configured by the system, with a default 
assumption being on a system in the autological construction, it *SHOULD* by default follow the **ORG.XDG.FreeDesktop Specification**, and are ideally used to add things to sandbox.
And will require ltierate tooling to benefit from this task.**

[NVIM_ORCH_ARCH `nvim-orchestration-architect`]("../Kanban/NVIM_ORCH_ARCH nvim-orchestration-architect")

The [CONFIG Configuration Management Project]("../Projects/Kanban/CONFIG Configuration Specifications.md") will 
provide the necessary resolution paths and allow tools to become available as they are developed. This is achieved
by ensuring the `tools` workspace is supplied as a path to the different shells.

In addition, this will facilitate development by ensuring all the components have a common configurations in a 
particular environment.

```d2
"IDEA-000 Development Journal" -> "DESIGN-001 Literate Specification" -> "SPEC-001 Literate Documents"
"SPEC-001 Literate Documents" -> "DESIGN-002 Configuration Management"
```

The `Project Overview` 

A `PROJECT_OVERVIEW.md` that will be updated via a function that uses a functor inspired command to ensure:

- Renming is done by binding the replace(Summary Entry) morphism to the Move(Filename Stem). 
- The `PROJECT_OVERVIEW.md` will organise the PART HEADINGS as desired.

### The `Ideas` Journal

The `Ideas` Journal should contain a programmatically updated `IDEAS_SUMMARY.md`, and the `Ideas` Entry will be retrivable with the Literate Tools when available.

The `Ideas` should cite possible resources to work on the tasks, by referring to Notes.

The `Ideas` Journal Entries will use checkmarks/crosses or blanks.

The command line interface will will run the MDBOOK for the Ideas `PROJECT_OVERVIEW.md`

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

```d2
Dev Journal {
    Projects: |md 

        # Project Summary 

        ## Active Projects

        - [PROJECT_TAG Kanban](./Kanban/PROJECT_TAG)        
    
        ## Inactive Projects 
        
        - [Backlog Project Kanban]() 
        - [PROJECT_TAG Paused Project Kanban](./Kanban/PROJECT_TAG)
        ...
    
        ## Completed/Discontinued Projects 
        
        - [PROJECT_TAG Completed Project Kanban](./Kanban/PROJECT_TAG)
        - [PROJECT_TAG Terminated Project Kanban](../../Sandbox/PROJECT_TAG Project Label/PROJECT_TAG")        
    |

    Project.Kanban:

        Example: |md
        
        # PROJECT_TAG PROJECT_TITLE Kanban

        ## Active Tasks 

        ### **Task 001**: TASK_TITLE 

        **Description**

        **Task Notes**
        
        > **UPDATE TASKS NOTES ARE STORED IN A *SANDPIT* WITH LINKED DATA BEING MOVED INTO NOTES.**

        - [NOTE-100: Task Notes for PROJECT_TAG.TASK_NUMBER](../Notes/DATE NOTE_UID Task - Notes for Task TASK_ID/Task LIT_SPEC.001.md)
        Alternatively Notes can be added here. 

        **Deliverables**
        
        - [Example of Bootstrapable Specification SPEC](../Specfications/SPEC-000 Literate Specification.md)
                
        - [Example of Design DESIGN](../Designs/DESIGN-000 Specification.md)
        
        

        ## Inactive Tasks 
        
        ...

        ## Completed/Discontinued Tasks 

        ...
        |
    }

    
    Projects -> Project.Kanban    
    Project.Kanban.Task -> Notes.Task Note: add task notes
    Idea -> Notes.Idea Note -> Idea: refine idea in notes
    Idea -> Project.Kanban.Task -> Design: Add task to create design
    Design -> Project.Kanban.Task -> Specification: Add task to implement design
    Specification -> Implementation: All specifications can build its implementation

    # Daily Notes -> [Idea; Projects; Projects.Kanban;]
    
}

```

## Requirements

Need to add Requirements Model.

## User Stories

## Provide Language Server Protocol for Context Resourcefulness

- A user is writing a design doc. To speed up the process,
  the process can inject useful examples into the templates to ensure 
  adherence to architecturally significant decisions, and to ensure 
  requirements,  designs, specifications and active tasks and projects.


### Pause and Resume Projects and Tasks

Open `Development Journal/Projects/PROJECT_OVERVIEW.md`.

The `Active Projects` point to the Kanban that shows `Active Tasks`.

When switching projects:

- move the current project from `Active Project` to `Inactive Project`

- move the project being worked on from `Inactive Project` to `Active Project`

When removing a project, if the resource is abandoned, it should move to `../../../sandbox/OA_PROJECT Sandpit`

- move the project being worked on from `Inactive Project` to `Active Project`

Do the same in the Kanban when switching tasks.

To extend to multiple developers, add a field to track users and when no users are developing a project it moves.

The beauty of this is that pausing and resuming work on a project will maintain the current tasks, so the project is managed upstream, so when resuming a project, the current tasks is preserved for that project.

Also when projects and tasks are moved, they are moved to the top of the Inactive or Active list, mapping the temporal pre-order to a spatial pre-order. The top of the sections are either recently paused, or least recently added (probably the core ideas).

### Adding Projects 

✖  To add a candidate project, add it to the end of the `#inactive` projects with no link so that it can be adjusted easily.

**PROJECTS SHOULD NOT BE EASY TO ADD, ONLY VIEW AND MOVE**

The addition of a project needs to go through the requirements process.

## Additional Considerations 

Terms used throughout documents, and in particular documents that realises the need 
for a potential resource to achieve a capability should be appended to the document in a 
parsable table. These will be generated using a region (boundary-based operants) parser from a 
*specificied grammar* in a document follow a *specified document structure*.

Diagrams should be generated based on the structure ensuring the system is able to 
preserve the integrity of the systems.

```
## Appendix

### Glossary 

**Used to power a semantic web of VOCABULARY, TERMINOLOGY and INTER-DOCUMENT references**

### Table of Figures

**Used to render and embed th diagrams using literate tools, or provide citations**

### References 

**CITED WORKS, ADDITIONAL DENOTIONAL AND NORMATIVE REFERENCES AND INFORMATION RESOURCES**


```

## Future Work 

Future work includes making a resource resolution engine and protocol. This 
will be implemented as a Language Server, with a translation of an `oa://` scheme
to map to the protocol, and to access resources, both internal and external to the 
project. For example `oa+rust://` could be implemented as the translation of resources and materials
used to build rust applications.

Additional projects will likely include `KNOWLEDGE MANAGEMENT` which will provide a manner 
to extract data and create mappings of information contextually relevant. The vision for this 
is generating a framework for data mining and discovery, and for a semantic web, to be readily 
accessible via various channels (CLI, TUI, HTTP, etc.).

