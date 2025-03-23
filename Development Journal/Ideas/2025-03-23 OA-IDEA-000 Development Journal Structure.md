# The `Development Journal` Idea 
    
    **Title**: The `Development Journal` Idea
    **Description**: Track development such that the fragments of knowledge map to goals
    **Tags**: #Journal #Requirements #Tasks #Kanban #Notes 
    **Status**: Review
    **Created**: 22/03/2025
    **Identifer**: OA-IDEA-000
    **Namespace**: OA-PROJECT

## Rationale

We define a goal as the active effort to reduce the differences between the current state and the desired state. This is achieved through the persistent application of resources, such as writing ideas, working through tasks, and modeling designs. By structuring objects and tasks in a way that allows reconstruction through arrow-object duality, we ensure continuity and coherence.

This idea is inspired by Minsky’s (2008) work, specifically the chapters on Common Sense and Thinking. Additionally, it draws from efforts to develop a category-theoretic model of the SWEBOK Requirements Engineering Process, as well as insights from Software Engineering: A Practitioner's Approach by Pressman and Maxim (2020).

Furthermore, the concept leverages in-document linking through shortcodes and semantic metadata. This enables the dynamic generation of an ontology that facilitates traceability and tracking within a UI, whether web-based or terminal-based (TUI).

## Specifications

All journals will container an unique resource identifer within naming convention: `OA-«JOURNAL TYPE»-«3-digit identifier»`. This ensures structural consistent labeling and independent entity tracking.

### The `Notes` Journal

The `Notes` journal will hold research notes, prototypes and working drafts. Ideally notes these should have inbound links while task is awaiting some notes to be prepared.

A `SUMMARY.md` that will be updated via a function that uses a functor inspired command to ensure:

- Renming is done by binding the replace(Summary Entry) morphism to the Move(Filename Stem). 
- The `SUMMARY.md` will organise the PART HEADINGS as desired.

### The `Ideas` Journal

The `Ideas` Journal contain a `SUMMARY.md` and the `Ideas` Entry will be separed into parts,
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

