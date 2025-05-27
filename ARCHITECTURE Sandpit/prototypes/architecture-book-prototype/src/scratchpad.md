# Book Drafting Scratchpad

<!--toc:start-->
- [Book Drafting Scratchpad](#book-drafting-scratchpad)
  - [Ways of Thinking Example](#ways-of-thinking-example)
    - [Abstract Life](#abstract-life)
    - [Thinking Caps (K-lines)](#thinking-caps-k-lines)
  - [Configuring architecture development tooling](#configuring-architecture-development-tooling)
    - [Add a `d2` preprocessor to `mdbook`](#add-a-d2-preprocessor-to-mdbook)
    - [Add `math` rendering to `mdbook`](#add-math-rendering-to-mdbook)
    - [Configuring Desktop](#configuring-desktop)
    - [**LATER TASK** Configuring TMUX](#later-task-configuring-tmux)
  - [**NEXT TASK** Plan](#next-task-plan)
    - [Identify Existing Architecture Domains](#identify-existing-architecture-domains)
    - [ARCHITECTURE](#architecture)
      - [REPOSTIORY](#repostiory)
      - [PROJECT MANAGEMENT](#project-management)
      - [LITERATE WRITING](#literate-writing)
      - [CONFIGURATION SYSTEM](#configuration-system)
      - [TOOLS](#tools)
      - [OA Components Collections](#oa-components-collections)
        - [OA.META Subsystem](#oameta-subsystem)
        - [OA.STORAGE Subsystem](#oastorage-subsystem)
        - [... etc.](#etc)
      - [OA Infrastructure Modules](#oa-infrastructure-modules)
          - [OA001 - MASTER BLAH BLAH...](#oa001-master-blah-blah)
<!--toc:end-->

> **Neovim Tip**: Use `<leader>+s a 1` to update TOC.


> **To Do**: Capture the `nvim` plugin (something `md-oxide`),
> the prefix to call `lspsaga` commands, the actions.

## Ways of Thinking Example

> **Note**: Try to capture the ways of thinking, and the 
    processes as resources, and find useful 
    patterns that promote the architectural design 
    decisions.

### Abstract Life

Structurally, it is regenerative effects caused by
the right adjunctions that results from the universal construction of a seed (initial object) that self-assembles through a process of self-verification (natural selection).

Functionally, it is to actualise realised potentialities.

### Thinking Caps (K-lines)

* *Minsky Mindset*: Use ideas from 'Emotion Machine'
  to structure approach. Examples include 
  identifying different agents (like locate, critic,
  selectors,etc.), like using the layers of thinking
  to map to an architecture level 
  (a homeomorphism/preorder).


* *SWEBOK Mindset*: Capture the requirements, designs, 
  construction and maintenance.

* *Category Theory Mindset*: Use to think about how to achieve compositionality across systems

* *Applied Category Theory Mindset*: Apply tools 
  and techniques to distill 
  models using identified patterns that have 
  been identified as useful tools, and 
  provides a means of allowing composable 
  systems. Like using `d2` to 
  `resource theory`-inspired models. 

> **Realised Potentiality** Add links to *Wikipedia* pages that 
> describe the concepts so a semantic web can be 
> generated.

* *Small World Mindset* Consider structure relations 
  that minimises the size of the connections.

* *Chaos and Sync* Consider the how to syncronise 
  systems when working in a chaotic system, 
  to manage the complexity. Examples include 
  the `META Components` *Subsystem Module* to achieve
  a natural cascade of operations based on 
  composition of configurations.

* *Literate Writing Mindset*: Apply literate writing and programming techniques, 
  as it allows for exploring different solutions, 
  and enforces compositionality, and 
  can something *homeomorphic* to a 
  *topological filter* as a *selector*
  to *naturally transform*. It also 
  creates a tonne of resources and 
  examples.


## Configuring architecture development tooling

> **Way of Thinking** JUST GO TO `mdbook` documentation and look 
    under something akin to 'preprocessors'

### Add a `d2` preprocessor to `mdbook`

> **Aim**: Add a `D2` preprocessor to mdbook

> **Realised Potentiality**: The `d2` language has been 
> identified as an effective tool for modelling  
> category theoretic system designs due to constraints.

> **Resource** 

### Add `math` rendering to `mdbook`

> ...

### Configuring Desktop 

**Add workspace name to `waybar` in `hyprland`**

Run command `hyperctl dispatch renameworkspace «workspace id» «workspace name»`

**Update workspace name for workspace**

    Just `rg` for `fish` files containing, 
    oa-sandbox. By running `oa-sandbox` then
    `rg 'oa-sandbox' --iglob 'fish'`

> **Identified Potentiality** A simple 'is this right pattern for *terminal-ai*'
       

```fish «rename workspace function»

set -l description "Get current workspace ID"
function get-current-workspace-id -d "$description"
    # The `hyprctl activeworkspace` command 
    # returns "workspace ID <ID> (<NAME>)
    hyprctl activeworkspace | grep -oP "workspace ID \d{1,2}" | cut -f3 -d\ ;
end 


set -l description "Set a name for a Hyprland workspace."
function set-workspace-name -d "$description" -a name id 
    # if no id, get current id
    if test -z $id; set -f id (get-current-workspace-id); end 
    if test -z $name
        hyprctl dispatch renameworkspace $id "$id";
    else
        hyprctl dispatch renameworkspace $id "$id: $name"
    end
end

# **Synopsis**
# 
# This function allows you to set or reset the name of a workspace using 
# the various patterns:
# 
# 1. Update the current workspace's name: `set-workspace-name "SOME LABEL"`
#   - Changes the name to `<current workspace id>: SOME LABEL`
# 
# 2. Resets the current workspace's name: 
# (will set to `<workspace id>`)
#    3. update another workspace with `set-workspace-name "NEW LABEL" 0` (will set `0: NEW LABEL`)
#    4. reset another workspace with `set-workspace-name "" 0` (will set to to `0`)

# Example usage:
# get-current-workspace-id          # Returns the current workspace ID (e.g., "9")
set-workspace-name "ARCHITECTURE"     # Sets the current workspace (9) to "9: ARCHITECTURE"
set-workspace-name "PROJECT" 10     # Sets workspace 10 to "10: PROJECT"
# set-workspace-name "" 10          # Resets workspace 10 to "10"
# set-workspace-name                # Resets current workspace to its ID (e.g., "9")
```
> **Task**
> Fix up  CONFIG Kanban, and include the rename workspace stuff.

> **Task**
> Put some way using IDEAS from TERMINAL AI Sandbox to perform simple tasks, 
> ...
    
    

### FUTURE INTEGRATIONS 

* TMUX
* NEOVIM

Use separate named sessions for things.

**Add to existing `orchestration-architect.fish` shell configuration**

> **Identified Potentiality**: Have Neovim be able to expand paths from environment variables added to shell 

## **NEXT TASK** Plan

### Identify Existing Architecture Domains 

* Repository Models: **[See D2 DIAGRAMS](../../architectiure-diagrams/architecture.d2)**

> **Realised Potentiality**: Use of command preprocessor will allow me to list resources. 
  
### ARCHITECTURAL THEMES

### ARCHITECTURAL DESIGN PATTERNS

DESIGN PATTERNS

- ABSTRACT COMPOSITION TOPOLOGY

- NATURALITY THROUGH PREORDER COMPOSITION 

- DISTILLATION WITH SYMMETRIC MONOIDAL CATEGORIES

### ARCHITECTURE COMPONENTS 
**See the OA SUBSYSTEM COMPONENTS Architecture Diagram**

#### REPOSTIORY

#### PROJECT MANAGEMENT

a PROJECT -> a PROJECT KANBAN: has a 

a Project -> a Sandpit: has a 

a Sandbox -> a Sandpit: contains 

a Sandpit -> a Sandbox x a Project 


#### LITERATE WRITING 


#### CONFIGURATION SYSTEM 


#### TOOLS 

- TERMINAL-AI
- NVIM-ORCHESTRATION-ARCHITECT 
- OA-MONITOR

#### OA Components Collections

##### OA.META Subsystem 
##### OA.STORAGE Subsystem
##### ... etc.

#### OA Infrastructure Modules 
###### OA001 - MASTER BLAH BLAH...






