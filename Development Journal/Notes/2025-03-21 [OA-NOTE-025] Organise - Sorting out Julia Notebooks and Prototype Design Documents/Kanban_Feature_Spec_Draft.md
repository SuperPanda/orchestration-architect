# Feature Specification: **Minimalistic Kanban Integration**

     **Metadata**  | **Details**                                   
     ------------- | --------------------------------------------- 
     Title         | Feature Specification: Kanban                 
     Short Code    | OA_FEATURE_001                              
     Domain        | OA_PROJECT (Orchestration Architect Project) 
     URN           | oa:documents:OA_PROJ:Feature.Kanban        
     Branch        | 0.8.0-documents                               
     Document Type | Feature Specification                         
     Status        | Draft                                         


## Minimal Kanban System Design and Implementation Guide

### **1. Overview**

The purpose of this document is to provide a feature specification for implementing a lightweight, text-based Kanban system that adheres to principles of composability and integrates with existing tools. This specification is designed to fulfill a specific need, with clear goals to support a simple, effective workflow using terminal commands, organized by task states. The document aims to be a standard for feature specifications, ensuring that all aspects of development are well-documented, traceable, and internally referencable for consistent application.

### **2. Directory Structure**

The Kanban system uses a directory-based structure to represent different task states:

```julia
using Accessors

resources = Dict(
    :base_path => ENV["HOME"],
    :documents => Dict(
        :source_directory => [:base_path, "Notes"],
        :target_directory => [:base_path, "Documents"],
        :feature_specs => ["Design/Features"]
    ),
    :kanban => Dict(
        :location => [:documents, :target_directory],
        :states => ["backlog", "active", "complete", "archive"]
    )
)

# Using optics to access nested dictionary values
lens = @optic (_)
kanban_dir = joinpath(get(lens(resources), :base_path), joinpath(resources[:kanban][:location]...))

# Create directories for each kanban state
for state in resources[:kanban][:states]
    mkpath(joinpath(kanban_dir, state))
end
```

>   UPDATE! WILL USE EITHER GIT NOTES OR EMBED THE URN DIRECTLY IN THE FILE

>   UPDATE! WILL BE READ FROM NOTES FILES FOR PROCESSING! AND WILL ONLY HAVE:

    - No Status

    - Backlog

    - Active Development

    - Done

>   No extra stages.


- **backlog/**: Contains tasks that are pending or not yet started.

- **active/**: Contains tasks currently being worked on.

- **complete/**: Contains tasks that are done.

- **archive/**: Stores old tasks, helping to maintain a clean history.

Tasks are represented by symlinks in these directories. Each symlink acts as a pointer to the actual task file. This approach allows for easy movement of tasks between different states without duplicating or physically moving the actual files. It helps maintain consistency and reduces overhead.

If tools break or access is restricted, symlinks provide a foundational design that supports manual file manipulation. Tasks can still be managed simply by moving files, while tools like `grep`, `cat`, or `fzf` can be used to view and locate tasks efficiently.

Integrating `fzf` and other terminal-based tools is essential because they form part of the Neovim extensions and terminal scripts deployed by the system. This composability means that small components can be orchestrated to create larger, cohesive systems. These systems can deliver features and functionality vertically (within individual parts) and horizontally (across multiple systems).

### **3. Task Representation**

- **File Format**: Each task is represented in a text file, structured as follows:
  ```
  TASK-001
  Title: Set up minimal Kanban system
  Details:
  - Create symlink manager for tasks
  - Define structure and commands for workflow
  ```
- **Unique Code**: Each task gets a unique identifier, e.g., `TASK-001`, which ensures easy management.
- **Fixed Size Blocks**: Tasks are structured as fixed-sized text blocks, allowing uniform rendering in the terminal.
  - Padding can be added to ensure consistency across all tasks.
- **Audit Trail**: The audit trail for task changes should be managed by using functors to handle logging. This could be implemented as a log, tracked via Git, or integrated with a system like TerminalAI for more advanced tracking. The Kanban will be kept in a separate branch or worktree, ensuring isolation and traceability without modifying task files directly.

### **4. Task Management Command Line Interface (CLI)**

The command line interface (`oa task [action]`) will be used to manage tasks. Using a CLI provides a straightforward and efficient way to interact with tasks directly from the terminal. It allows for quick modifications, seamless integration with other terminal tools, and automation through scripting, making it ideal for managing tasks in a development environment:

#### **4.1 CLI Commands for Managing Tasks**

- **Add Task**: Create a new task in the `backlog/` directory. If arguments are not provided, prompts will guide the user.
  ```bash
  oa task add "Title of the Task" "Details of the Task"
  ```
  If no arguments are provided, the CLI will open a template prompting for the title and details.
- **Move Task**: Move a task between states.
  ```bash
  oa task move "TASK-001" "active"
  ```
- **Edit Task**: Edit details of a task, including the title or description.
  ```bash
  oa task edit "TASK-001" --title "Updated Title" --details "New details added"
  ```
- **Audit Task**: Track an entry to the audit log for a task.
  ```bash
  oa task audit "TASK-001" "Moved to complete"
  ```
- **Git Integration**: Automatically create Git commits when tasks are modified.
  ```bash
  oa task commit "TASK-001"
  ```
  This command will ensure changes are reflected in the Git history with appropriate commit messages.

### **5. Unique Task Codes**

- **Code Generation**: Task codes are generated using a timestamp (`date +%s`) for uniqueness, e.g., `TASK-1645578992`. You could include project prefixes for better context, such as `PROJ-TASK-123`.

### **6. Documentation and Workflow**

- **README.md**:
  - A `README.md` should be maintained in the root directory to describe:
    - Directory purposes (`backlog/`, `active/`, etc.).
    - How to create, move, and modify tasks.
    - The meaning and format of task codes.
  - Example README content:
    ```markdown
    # Minimal Kanban System

    ## Directory Structure
    - **backlog/**: Tasks not yet started.
    - **active/**: Tasks currently being worked on.
    - **complete/**: Finished tasks.
    - **archive/**: Old tasks for future reference.

    ## Task Codes
    Each task has a unique code (e.g., `TASK-001`).

    ## Commands
    - **Add Task**: `oa task add "Title" "Details"`
    - **Move Task**: `oa task move "TASK-001" "active"`
    ```

### **7. Using RDFS for Task Types**

- **RDFS Schema**: Using RDFS, you could formalize attributes and relationships for different task types, making it easier to extend and query tasks.
  - Define RDF classes for different states (`BacklogTask`, `ActiveTask`) and properties (`hasTitle`, `hasDetails`).
  - Use RDFS to extend the model to support additional attributes (e.g., `priority`, `assignedTo`).
  - Define RDF resources to represent arbitrary references, such as linking tasks to Git commits, file paths, content sections, or specific line numbers, enabling precise relationships between different components of the workflow.
  - Create RDF-based functors to establish mappings between workflow stages, Git operations, and other design elements, ensuring system commutativity through morphisms and pullbacks to achieve effects based on the universal properties of certain categories.
  - Consider using a rules engine or semantic tooling to enhance self-documentation and auto-generate schemas. These tools can be integrated with systems like LSP (Language Server Protocol) to facilitate autocompletion and related task discovery.

### **8. Inspiration from Issue Trackers**

- **Labels and Traceability**:
  - Use simple tags (e.g., `#active`, `#complete`) to categorize tasks.
  - Maintain a log of task modifications to track history using Git or a dedicated logging system, rather than appending to task files. Changes can also be linked to Git commit messages to maintain consistency and traceability.
  - Integrate Git to automatically track changes to tasks, ensuring alignment between file history and task progress.
- **High-Level Objectives**:
  - Create an `epics` directory to represent larger objectives composed of multiple tasks.
  - Consider vertical and horizontal composability to extend features and ensure the scalability of the Kanban system.

### **9. Next Steps and Expansion**

- **Task Management Testing**: Start testing the basic Kanban functionality using bash scripts and the CLI.
- **Integrate into Workflow**: Implement this system in an ephemeral container using your nspawn runtime role for isolation and ease of use.
- **Julia and TikZ Visualization**:
  - Use Julia with TikZ to generate diagrams that visualize the state of the Kanban board.
  - Render each aspect of the system in a Pluto notebook and export designs to the documents worktree (`0.8.0-project` branch).

"""

