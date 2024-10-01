# Orchestration Architect: Project Management Subsystem

**Worktree**: `0.8.0-documents`
**Location**: `project/README.md`

---

## Table of Contents

1. [Introduction](#introduction)
2. [Conceptual Overview](#conceptual-overview)
   - [Terminology and Definitions](#terminology-and-definitions)
3. [System Components](#system-components)
   - [Task Representation](#task-representation)
   - [Symlink-Based State Management](#symlink-based-state-management)
   - [Metadata Handling](#metadata-handling)
   - [Morphisms and Functors](#morphisms-and-functors)
4. [Implementation Guide](#implementation-guide)
   - [Phase 1: Task Creation and Representation](#phase-1-task-creation-and-representation)
   - [Phase 2: State Transitions and Morphisms](#phase-2-state-transitions-and-morphisms)
   - [Phase 3: Functors and External Updates](#phase-3-functors-and-external-updates)
   - [Phase 4: CLI Development](#phase-4-cli-development)
   - [Phase 5: RDF/SPARQL Integration](#phase-5-rdfsparql-integration)
   - [Phase 6: API and OpenAPI Schema Generation](#phase-6-api-and-openapi-schema-generation)
5. [Task Representation Formats](#task-representation-formats)
   - [Single-Line Format](#single-line-format)
   - [Card Format](#card-format)
   - [TUI Representation](#tui-representation)
6. [Conclusion and Future Work](#conclusion-and-future-work)

---

## Introduction

The **Project Management Subsystem** of the **Orchestration Architect** provides a robust, flexible, and extensible framework for task management. It leverages symlink-based state management, morphisms, functors, and RDF representations to ensure seamless integration and scalability.

This document serves as a comprehensive guide to understanding, implementing, and extending the subsystem. It is structured to facilitate indexing and semantic representation of each section, ensuring that every component is composable, extendable, and modifiable.

---

## Conceptual Overview

The subsystem operates through a combination of symlinks, morphisms, functors, and metadata. Tasks are created, managed, and transitioned between states, with each action mapped and tracked for consistency and integration with other systems.

### Terminology and Definitions

- **Task**: A unit of work represented as a YAML file.
- **Symlink**: A symbolic link pointing to a task file, used to represent the task's current state.
- **State**: The current status of a task (`backlog`, `active`, `completed`).
- **Morphism**: An atomic transition of a task from one state to another.
- **Functor**: A mapping that preserves the structure of morphisms, synchronizing changes across subsystems.
- **Metadata**: Additional information stored within a task file, tracking state changes and relationships.
- **RDF (Resource Description Framework)**: A semantic framework used to represent information and relationships.
- **SPARQL**: A query language for RDF, used to retrieve and manipulate task data.
- **URN (Uniform Resource Name)**: A unique identifier for resources, following the `urn:oa:<resource>` schema.

---

## System Components

### Task Representation

Tasks are stored as YAML files in the `tasks/` directory. Each task file contains structured data, including metadata and state history, ensuring easy modification and extension.

**Example Task YAML (`tasks/OA-TASK-001.yaml`):**

```yaml
task_id: OA-TASK-001
summary: "Design the project management subsystem"
status: "active"
priority: "high"
requirements:
  - urn:oa:requirement:REQ-001
linked_tasks:
  - urn:oa:task:OA-TASK-002
description: |
  This task involves designing and implementing the task management system for the Orchestration Architect framework.
metadata:
  created_by: "user"
  created_at: "2024-10-02T12:00:00Z"
  state_changes:
    - state: "backlog"
      timestamp: "2024-10-02T12:00:00Z"
    - state: "active"
      timestamp: "2024-10-02T14:00:00Z"
```

### Symlink-Based State Management

Task states are managed using symlinks distributed across state directories:

- **`backlog/`**: Tasks not yet started.
- **`active/`**: Tasks currently in progress.
- **`completed/`**: Tasks that are finished.

Symlinks point directly to the task files in `tasks/`, ensuring a clean and loop-free structure. State transitions involve moving the symlink to the appropriate directory.

**Symlink Example:**

```
active/OA-TASK-001.yaml -> ../tasks/OA-TASK-001.yaml
```

### Metadata Handling

Metadata is appended to each task file, tracking state changes, creation details, and relationships. It is designed to be easily parsed and updated, facilitating mapping changes as they occur.

**Metadata Structure:**

```yaml
metadata:
  created_by: "user"
  created_at: "2024-10-02T12:00:00Z"
  state_changes:
    - state: "backlog"
      timestamp: "2024-10-02T12:00:00Z"
    - state: "active"
      timestamp: "2024-10-02T14:00:00Z"
```

### Morphisms and Functors

#### Morphisms

Morphisms represent state transitions, modeled as atomic actions:

- **Creation Morphism**: `null` → `backlog`
- **State Change Morphisms**:
  - `backlog` → `active`
  - `active` → `completed`
  - `active` → `backlog` (if task is paused)

These morphisms ensure that state transitions are consistent and traceable.

#### Functors

Functors map morphisms to actions in other subsystems, preserving structure and ensuring synchronization.

- **Symlink Functor**: Updates symlinks during state transitions.
- **Kanban Board Functor**: Updates visual representations.
- **RDF Functor**: Updates semantic data for querying.

---

## Implementation Guide

### Phase 1: Task Creation and Representation

**Objective**: Establish task creation and initial representation.

1. **Create the `tasks/` Directory**:

   ```bash
   mkdir -p project/tasks
   ```

2. **Implement Task Creation Script (`tasks` Script)**:

   ```bash
   #!/bin/bash

   TASK_DIR="project/tasks"

   generate_task_id() {
       last_id=$(ls $TASK_DIR | grep -Eo 'OA-TASK-[0-9]+' | sort | tail -n 1 | grep -Eo '[0-9]+$')
       next_id=$((last_id + 1))
       printf "OA-TASK-%03d" $next_id
   }

   create_task() {
       task_id=$(generate_task_id)
       task_file="$TASK_DIR/$task_id.yaml"
       cat > "$task_file" <<EOF
   task_id: $task_id
   summary: "$1"
   status: "backlog"
   priority: "$2"
   requirements: []
   linked_tasks: []
   description: ""
   metadata:
     created_by: "$(whoami)"
     created_at: "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
     state_changes:
       - state: "backlog"
         timestamp: "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
   EOF
       ln -s "../$task_id.yaml" "project/tasks/backlog/$task_id.yaml"
       echo "Task $task_id created."
   }

   if [ "$1" == "create" ]; then
       create_task "$2" "$3"
   else
       echo "Usage: ./tasks create \"Task Summary\" \"Priority\""
   fi
   ```

3. **Usage**:

   ```bash
   ./tasks create "Design the project management subsystem" "high"
   ```

### Phase 2: State Transitions and Morphisms

**Objective**: Implement state transitions and model them as morphisms.

1. **State Transition Function (`change_task_state`)**:

   ```bash
   change_task_state() {
       task_id="$1"
       new_state="$2"
       task_file="project/tasks/$task_id.yaml"

       # Find current state
       current_state=$(find project/tasks -type l -name "$task_id.yaml" | xargs dirname | xargs basename)

       # Remove symlink from current state
       rm "project/tasks/$current_state/$task_id.yaml"

       # Add symlink to new state
       ln -s "../$task_id.yaml" "project/tasks/$new_state/$task_id.yaml"

       # Update status in task file
       sed -i "s/^status: .*/status: \"$new_state\"/" "$task_file"

       # Append state change to metadata
       sed -i "/state_changes:/a \  - state: \"$new_state\"\n    timestamp: \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"" "$task_file"
   }
   ```

2. **Morphism Mapping**:

   - Creation: `null` → `backlog` (handled during task creation)
   - Start: `backlog` → `active`
   - Complete: `active` → `completed`

### Phase 3: Functors and External Updates

**Objective**: Map morphisms to external systems using functors.

1. **Define Functors**:

   ```bash
   functor_update_kanban() {
       # Logic to update Kanban board representation
       ./update_kanban.sh
   }

   functor_update_rdf() {
       # Logic to regenerate RDF representation
       ./generate_rdf.sh "$1"
   }
   ```

2. **Invoke Functors After State Changes**:

   ```bash
   change_task_state() {
       # Existing state change logic
       # ...

       # Invoke functors
       functor_update_kanban
       functor_update_rdf "$task_id"
   }
   ```

### Phase 4: CLI Development

**Objective**: Develop a user-friendly CLI with fuzzy matching and flexible commands.

1. **Extend `tasks` Script with Commands**:

   ```bash
   # Command parsing
   case "$1" in
       create)
           create_task "$2" "$3"
           ;;
       start|stop|complete)
           task_id=$(fuzzy_match_task_id "$2")
           change_task_state "$task_id" "${1/start/active}"
           change_task_state "$task_id" "${1/stop/backlog}"
           change_task_state "$task_id" "${1/complete/completed}"
           ;;
       list)
           list_tasks "$2"
           ;;
       *)
           echo "Invalid command."
           ;;
   esac
   ```

2. **Implement Fuzzy Matching**:

   ```bash
   fuzzy_match_task_id() {
       input="$1"
       match=$(ls project/tasks | grep -E "OA-TASK-.*$input.*" | head -n 1)
       echo "${match%.yaml}"
   }
   ```

3. **Implement Task Listing**:

   ```bash
   list_tasks() {
       state="$1"
       if [ -z "$state" ]; then
           state="."
       fi
       find "project/tasks/$state" -type l -exec basename {} .yaml \; | while read task_id; do
           task_file="project/tasks/$task_id.yaml"
           summary=$(grep '^summary:' "$task_file" | cut -d '"' -f2)
           status=$(grep '^status:' "$task_file" | cut -d '"' -f2)
           priority=$(grep '^priority:' "$task_file" | cut -d '"' -f2)
           echo "$task_id: $summary | Status: $status | Priority: $priority"
       done
   }
   ```

### Phase 5: RDF/SPARQL Integration

**Objective**: Represent tasks semantically using RDF and enable querying with SPARQL.

1. **Generate RDF Representation**:

   ```bash
   ./generate_rdf.sh "$task_id"
   ```

2. **`generate_rdf.sh` Script**:

   ```bash
   #!/bin/bash

   task_id="$1"
   task_file="project/tasks/$task_id.yaml"

   python3 generate_rdf.py "$task_file" > "rdf/$task_id.ttl"
   ```

3. **`generate_rdf.py` Script**:

   ```python
   #!/usr/bin/env python3
   import yaml
   import sys
   from rdflib import Graph, Namespace, URIRef, Literal
   from rdflib.namespace import RDF

   task_file = sys.argv[1]
   with open(task_file, 'r') as f:
       data = yaml.safe_load(f)

   g = Graph()
   OA = Namespace("urn:oa:")

   task_uri = OA['task/' + data['task_id']]
   g.add((task_uri, RDF.type, OA.Task))
   g.add((task_uri, OA.summary, Literal(data['summary'])))
   g.add((task_uri, OA.status, Literal(data['status'])))
   g.add((task_uri, OA.priority, Literal(data['priority'])))
   for req in data.get('requirements', []):
       g.add((task_uri, OA.requires, URIRef(req)))
   for linked_task in data.get('linked_tasks', []):
       g.add((task_uri, OA.linkedTask, URIRef(linked_task)))
   g.add((task_uri, OA.description, Literal(data['description'])))
   g.add((task_uri, OA.createdBy, Literal(data['metadata']['created_by'])))
   g.add((task_uri, OA.createdAt, Literal(data['metadata']['created_at'])))

   print(g.serialize(format='turtle').decode('utf-8'))
   ```

4. **SPARQL Query Example**:

   ```sparql
   SELECT ?task ?summary WHERE {
     ?task oa:status "active" ;
           oa:summary ?summary .
   }
   ```

### Phase 6: API and OpenAPI Schema Generation

**Objective**: Define an API for the subsystem and generate an OpenAPI schema for integration.

1. **Define API Endpoints**:

   - **`GET /tasks`**: List all tasks.
   - **`POST /tasks`**: Create a new task.
   - **`GET /tasks/{task_id}`**: Retrieve task details.
   - **`PUT /tasks/{task_id}`**: Update a task.
   - **`DELETE /tasks/{task_id}`**: Delete a task.

2. **Example OpenAPI Schema (YAML)**:

   ```yaml
   openapi: 3.0.0
   info:
     title: Orchestration Architect Task API
     version: 1.0.0
   paths:
     /tasks:
       get:
         summary: List all tasks
         responses:
           '200':
             description: A list of tasks
       post:
         summary: Create a new task
         requestBody:
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Task'
         responses:
           '201':
             description: Task created
     /tasks/{task_id}:
       get:
         summary: Get task details
         parameters:
           - name: task_id
             in: path
             required: true
             schema:
               type: string
         responses:
           '200':
             description: Task details
       put:
         summary: Update a task
         parameters:
           - name: task_id
             in: path
             required: true
             schema:
               type: string
         requestBody:
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Task'
         responses:
           '200':
             description: Task updated
       delete:
         summary: Delete a task
         parameters:
           - name: task_id
             in: path
             required: true
             schema:
               type: string
         responses:
           '204':
             description: Task deleted
   components:
     schemas:
       Task:
         type: object
         properties:
           task_id:
             type: string
           summary:
             type: string
           status:
             type: string
           priority:
             type: string
           requirements:
             type: array
             items:
               type: string
           linked_tasks:
             type: array
             items:
               type: string
           description:
             type: string
           metadata:
             type: object
   ```

3. **Generate API Documentation**:

   - Use tools like Swagger UI to generate interactive API documentation based on the OpenAPI schema.

---

## Task Representation Formats

### Single-Line Format

For quick CLI interactions and fuzzy finding:

```plaintext
OA-TASK-001: Design the project management subsystem | Status: active | Priority: high
```

### Card Format

For visual representation in task boards:

```plaintext
+-------------------+--------------------------------------------------------+
| TASK_ID           | OA-TASK-001                                            |
+-------------------+--------------------------------------------------------+
| SUMMARY           | Design the project management subsystem                |
+-------------------+--------------------------------------------------------+
| STATUS            | active                                                 |
+-------------------+--------------------------------------------------------+
| PRIORITY          | high                                                   |
+-------------------+--------------------------------------------------------+
| REQUIREMENTS      | urn:oa:requirement/REQ-001                             |
+-------------------+--------------------------------------------------------+
| LINKED TASKS      | urn:oa:task/OA-TASK-002                                |
+-------------------+--------------------------------------------------------+
| DESCRIPTION       | This task involves designing and implementing the      |
|                   | task management system for the Orchestration Architect |
+-------------------+--------------------------------------------------------+
| METADATA          | created_by: user                                       |
|                   | created_at: 2024-10-02T12:00:00Z                       |
|                   | state_changes: backlog, active                         |
+-------------------+--------------------------------------------------------+
```

### TUI Representation

For terminal-based interfaces, the TUI can display tasks in three modes:

1. **Single-Line Mode**:

   ```
   OA-TASK-001: Design the project management subsystem | Status: active | Priority: high
   ```

2. **Expanded Block Mode**:

   ```
   OA-TASK-001
   Summary: Design the project management subsystem
   Status: active
   Priority: high
   Requirements: urn:oa:requirement/REQ-001
   Linked Tasks: urn:oa:task/OA-TASK-002
   Description: This task involves designing and implementing the task management system.
   Metadata: created_by=user, created_at=2024-10-02T12:00:00Z
   ```

3. **SPARQL Query Mode**:

   - Allows users to input SPARQL queries directly within the TUI to filter and display tasks based on semantic data.

   **Example**:

   ```sparql
   PREFIX oa: <urn:oa:>
   SELECT ?task ?summary WHERE {
     ?task oa:status "active" ;
           oa:summary ?summary .
   }
   ```

   **TUI Output**:

   ```
   OA-TASK-001: Design the project management subsystem
   OA-TASK-003: Implement the RDF integration
   ```

---

## Conclusion and Future Work

The **Project Management Subsystem** provides a flexible and extensible framework for task management within the **Orchestration Architect**. By utilizing symlink-based state management, morphisms, functors, and semantic representations, it ensures consistency and scalability.

### Future Enhancements

1. **Color-Coded Representations**:

   - Implement semantic color coding in TUI and CLI outputs based on task priority and status (e.g., red for high priority, green for completed tasks).

2. **Advanced RDF/SPARQL Querying**:

   - Enhance SPARQL capabilities to allow complex queries, enabling users to filter tasks by metadata, relationships, and semantic context.

3. **API Development**:

   - Develop a RESTful API based on the OpenAPI schema, allowing integration with other tools and services, including potential use with AI models via function calls.

4. **Integration with Other Collections**:

   - Link tasks with other collections like `oa:collection/orchestration_architect.containers`, facilitating broader orchestration across different subsystems.

5. **Automated Indexing and Semantic Representation**:

   - Implement indexing mechanisms to semantically represent each section of the documentation, improving searchability and integration with knowledge bases.

6. **Composability and Extensibility**:

   - Continue to design components that are composable and extendable, ensuring that new features can be added without disrupting existing functionality.

By focusing on these areas, the subsystem will evolve to meet the growing needs of the **Orchestration Architect** framework, providing a robust foundation for task management and orchestration.

---

**Note**: This document is structured to facilitate semantic indexing and easy navigation. Each section is designed to be independently understandable, ensuring that the documentation is both comprehensive and modular.
