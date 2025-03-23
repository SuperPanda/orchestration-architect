# Strategy

- [ ] 1. Import Tasks
    - [ ] 1.2. Identify Resources and populate children of 1.3
    - [ ] 1.3 Gather Resources 
    - [ ] 1.4 Add Gathered Tasks to `documentation/Tasks/`
    - [ ] 1.5 Move the tasks below to `documentation/Tasks/`

## Separate collection component specifications 

### Create ephemeral build target environment.

Create roles to setup build containers.

### Separate `OA.META` from `Base` specifications in specifications develop branch `vars/specifications/0.9.0`.

Convert `{roles,templates,playbooks}.spec.yml` to `{base,meta}.{roles,templates,playbooks}.spec.yml` and ensure bootstrap works self-verification works.

Allow for other specifications to be per collection. `vars/specs/<version>/{meta,storage,base}.roles.yml`.


The `OA.META` collection is used to build everything else.

## Building the New Seed

>   **Objective**: Bootstrap `OA.Meta` collection

The new seed will require:

>    1. Moving the top level to have `collections/<namespace>/<collection>`

This will involve moving all the roles, playbooks, templates and specifications etc. under a new collection.

---

Let's start by making a collection and see if it works.

>   [Ansible Dev Guide - Creating Collections](https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_creating.html#creating-new-collections)

>   [Collection Structure](https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_structure.html#collection-structure)

---

The current seed workspace [Seed Workspace](../../../../seed/)

So I can copy the seed directory and copy the 0.8.1 specifications to 0.9.0.

I can get the Collections with `cat roles.yml | grep -oP '^\ {2}[A-Z][\w]+'

I will put `Base` into `base.roles.yml`. I guess I will put the other collections under `«collection_name».roles.yml`.

I will do the same for `playbooks.yml`.

The templates only have `Base`, `Roles` and `Playbooks` which are used by the `meta` group.

So I will put them in `meta.templates.yml`.

So to prepare the seed I will need to update `meta_orchestrator` to use the `base.«component type».yml` and process the collections. And update the playbooks `playbooks/Meta/Bootstrap_Workspace.yml`. 

So the plan is, create a new directory to be the next iteration of the seed branch. I will keep the structure as is for now, and releases can be packaged by packaging them later into proper ansible collections. This will save the headache of trying to solve many problems at once. For now this will keep the component specs locally proximal instead of having to setup the workspace to symlink or find all the collections. However, I will write a playbook to generate the seeds.

Let's start by creating a BTRFS loop device to hold the seed environment in ephemeral storage. I will use nspawn to just create a filesystem namespace from the existing system. And mount the loop device to the nspawn container.

This is the bootstrap overview `grep -P "- name:" ~/repos/orchestration-architect/seed/playbooks/Meta/Bootstrap_Workspace.yml`

**Current Workspace**

## Appendix A: Seed Branch
The output of `tree ~/repos/orchestration-architect/seed -L3`


```
/home/panda/repos/orchestration-architect/seed
├── ansible.cfg
├── playbooks
│   └── Meta
│       ├── Bootstrap_Workspace.yml
│       ├── Execute_Orchestrator.yml
│       ├── Make_Playbook.yml
│       ├── Setup_Environment.yml
│       └── Trigger_Bootstrap.yml
├── plugins
│   └── scripts
│       ├── embed_template_fragment.sh
│       ├── format_yaml.py
│       └── update_rendered_section.sh
├── roles
│   ├── meta_orchestrator
│   │   └── tasks
│   ├── meta_playbook
│   │   ├── tasks
│   │   └── templates
│   ├── meta_role
│   │   ├── tasks
│   │   └── templates
│   └── meta_template
│       ├── tasks
│       └── templates
└── vars
    ├── repositories.yml
    └── specifications
        └── 0.8.0

20 directories, 10 files
```

**Monitoring and Recording**:

Use oa-monitor to monitor bootstrap.

Use asciinema to record the changes.


**Tips**:

Check which bootstrap operations imports from the external environment.


### Tasks 

Collate Tasks
Gather tasks, search julia notepads.

```sources
- https://github.com/SuperPanda/orchestration-architect/issues/
- Repos: orchestration-architect, orchestration-architect-old
        - repos/orchestration-architect
            - documentation
            - sandbox
        - repos/orchestration-architect-old/Feb-2025-OA-Repo
            - ...
        - repos/orchestration-architect-old/Dec-2023-Ansible-Repo        
            - ...
- Branches: sandbox, documentation
- Wiki: repos/oa-wiki-old
- Documents/Orchestration Architect/
- Transcripts from Artifacts on OA001

```
Also check out the tag formats I have used and add them to the tags.


check github: `gists api`, `github project` and `github issues`


Other resources
```
orchestration-architect-prototype
sandbox-test

```



### Resourcefulness

The tools to help work on generating resources.  (See Minksy, The Emotion Machine, Chapter 6. Common Sense - Section on Goals)

Development Spaces 

Need to build in ephemeral container-like environment.

Need network re-introduced.

Semantic connection between components.

Need to support the following tooling:

- Neovim/VIM - Editor

- Rust: UI - TUI / Web / CLI

- Julia: Science! Data Science!

- Go: PXE Boot 

Needs to be able to use components individually for reasons of organ-isation.

### Purposeful

The problem that the `resources` utilised to achieve aims are ineffective.(See Minksy, The Emotion Machine, Chapter 6. Common Sense - Section on Goals)
Needs to be able to generate systems for reasons of infrastructure.

META Collection needs to build the rest of the collections (thus being a resource).

Need TASKS for remember context.

>   **Aim**: Natural Task Management from Needs

## Comprehensibility 

The `context overload` problem (this needs to be minimised to achieve this aim).

Needs to demonstrate the bootstrap tasks.

>   **Aim**: Have Tooling to Find Information


>   **Aim**: Visualisation of Architecture


>   **Task**: Create a book summary based on existing diagrams. 


Needs documentation. 

### Visibility 

The `out of sight, out of mind` problem with recall when needed (this gap is required to achieve the sub-aim).


Run `fd ".d2" ../..` to find diagrams

The file `../2025-03-19 [OA-NOTE-018] Prototype - Generic Diagram Modelling of Encapsulated Context/Wire-Diagram.d2` should be used as a useful starting diagram structure for complex behaviours.

The file `../2025-03-13 [OA-NOTE-006] Prototype - Orchestration Architect Visualisation/architecture.d2` can begin with:

**Repository**

1. Repository Topology 

2. Branches 

3. Worktrees and Workspaces 

**Collections** 

1. Collections Summary 

2. Collection Components 

**Auxillary Components and Tools**


