# Strategy

## The `OA.META` collection?

The `OA.META` collection is used to build everything else.

## Building the New Seed

>   **Objective**: Bootstrap `OA.Meta` collection

The new seed will require:

>    1. Moving the top level to have `collections/<namespace>/<collection>`

This will involve moving all the roles, playbooks, templates and specifications etc. under a new collection.

Let's start by making a collection and see if it works.

>   [Ansible Dev Guide - Creating Collections](https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_creating.html#creating-new-collections)

> [Collection Structure](https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_structure.html#collection-structure)

The current seed workspace [Seed Workspace](~/repos/orchestration-architect/seed/)

So I can copy the seed directory and copy the 0.8.1 specifications to 0.9.0.

I can get the Collections with `cat roles.yml | grep -oP '^\ {2}[A-Z][\w]+'

I will put `Base` into `base.roles.yml`. I guess I will put the other collections under `«collection_name».roles.yml`.

I will do the same for `playbooks.yml`.

The templates only have `Base`, `Roles` and `Playbooks` which are used by the `meta` group.

So I will put them in `meta.templates.yml`.

So to prepare the seed I will need to update `meta_orchestrator` to use the `base.«component type».yml` and process the collections. And update the playbooks `playbooks/Meta/Bootstrap_Workspace.yml`. 

So the plan is, create a new directory to be the next iteration of the seed branch. I will keep the structure as is for now, and releases can be packaged by packaging them later into proper ansible collections. This will save the headache of trying to solve many problems at once. For now this will keep the component specs locally proximal instead of having to setup the workspace to symlink or find all the collections. However, I will write a playbook to generate the seeds.

Let's start by creating a BTRFS loop device to hold the seed environment in ephemeral storage. I will use nspawn to just create a filesystem namespace from the existing system. And mount the loop device to the nspawn container.













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


### Tasks 

Collate Tasks. Then add tasks.
Gather tasks, search julia notepads.

```sources
curl https://github.com/SuperPanda/orchestration-architect/issues/3

```


### Development Spaces 

Need to build in ephemeral container-like environment.

Need network re-introduced.

Need to support the following tooling:

- Neovim/VIM - Editor

- Rust: UI - TUI / Web / CLI

- Julia: Science! Data Science!

- Go: PXE Boot 

### Purpose

Needs to be able to generate systems for reasons of infrastructure.

Needs to be able to use components individually for reasons of organ-isation.

META Collection needs to build the rest of resourcefulness.

Need TASKS for remember context.






## Understandable / Visibility 

Needs to demonstrate the bootstrap tasks.

Needs documentation. 

