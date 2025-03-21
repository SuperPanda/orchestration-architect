### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ f664bc7e-7797-11ef-33eb-15d3137f5d1d
md"""
# Orchestration Architect
## Systems
- Configuration/Code Level - Feature Speace Layer
- Repository Level - Evolution Layer
- Systems Layer - Component Layer 
- Infrastructure - Solution Layer
"""

# ╔═╡ b2a12c3c-747e-43eb-8b11-f3826e418c3a
md"""
### System Design
#### Regeneration (Stem Cell like)
- Show how it can recover from broken files, filesystems, partitions, hardware
#### Evolution (Survives Self-Assembly)
- Show how the system uses self-assembly and adjunctions to allow for features to grow
#### Composability and Multiplicative Feature Space Design
- Show how each part fits together
#### Introspection and Auto-documentation
- Figure out how to make the system document
#### Expandable (Self-Modifying)
- Ensures consistency and that changes work everywhere.
- Adding parameters to specifications, will generate the needed implementations of interface (or scaffold most of it)
#### User centric
- Configurations are designed to be used by humans to explore and try new configurations, and build there own solutions
"""

# ╔═╡ 53be6cfd-6878-40f6-831a-3ce37f7c2c10
md"""
## Project Repository Structure
### Origin Repository
Each user maintains there own origin repository within the generated system or provisioned managed repository server.
Origin: `/srv/git/orchestration-architect.git`
Mirror (for me anyway): `https://github.com/SuperPanda/orchestration-architect.git`


### Repository Design
Seed is (re)based on Initial.
Pristine is (re)based on Initial.
Running Bootstrap Playbook on a Seed Workspace transforms it to a Pristine Environment.
```
                            Git Commit       	   
Initial ---> Seed ---------------------------------> Seed'
                              
             Patch(Diff(Pristine,Bootstrap(Seed))
Pristine ----------------------------------------> Pristine'

Since Pristine is based of Initial.
Initial ---> Pristine is isomorphic to 
Initial ------> Patch(Diff(Initial,Bootstrap(Seed)))
```

The dev(el) branch is rebased on pristine.
If a change is made that causes dev to not rebase on pristine,
then that needs to be added to seed. If the s
If change is not invertible without loss of information then a major major release number is incremented.
If a change is not compatible, but can be migrated back and forth then a minor release number is incremented.

A `seed ----> seed'` is only valid if bootstrap morphism can be applied to booth seed and seed'

The Docs, Tools, Assets should ensure file trees can composably apply overlays.

### Branches
- `<version>-initial`
- `<version>-seed`
- `<version>-pristine`
- `<version>-dev` (TODO: change to devel)
- `<version>-tools`
- `<version>-assets`
- `<version>-documents (TODO: change to docs)`
"""

# ╔═╡ a5645358-010b-48fa-9c65-632742666315
md"""
## Specifications
### Types of specifications
Specifications can be found (prior to version 0.9.0) in `vars/specifications/<version>/` and include:
- roles.yml
- metadata.yml
- playbooks.yml
- templates.yml

These are used to supply the roles, playbooks and templates specifications to the meta_role, meta_playbook and meta_playbook roles respectively, usually performed by the meta_orchestrator. The meta_orchestrator is usually triggered to rebuild templates, update fragments, scaffold new roles and etc via the Meta playbooks found in `playbooks/Meta/`.

Future versions (version 0.9.0), the roles.yml, playbooks.yml, templates.yml and tests.yml (future), will be provided per collection and will hold the specifications required to generate that collection (via the Meta collection). 
"""

# ╔═╡ c22c855d-b0cd-4593-865f-a02401285959


# ╔═╡ e973d091-7977-4d3c-8b7a-32ed56e16be3
md"""
## Collections

### Notes
**Installation Target**
Installs to `/usr/share/orchestration_architect/<version>/collections/<collection_name>`.

Overridden by: `<orchestration_architect_version_worktree>/collections/<collection_name>` if present.
"""

# ╔═╡ bb61a6c4-1e4c-47e7-84cd-5d144b9dd7fd
md"""
### The *Meta* Collection
#### Overview of the Meta Collection
##### Bootstrap the Meta Collection
The seed of the Meta Collection, and the associated bootstrap process verifies that the Meta collection is generally correct. With the gaps to be tested later in a future extension called `orchestration_architect.meta.test`
#### Roles

##### orchestration\_architect.meta.meta\_role
Role Path: `<meta collection path>/roles/meta_role`
Generates and Updates Roles defined in a collections `vars/roles.yml` roles specification file. Generates the main.yml task which routes to the various states, and packages all the configuration variables, and overrides as an <role_name>_params objects....
The specifications are used to generate a main.yml task file which routes dependent on the <role_name>_state or <role_name>: {state: <state> } object, which at a minimal has info.yml (identity), present.yml and absent.yml. The parameters are packed into the <role_name>_params object, and the defaults can be provided in the specifications, which will be put in the <role_name>_params.<param> value, if not provided, and if no default it will be set to omit.

##### orchestration\_architect.meta.meta\_playbook
Generates Playbooks.
##### orchestration\_architect.meta.meta\_template
Defines Skeletons, Fragments, ...
Explain how we use 10_Template_Header to Assign template_variables provided by the calling role, which takes the <role_name>_params.
##### orchestration\_architect.meta.meta\_orchestrator
Dispatches configurable actions to the other meta components, using the specification files, or provided specifically via extra variables or playbooks.
The Scope, filter and other stuff
"""

# ╔═╡ b38098c6-dc1c-47df-845a-07f2310bc095


# ╔═╡ ed970dc2-4d8b-426d-9916-7db71bb34c06


# ╔═╡ c17567de-4e28-4e20-b136-b3692f9984af
md"""
### The *Storage* Collection

#### Roles
- storage
- loop device
- partition
- luks
- filesystem
- btrfs_subvolumes
- mount

"""

# ╔═╡ 28f05125-4585-4c52-9f38-634dfc369d88
md"""
### The *Network* Collection
- ovs_bridge
- Firewall

"""

# ╔═╡ 695cb90c-2c25-4f89-80c8-ba6b16bbf39f
md"""
### The *Container* Collection
- qemu_runner
- nspawn_runner
"""

# ╔═╡ ec3127a1-720d-46ed-af3e-66773f9c193b


# ╔═╡ 56f88bb5-c67c-4975-a078-685978d17852
md"""
### The *System* Collection
Builds bespoke systems based on configurations.
- Pacstrap
- ArchISO
"""


# ╔═╡ 0a0741c9-ca12-43ab-8b20-889ffecc4110
md"""
### The *OA000 Recovery, Repair, Restore* System
"""

# ╔═╡ 5d59aec0-0c9d-4232-b959-f50c3ad160e8
md"""
### The *OA001 Master Control Encrypted Persistent LiveUSB* System 
Generates and holds the configuration to provision an airgapped system. Generates PXE Bootable Ram-based Hypervisors securely tied to the USB System.
"""

# ╔═╡ 8a638d7e-4f45-4862-a956-26d1cf75ffc8
md"""
### The OA002 PXE Booted Live Hypervisor
"""

# ╔═╡ 7e08ade0-aa30-4621-b7b9-22052fc7b0e9
md"""
## Tools
- terminal-ai and tools
- fzf tools
- neovim tools
- others...
"""

# ╔═╡ Cell order:
# ╠═f664bc7e-7797-11ef-33eb-15d3137f5d1d
# ╠═b2a12c3c-747e-43eb-8b11-f3826e418c3a
# ╠═53be6cfd-6878-40f6-831a-3ce37f7c2c10
# ╠═a5645358-010b-48fa-9c65-632742666315
# ╠═c22c855d-b0cd-4593-865f-a02401285959
# ╠═e973d091-7977-4d3c-8b7a-32ed56e16be3
# ╠═bb61a6c4-1e4c-47e7-84cd-5d144b9dd7fd
# ╠═b38098c6-dc1c-47df-845a-07f2310bc095
# ╠═ed970dc2-4d8b-426d-9916-7db71bb34c06
# ╠═c17567de-4e28-4e20-b136-b3692f9984af
# ╠═28f05125-4585-4c52-9f38-634dfc369d88
# ╠═695cb90c-2c25-4f89-80c8-ba6b16bbf39f
# ╠═ec3127a1-720d-46ed-af3e-66773f9c193b
# ╠═56f88bb5-c67c-4975-a078-685978d17852
# ╠═0a0741c9-ca12-43ab-8b20-889ffecc4110
# ╠═5d59aec0-0c9d-4232-b959-f50c3ad160e8
# ╠═8a638d7e-4f45-4862-a956-26d1cf75ffc8
# ╠═7e08ade0-aa30-4621-b7b9-22052fc7b0e9
