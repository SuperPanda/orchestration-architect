# Documentation Subsystem Architecture

## Architecture Viewpoint

### Overview and Summary

**Mission**
> "Put small things together for some outcome**

**Purpose**
> Create self-contained capabilities into a composable and immediately usable resource

**Objective**
> Achieve dynamic capability through a catalog of resources used to solve problems. (A Minsky-inspired stance on self-organizing systems.)

### Constraints 

* Quick Delivery of Small Workable Composable Products Preferred

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

... capabilities should record this in a matrix ...
... xdg spec ... should have link to this spec...

Capability using ... `oa://` facilitiates compositional
extension of resources. 

... this should go under service ... Link to [`oa` Scheme Handler]()


Conceptual Layer | Concepts and Purpose / SCHEME / curie grammars   |
Logical Data Model | Function and Form/ RDFS/Classes/Content / table for iris |
Physical Data Model | Templates and Paths/Location/RDF/Structure  |


## Capability Viewpoint

**CV-1: Vision**  The strategic context and overall “vision” for the “instant markdown” capability.

Use a directory of Markdown as a live, first-class documentation environments 
with automated rendering, live reload, and composable linking 
so that writing, organizing, and consuming documentation happens 
in the same seamless loop as writing code. 

> **Capability: [LIT_SPEC Self-Implementing Literate Documentation]**
>
> Provisions documentation that will 
> use the `oa://` scheme, to ensure that 
> linked resources can be accessed via the 
> conceptual relations.
> Provides live rendering of commands and diagrams 
> Interfaces with other existing subsystems.
> Provides immediate access to resources accessible 
> on the system running.


| CAP-ID	   |     Capability Name	          | Description  |
|--------------|----------------------------------|--------------|
| CAP-IMD-001  | Live Markdown Build               | Finalizing   |
| CAP-IMD-002  | Inline Diagram Rendering          | Completed    |
| CAP-IMD-003  | Inline Command Execution          | Completed    |
| CAP-IMD-004  | Custom URI Resolution             | Finalizing   |
| CAP-IMD-005  | Self-Implementation Literate Spec | In Progress  |


| CAP-ID       | Depends On                                                                                       |
|--------------|---------------------------------------------------------------------------------------------------|
| CAP-IMD-001  | `docs/*.md`, `svc-mdbook`, `svc-tinyproxy`, `System-Docs-Build`                                   |
| CAP-IMD-002  | `docs/*.d2`, `svc-mdbook-d2`, `System-Docs-Build`                                                  |
| CAP-IMD-003  | Code-block syntax in Markdown, `svc-mdbook-cmdrun`, `System-Docs-Build`                            |
| CAP-IMD-004  | `oa://` URIs in Markdown, `svc-oa-handler`, `System-Env-Shell`                                      |
| CAP-IMD-005  | OverlayFS tooling, mount scripts, “sandbox” config in `config/services/overlayfs.toml`             |
| CAP-IMD-006  | Dockerfile or nspawn config, `System-Docs-Build` base image, `config/services` templates          |


* Completed when [Capability: Provision Literate Documents](oa://docs/#documentation-subsystem) 


**the risk being too much documentation...
requiring the DIV to be specificed, so it can be executed 
repeatedly and reliable... so once its in **Data Information Viewpoint** 
its all acciessble. and since this all is one thing of work.
It goes in spec, and provides not only the specification 
for the litearte system, but is its implementation.**


capability: **so the capability is to be able to instantly 
provision and use and work with large amounts of 
markdown documents, and instantly provision 
document environments**


## Operational Viewpoint

allows rapid workflow through large amounts of data.

by adding a quick way to add collections of documents 
to the `oa://` scheme, 
it will provide the capability to 
instantly be able to manage with large amounts 
of data and be able to use it and manage it better.


    ... retrospectives ... 
    ... requirements ...
    ... the design and implementation ...
    ... prototyping and verification ... oa-monitor shows files being changed.
    ... writing specifications ...
    ... ....

## Service Viewpoint

> **A independent logical unit of work or functionality**

| Service Name        | Description / Interface                                                              | Consumed By                       |
|---------------------|---------------------------------------------------------------------------------------|-----------------------------------|
| `svc-mdbook-d2`      | Preprocessor for mdbook that transforms every `*.d2` into inline SVG.                 | `svc-mdbook` (the overall build)  |
| `svc-mdbook-cmdrun`  | Preprocessor that executes code blocks and injects their output into the HTML.        | `svc-mdbook`                      |
| `svc-tinyproxy`      | Reverse proxy that serves the target path where `mdbook` is configured to run `oa://docs/` or whatever was configured...  | Browser, `svc-oa-handler` |
| `svc-oa-handler`     | Listens for `oa://…` URIs, directs to `svc-tinyproxy` to `redirect host` to live update version. If configured then send to non updating version. | Any tool or user clicking `oa://` |


| Service Name       | Hosted On System            | Notes                                        |
|--------------------|-----------------------------|----------------------------------------------|
| `svc-mdbook-d2`     | System-Docs-Build            | Installed via `cargo install mdbook-d2`.     |
| `svc-mdbook-cmdrun` | System-Docs-Build            | Installed via `cargo install mdbook-cmdrun`. |
| `svc-tinyproxy`     | System-Docs-Build            | Config loaded from `ENV VARS` or `$XDG_HOME_CONFIG/orchestration-architect/services.conf` |
| `svc-oa-handler`    | System-Env-Shell             | Registered via `xdg-mime default oa-handler`. |

SvcV-4: Services Functionality (Data Flows)

    ***For each service, describe its main function in a short bullet or two.***

    Example Fill-In:

        svc-mdbook-d2

            Input: any .d2 files found in target directory

            Action: runs d2 compiler in “inline” mode, generating SVG.

            Output: inlined <svg> tags inside.

        svc-mdbook-cmdrun

            Input: any code fences marked for execution (e.g. sh cmdrun).

            Action: spawns a shell, runs the command, captures STDOUT.

            Output: injects the STDOUT as a code block into the HTML.

        svc-tinyproxy

            Input: HTTP requests on port 8888.

            Action: proxies them to file://docs/book/html/… or the local web server.

            Output: returns HTML/CSS/JS content to browser.

        svc-oa-handler

            Input: oa://… link from anywhere.

            Action: rewrites to http://localhost:8888/…, runs xdg-open.

            Output: user’s default browser opens at that URL.



**oa-scheme handler**  composes with system docs handler 
to be able to provide a system-system gateway, 
and a human-system gateway, when trigger by browser, 
or tooling 

**svc-mdbook-d2** provides a rapid tool to 
modelling complex and analysis deep concepts.

**svc-mdbook-cmdrun** Provides a rapid way 
to report and update information.

- ...
- Terminal AI - allows one shot messages via 
nvim or terminal... preventing brain root

```
- Tools - find things etc.
- NVIM
- Linked resources 
- OA SUBSYSTEMS
- Services
- Shell - ...
- Literate - ...
```

## Systems Viewpoint

    **PROMPT: INTERACTIONS 

> WORK NEEDED HERE This should be when a few it edited, 


**Literate-Document** - Structured Document Enriched with `POSIX` Compliant Scripts 
the weave the literate codeblocks to implement specifications, by weaving the 
tokens contained in the `«bootstrap literate spec»` codeblock. See Literate Spec....


**Application-...-XDG** - The `XDG` Specificied  `$PATHS` and `$XDG_HOME_CONFIG`..
make general enough...

....

Provides cohesive interface literate writing environment and access to information creating 
a human-technical interface to create and get feedback.

Later... Possibly add NVIM, LSP... 

| Source System        | Destination System      | Interaction / Protocol                                           |
|----------------------|-------------------------|------------------------------------------------------------------|
| `Local-Env-Shell`    |  `Literate-Document`    |  Run `tail -n1 | sh` to trigger document Self-assembly           | 
... literate-documents setups configures things in xdg config directories, or paths...
... proxy pid is put in `$XDG_RUNTIME_PATH`...
| `System-Docs-Build`  | `System-Env-Shell`      | Pushes build logs or “build success” notifications to shell. Or logs to `$XDG_<APPROPRIATE USER LOG>` |
| `systemd ---user` ... optionsal


**System-Env-Shell** - provides the environment  
for Data and Information Exchange between components 

> **Notes for me to remember to add after the sample ARCHITECTURE VIEW sample**
>   ... meta components for subsystem components
>       and infrastructure components...
>   ... meta role, meta playbook, meta template, meta orchestrator...
>       ... the self assembling, self-modifying, user/machine collaborative management...
>       ... components built from specifications ...
>       ... 
>       ... storage subsystem - loop device, partition, luks, filesystem, subvolumes, mounts...
>       ... composable storage... 


>   ... OA002 PXE Booted Ephemeral (ALL THE SECURITY STUFF)... the built deployable OS ...
>   ...OA001 LUKS Transient Master Control USB, the self-assembling OS...
    

## Standards Viewpoint

    ... need table here for every standard used per spec...
    ... then i link here... so oa://docs/standards/....
rfc, xdg, ieee, iso, posix, commonmark, yaml spec...

**XDG Desktop provides configuration location to store env vars** 
**commonmark allows rendering**
**posix... well fish aint posix, but its a initial 
object for bootstraping**

| Standard     | Applies To                        | Link / Notes                                                                                                               |
| ------------ | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| CommonMark   | Markdown rendering                | [https://commonmark.org](https://commonmark.org)                                                                           |
| MDBook Spec  | Book building & preprocessor APIs | [https://rust-lang.github.io/mdBook](https://rust-lang.github.io/mdBook)                                                   |
| D2 Spec      | Diagram syntax & plugins          | [https://d2lang.com](https://d2lang.com)                                                                                   |
| XDG Base Dir | Config file locations             | [https://specifications.freedesktop.org/basedir-spec/latest/](https://specifications.freedesktop.org/basedir-spec/latest/) |
| POSIX Shell  | Shell script compatibility        | fish isn’t fully POSIX—watch for differences in scripts.                                                                   |
| HTTP 1.1/2   | Tinyproxy serving                 | Must serve correct headers for live-reload.                                                                                |


## Appendix


## Viewpoint Perspectives

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
- **AV-1**: [DoDAF Overview and Summary Information](https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_av1/)
- **AV-2**: [DoDAF Integrated Dictionary](https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_av2/)
- All models based on Department of Defense Architecture Framework (DoDAF) Version 2.02
