# Architecture Views

```d2
vars: {
  d2-config: { layout-engine: elk; theme-id: 300; }
}

classes: {
    column: { label: ""; grid-columns: 1; grid-gap: 0; }
    container: { grid-rows: 1; grid-gap: 0; }
}

style.fill: "transparent";
*.class: container;

Viewpoints.column*.class: column 
Viewpoints.class: container;

grid-gap: 0;
Viewpoints: {
    label: ""
    grid-gap: 10;
    column-1: { 
        label: "ALL\nVIEWPOINT";
        link: "#all-viewpoint"
        }
    column-2: {
        label: "DATA\nAND\nINFORMATION\nVIEWPOINT";
        link: "#data-and-information-viewpoint"
    }
    column-3: {
        label: "STANDARDS\nVIEWPOINT"
        link: "#standards-viewpoint"
    }
    column-4: {
        grid-gap: 0;
        CAPABILITY\nVIEWPOINT: { link: "#capability-viewpoint" };
        OPERATIONAL\nVIEWPOINT: { link: "#operational-viewpoint" };
        SERVICES\nVIEWPOINT: { link: "#services-viewpoint"};
        SYSTEMS\nVIEWPOINT: { link: "#systems-viewpoint" };
    }   
    column-5: {
        label: "PROJECT\nVIEWPOINT"
        link: "#project-viewpoint"
    }
}

```
Adapted from <https://en.wikipedia.org/wiki/Department_of_Defense_Architecture_Framework> as a starting point.

## Architecture Viewpoint

### Overview and Summary

**Mission**
> "Put small things together for some outcome**

**Purpose**
> Create self-contained capabilities into a composable and immediately usable resource

**Objective**
> Achieve dynamic capability through a catalog of resources used to solve problems. (A Minsky-inspired stance on self-organizing systems.)

### Constraints 

* Capabilities are to be written as a literate specification. 

* The *Literate Specification* SHOULD be able 
  to orchestrate the implementation.

* The specifications should be able to work  
  on a *POSIX* compliant system, with minimal 
  external dependencies.
    
* The *specification* SHOULD be composable with other 
  resources.


| Term                         | Definition                                                                                                              |
| ---------------------------- | -----------|
| **Capability**               | A measurable, outcome-oriented function achieved by composing one or more resources.                                    |
| **Resource**                 | A service, system or tool provisioned that can be composed to build capabilities.                                     
| **Dynamic Capability**       | A capability that can be instantiated, composed, and torn down on demand—rather than being a fixed, pre-built component.|


## Project Viewpoint


| PROJECT CODE |    PROJECT DESCRIPTION          |
| -------------|   ------------------------      |
| ARCHITECTURE | Setup Literate Architecture     |
| CONFIG       | Configuration Framework         |
| LIT_SPEC     | Self-Implementing Specifications|    
| MISC         | Clean and Tidy Up Project       |
| OA_MIGRATE   | Document existing architecture  |
| OA_PROJECT   | Formalise Capability Delivery   |    
| OA_TOOLS     | Create and Document Tools       |    
| TERMINAL_AI  | Add multi-model support         |
| $            |                                 |
 ------------------------------------------------

**Current Phase v0.8 `Documentatation Subsystem`** 

> The **Rewrite Bootstrap** will involve capturing the magnitude 
  of capabilities as the migration will involve adding it to the matrix.

**Next Phase v0.8.5 `Rewrite Bootstrap`**

Version 0.9 Distribution and Release Collections Separately


## Data and Information Viewpoint


## Capability Viewpoint

**CV-1: Vision**  The strategic context and overall “vision” a capability.


## Operational Viewpoint


## Service Viewpoint

## Systems Viewpoint

## Standards Viewpoint


## Viewpoint Perspectives

### All Viewpoint
| Model | Description |
|-------|-------------|
| **AV-1** Overview And Summary Information | High-level reference for comparing Architectural Descriptions |
| **AV-2** Integrated Dictionary | Hierarchical data presentation with definitions and sources |

### Capability Viewpoint
| Model | Description |
|-------|-------------|
| **CV-1** Vision | Strategic context for capability groups and transformational endeavors |
| **CV-2** Capability Taxonomy | Hierarchy of current/future capabilities with timeline context |
| **CV-3** Capability Phasing | Stages of capability evolution and implementation |
| **CV-4** Capability Dependencies | Interdependencies and logical groupings of capabilities |
| **CV-5** Capability to Development Mapping | Relationship between capabilities and development initiatives |
| **CV-6** Capability to Operational Activities Mapping | Connection between capabilities and supported operational activities |
| **CV-7** Capability to Services Mapping | Alignment of capabilities with enabling services |

### Data And Information Viewpoint
| Model | Description |
|-------|-------------|
| **DIV-1** Conceptual Data Model | High-level data concepts and relationships |
| **DIV-2** Logical Data Model | Data requirements and business process rules  |
| **DIV-3** Physical Data Model | Implementation format of logical entities  |

### Operational Viewpoint
| Model | Description |
|-------|-------------|
| **OV-1** High-Level Operational Concept | Graphical/textual operational concept |
| **OV-2** Operational Resource Flow | Resource flows between operational activities |
| **OV-3** Operational Resource Flow Matrix | Resource exchange attributes |
| **OV-4** Organizational Relationships | Organizational context and relationships |
| **OV-5a** Operational Activity Decomposition | Hierarchical capability/activity structure |
| **OV-5b** Operational Activity Model | Activity relationships with inputs/outputs |
| **OV-6a** Operational Rules Model | Business rules constraining operations |
| **OV-6b** State Transition Description | Business process responses to events |
| **OV-6c** Event-Trace Description | Action tracing in scenarios |

### Project Viewpoint
| Model | Description |
|-------|-------------|
| **PV-1** Project Portfolio Relationships | Organizational/project dependencies |
| **PV-2** Project Timelines | Program timelines with milestones |
| **PV-3** Project to Capability Mapping | Project alignment with capability achievement |

### Services Viewpoint
| Model | Description |
|-------|-------------|
| **SvcV-1** Services Context | Services, items, and interconnections |
| **SvcV-2** Services Resource Flow | Resource flows between services |
| **SvcV-3a** Systems-Services Matrix | System-service relationships |
| **SvcV-3b** Services-Services Matrix | Inter-service relationships |
| **SvcV-4** Services Functionality | Service functions and data flows |
| **SvcV-5** Operational Activity to Services Trace | Service-to-operational activity mapping |
| **SvcV-6** Services Resource Flow Matrix | Resource exchange details |
| **SvcV-7** Services Measures Matrix | Service metrics over time |
| **SvcV-8** Services Evolution | Service migration/incremental steps |
| **SvcV-9** Services Technology & Skills Forecast | Emerging tech/skills impact |
| **SvcV-10a** Services Rules Model | Service functionality constraints |
| **SvcV-10b** Services State Transition | Service responses to events |
| **SvcV-10c** Services Event-Trace | Service-specific event sequences |

### Systems Viewpoint
| Model | Description |
|-------|-------------|
| **SV-1** Systems Interface | Systems, items, and interconnections |
| **SV-2** Systems Resource Flow | Resource flows between systems |
| **SV-3** Systems-Systems Matrix | Inter-system relationships |
| **SV-4** Systems Functionality | System functions and data flows |
| **SV-5a** Operational Activity to Systems Trace | System function to operational activity mapping |
| **SV-5b** Operational Activity to Systems Trace | System to capability mapping |
| **SV-6** Systems Resource Flow Matrix | Resource exchange details |
| **SV-7** Systems Measures Matrix | System metrics over time |
| **SV-8** Systems Evolution | System migration/incremental steps |
| **SV-9** Systems Technology & Skills Forecast | Emerging tech/skills impact |
| **SV-10a** Systems Rules Model | System functionality constraints |
| **SV-10b** Systems State Transition | System responses to events |
| **SV-10c** Systems Event-Trace | System-specific event sequences |


## Standards Viewpoint

|Models                     |	Descriptions                                          |
----------------------------|---------------------------------------
|StdV-1 Standards Profile 	|The listing of standards that apply to solution elements.
|StdV-2 Standards Forecast 	|The description of emerging standards and potential impact on current solution elements, within a set of time frames.

## Sources
- These are models based on Department of Defense Architecture Framework (DoDAF) Version 2.02
