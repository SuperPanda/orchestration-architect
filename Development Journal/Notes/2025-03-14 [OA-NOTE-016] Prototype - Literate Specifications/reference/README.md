# Literate Specifications Notes: Self-Assembling Conceptual Web Prototype


<!--toc:start-->
- [Literate Specifications: A Prototype /](#literate-specifications-a-prototype)
  - [[OA-NOTE-016][../2025-03-14 [OA-NOTE-016] Prototype - Literate Specifications/]snip-expand-or-jump](#oa-note-0162025-03-14-oa-note-016-prototype-literate-specificationssnip-expand-or-jump)
  - [Overview](#overview)
  - [Activities](#activities)
  - [Composable D2 Diagram DSL Specifications](#composable-d2-diagram-dsl-specifications)
  - [Literate Specification](#literate-specification)
    - [Self-Bootstrapping Specifications](#self-bootstrapping-specifications)
  - [Design](#design)
  - [Grammar](#grammar)
  - [Example](#example)
<!--toc:end-->

## Document Scope

The scope of this document is to have a self assembling 
'literate' specifications for specifications in Orchestration Architect. 

The purpose of the document is a proof of concept that a web of literate 
writing that is able to construct the explained concept embues 
a semantic context for the parts.

The structure of the document should take a `Arrow` theoeretic approach.

The reference implementation should create a pristine `Specification/....Meta Specification.md`.
that generates a `


facilitate a specification that allows for literate writing 
to allow constructions and explanations of concepts, 
such that the specification is able to produce a reference 
implementation.

The purpose 


## Overview

This literate specification aims to collect all the elements we will need to define.

- A DSL Grammar is provided to facilitate the production of a arrow perspective category theoretic design process..

- The grammar will be used to act as a parser and generator. 

- The goal is to be able to compose steps without defining the objects that achieve it. 

- The a transformation composition model will mean any object that can attach to the composition will 
  intberact in a natural and coherent ways. 

- The goal is to set up the specifications so there is enough information to rename semantic and move semantic things, and be able to ensure all things meet the following rules.

>   **REQUIREMENT**: The Initial Morphism Constraint

>   **REQUIREMENT**: Grammar Rules need to allow for semantic relations needs to be preserved.

>   **REQUIREMENT**: Map urn:OA entities to other resoureces

>   **REQUIREMENT**: Officially specify how Orchestration Architect system specifications.

>   **REQUIREMENT**: A Literate Specification able to regenerate the system.

>   **REQUIREMENT**: Specifications must enable the structure of the document is sufficient

>   **REQUIREMENT**: Specification for Documents SHOUD ensure strict guidance for preamble and EOF

>   **TASK**: Use Semantic Metadata in a Git Repository via `git note`

>   **IDEA**: Ensure that Architectural Design supports regenerative capabilities.
>             Links are to be bifunctors. That is a change in a task name, will update the referencing, or applied 
>             by a git hook, etc.

>   **TASK**: Implement a Functor Map to Semantic fields
>   
>             1. A file path can be created
>          
>             2. A change to a field internal to a semantic token must update all objects that are named semantically.
>          
>             3. If a path and directory are paired `FILE.md` and `FILE/`, is renamed to `NEW_FILE`, 
>                 should also map naturally `NEW_FILE/`. A child->referenes parenet relatively, so 
>                 regeneration needs to come from within the directory. Thus the functor is needed.
>             4. Implement a Functor To map the changes the shape of semantic fields change 
       the grammar specification then a new minor version is required.

>   **REQUIREMENT**: Ensure good formatting of mark down by requiring line breaks are separated by an empty line.
>
>   **REQUIREMENT**: Define the OA Compatible YAML GRAMMAR of the OA restricted yaml specification for correctness yaml operation.

>   **REQUIREMENT**: Define how a URI, URN and URL can is generated via pluggable arrow-based compostions.
                     Such that the file contains a semantic unique identifier in its name. If a file needs to 
                     break the structure, it should just be superceded.
                    


Use the purpose pf a simplified D2 LANG SPEc, to MAKE IDENTIFIER LABELS, WITH THE IDEA THAT USING a set amount of digits, will allow it easy to update an epoch or verision system.

Describe how when different tasks are done, or when a note is added or removed the functional role of whats happening and group things that way. and describe the idea of a semantic web of notes. With authoriative specs, being embeedded via git notes, and being able to use git as a possible namespace documents and schema location, which can be updates, list all the commands.

And provide a a sample of the oa namespace being used:



the Idea is instead of adding more tasks to pipeline, that I can make a task an activity the follows from another.
Rere

------------MACROS AND STUFF HERE ------------------------------

Define certain structures 
such as patterns of matching by breaking identifying some hieararchiy whether it is defined by indent levels 
to yaml (the you do a dep first search so filter the column of the matches, and for each start point, you can find all the height things, as we define everything as a structure.


The 

```
rg fold {~/archived,~/repos/orchestration-architect*} | cut -f1-2 -d\: | sed -e 's/^\([^:]*\):\([1-9]*\)/\1,\2/''
#| sed -e 's/^([^:]*):([1-9]*).*/\1:\2/g'


```
# Do `rg -n {{SEARCH_TERM}} {{PATH_GLOBS}} | ...etc...` to get file and line numbers of contextual matches
MATCHED_RESOURCES=$(rg -n fold {~/archived,~/repos/orchestration-architect*} | cut -f1-2 -d\: | sed -e 's/^\([^:]*\):\([1-9]*\).*/\1,\2/g')
echo 
```

---

## Literate Specification Bootstrap
### Definitions 

>  **Definition**: Token

   A `Token Fragment` is a refers to a representation of a concept.

>  **Definition**:

    A '

>  **Terminology**: `Fragment Macro Placeholder`

   A `Fragment Macro Token`


```sh,build
cat <<<'EOF' > bootstrap.sh
#!/bin/sh
```

## 

>  **TASK**: Create a Semantic Literate Task Spec

becomes:

>  [**TASK** Create a Semantic Literate Spec](<urn:oa:tasks#OA-TASK-001>)

and the git notes will store a triple that represents (action,predicate, 

> <Task Refspec:

>  Create Self-Assembl Literate Specification
>
>   Bo

>  Bootstrap

    cat <<<'EOF' > bootstrap.sh
    #!/bin/sh
    rg -n «SEARCH_TERM» «PATH_GLOBS» | «extract file and line positions»
    EOF


also python is slow
Define snippets used by IDEs and (Neo)vim that can be used.

Define ways for things to be done

The snippet layout should use with vim lsp and snippets like nvim-cmp and STUFF



-------------EXAMPLE OF SPECS----------------------------------

> [!task]
    ----------------------------------------------------------------
> [!task] Make the last templated like this with a snippet layout.
> and write a ```[!definition]``` macro and script macro. and provide instructions to add.

>  **TASK**:
>   - Add the VIM Notes 
>   - Describe the operations and monoidal operations.

>  **TASK**:
>  Draft 'OA Specifications: Literate Documents.md'
>       - Defines vocab, structures, etc.

>  **TASK**:
>  Create file 'LITERATE DESIGN.md'
>  - Link to 'Abstract Compositional Topology'
>    so that Theory <-> Implementation Mappings.


> the goal is to make everything semantically linked, so even if things go missing, all objects can be inferred at a later
> date based on there arrows. So if a tree falls in the forrest and no one sees it, well if i lose a task, and i dont need 
> to find it (so i would change its status, etc. and it would link all the hooks. the meta data will be stored in git notes.
> and will will need to start implementing the system.

> [!todo] Figure out the depenency like markdown-oxide and etc. providing the snippets and properly configure LSP.
>        need to migrate my existing tool. and really need the ai script and term frequency tools and tagging scripts to be collated. For status and etc. we can add definitions with a define snippet. define snippets and structure specifications.

>   *TASK**: Define a function api schema for certain tasks to fields to be provided. so lets say i provide instructions for a certain section of this document to be edited, the schema will allow changes to be mapped via dynamically embedding markers, and the function call can fetch linked information permitted, and can allow for updates to be applied, or running tests of change results of the self bootstrap process and see if it works. Keep all the tasks.

>   **TASK**: Ensure that Vocabuary and Terms are clearly defined with consistent communication and
              reusability of meaning throughout discourse between Lannguage Mdoels and meatbags.

>   Make a specification for Tasks in the literate document. The literate document will conform to itself,
and will define the tasks name space, such that the the definition of the literate specs, 
generates the initial morphisms of the tasks, so the development cycle and process can be replayed through history in meatspace.

tasks status be no status,todo,completed (#tasks)
>   - add #backlog tag to hide from todo 
>   - instead making more steps, map 
> Gather the Literate Prototypes.
> Copy Literate Prototypes from Sandbox.
> Copy FUTURE.md to GRAMMAR-NOTES.md from OA-NOTE-008 and concepts from the semantic renamer.
> Find References to OA-THEORY#Abstract_Compositional_Topology
> Copy Tool Implementations for Folding and Hierarchy.
> Copy The Self-Specifications.
> Collate tagging and indexing toolings. And TF-IDF (Julia notebook and ag grep).
> Make functions to AI for agent operations.
> Add tooling to notes
> Include bookmark tooling
> Fix disrepency

## Composable D2 Diagram DSL Specifications

> [!todo] VIM Configuration
> Change VIM to not use `enter` to accept auto complextions
> Figure out where all these snippets suddently appeared from.
> Move the bits below into the commands notes, so they can be embedded dynamically based on the 
> system setup or provided via other means.

> **TASK**: CURRENT TASK

> **IDEA**: MAYBE MAKE IT SO I HAVE A SEPARATE BRANCH FOR TASK TRACKING WHICH WILL BE A KANBAN IN THE GIT.

> [!attention] YOU ARE UP TOO
> YOU NEED TO MAKE SURE THE VIM MACROS WORK, AND MAKE SURE THEY ARE PROVIDED AND ONLY SUPPLIED WHEN IT IS VERIFIED THAT IT WILL WORK CORRECTOLY
> I NEED TO ENSURE THAT THE ACTUAL D2 GRAMMAR WORKS FOR PARSING AND GENERATING
> NEED TO MAKE THE SCRIPT BE ABLE TO SEMANTICALLY DEPLOY SPECIFICATIONS
> NEED TO ADD ALL THE SNIPPETS TO A SPECIFICATIONS. 
> NEED TO GO BACK TO SETTING THE THE RESOURCE ENGINE.
> DON'T SPEND MUCH LONGER ON THIS, ONLY TO THE POINT WHERE I CAN MAKE A SIMPLE ONTOLOGY.
> LIKE A TREE WITH NATURAL transformations
> FOR THE DIFFERENT PERSPECTIVES
> GET TERMINAL AI WORKING ASAP

## Literate Specification

### Self-Bootstrapping Specifications

> [!task] **Create LSP to provide Literate Tips**
> Provide bootstrap tips for documents containing examples within (`nvim-orchestration-architect`)[urn:oa:project:nvim-orchestration-architect].
> Task ID: Unassigned
> Status: No Status

> Project: nvim-orchestration-architect




> [!task] **Bifunctorial Semantic Task Manager** 
> Task: Add a mapping that allows for git notes to track changes to tasks.

> [!task] Bootstrap Specifications
> Generate the Reference Specifications
 
> [!tip] Instant Bootstrap with VIM
>
> **1. Select lines:**
>     `Shift-V y` 
>    
> **2. Pipe selection to bash:**
>      pressing `:` and appending `w !bash` 
>      Note: ensure there is a space

> [!tip] Record a VIM macro
> 
> ```
>   q 1 /`sh,b <ENTER> j Shift-V jjj $ q 
> ```
>  
> Now pressing 'Q' will highlight the bootstrap

```sh,bootstrap
cat<<'EOF' >bootstrap.sh && bash bootstrap.sh > example.d2 | d2 example.d2 example.svg -w
#!/bin/sh
cat README.md | tail -n+$((`cat README.md | grep -nP '^\`{3}d2,example' | cut -f1 -d\: | tail -n1` + 1)) | head -n-1
EOF
```
test

cat README.md | tail -n+1 | head -n+`grep -En "^d2,example" README.md | cut -f2 -d\:`

echo `$(bash -c grep -nP "^...d2,example" README | cut -f2 -d\:)`
bash -c "cat README.md | tail -n+1 | head -n+$((cat README.md | grep -nP "^d2,example"| cut -f2 -d\:))"
```



---------------
> I want compositionality from a morphism perspective. So I want to be have it still composable but thinking in terms of defining things through there interactions primarily.
> Instead of what components, what does it do?
> Remove wank wording and focus on some salient points like making it recomposable using semantic linking.
> Ensure composition
> We will make the styles be defined in thereme
> We will need to refocus the order to facilitate following the train of thought
> I have already corrected the syntax. So the provided syntax can be used to fill in the grammar.
> I have sort of reorder the components but make a common and consistent vocabulary try to focus on writing
> to guide the reader in this specifications for a DSL I am going to add to pest to map semantic concepts, between representations. So that I can better model things in one domain, and the process of making it will be similar in process.

> -----------THE NEW PERSPECTIVE I WANT TO MAKE A CORE VALUE IN MODEL WHEN MODELLING DESIGN ARROW BASED PERSPECTIVE -----------
THE IDEA IS THAT WE HAVE A FUNCTION WE WANT TO ACHIEVE, AND THE COMPONENTS ARE DEFINED BY THE MORPHISM. 
SO STRUCTURE THE SUBSET OF D2LANG TO MAKE SMALL COMPOSABLE MODELS.
------------

## Summary
The objective is for a grammar as a strict subset of d2lang domain specific language to facilitate modelling on the relationship between components to achieve some outcome. Focus on the 'goal' not the 'components' for Orchestration Architect. The intent it that the yoneda lemmas demonstrates that all objects can be defined via the relationships. 

The design of the DSL to be able to generate models in a composable manner, that facilitate modeling functional perspectives rather than from a structural perspective. The order and particular placement for element definitions are used to align the readers focus two providing objects based in modelling in 'what is being done' rather than 'how do I put these objects together'. In other words, think in terms of what does it do, rather than what is it made of.


----------------------- EXPLORE HOW I CAN ADDED MAKE THESE GENERATE RESOURCES -----------------------

> [!info] Non-Normative Resource
> Title: (Co)algebraic analysis of social systems: from graphs to hypergraphs
> Author: Nina Otter
> URL: https://www.youtube.com/watch?v=nnBg4haKyF0
> Relevance: Otter video exemplifies what quality higher ordder constructions can be made.

> ---------------CHANGE CONTEXT TO THE NEW CONTEXT FROM HERE-------------------------

This document presents a modular subset of the d2lang DSL—a domain-specific language originally designed for constructing clear, concise diagrams. Our approach breaks down the language into composable chunks, ensuring that content (nodes and edges) and presentation (styles) are defined independently. This separation not only facilitates ease of extension but also guarantees that new features, such as composable grids and subgraphs, blend seamlessly without convoluting the core semantics.
Relationship with d2lang

The design here is directly inspired by and compatible with the d2lang DSL. However, our subset focuses on:

    Disjoint Concerns: Content definitions are separated from style declarations. This allows dynamic swapping or extension of styles with no impact on the underlying data model.
    Modularity: As a subset, it adheres to the foundational constructs of d2lang but restricts elements to ensure clean, maintainable syntax. This enables developers to start with a minimal set of features and progressively introduce advanced elements from the broader d2lang ecosystem.

Composable Grids and Subgraphs

A key feature of this DSL is its support for composable grids and subgraphs. This means that you can define a subdiagram (or grid) as an independent component within your overall diagram. Such subgraphs have two primary properties:

    Preorder Preservation:
    The DSL maintains a strict preorder relation where the structure of the containment hierarchy mirrors the nested (or indented) order—much like indented markdown files. Every descent in the hierarchical structure satisfies the condition that the contained items are less than or equal to their parent in the defined order.

    Subgraph Flexibility:
    A subgraph can exist with or without internal connections. Regardless of whether nodes within a subgraph are directly connected by edges, the hierarchical (or containment) ordering remains consistent. Sibling nodes do not disturb the overall preorder, so reordering siblings (if needed) does not impact the inherent hierarchy.

Identity Morphisms and Order Preservation

The language inherently supports identity morphisms—operations that map an entity to itself—which guarantees the preservation of ordering through the following reasoning:

    Cut Points in Hierarchy:
    Every node in our diagram exists at a unique hierarchical level. By selecting a "cut point" at a given level, you partition the graph at that precise juncture. This slicing process ensures that the ordering on either side of the cut remains consistent and respects the internal structure.

    Proof via Slicing:
    Any operation that transforms or queries the diagram can be reduced to a slicing operation at a particular hierarchical level. Since siblings (or nodes on the same level) are not order-sensitive, slicing preserves the relative positions. This demonstrates that if an identity morphism exists (where a node is mapped to itself), the overall preorder and inherent ordering properties of the diagram remain intact.

    Composable Identity Operations:
    Each node or block can be considered an identity morphism in its own right. These blocks preserve order when composed with other operations. In other words, for any two blocks at the same hierarchical level, the identity mapping can be used as a baseline to compose more complex transformations without losing order.

Overview

In summary, this DSL is designed to be:

    Composable:
    Nodes (content), edges (relationships), and styles (presentation) are defined in clearly separated blocks. This paves the way for independent development, testing, and integration.

    Extensible:
    The core grammar supports additions such as subgraphs and grid composition. The ordered (indented) structure assures that any containment-relational extension fits naturally with the overall design.

    Mathematically Sound:
    The demonstrated properties, including the identity morphism and slice-based ordering, provide a robust mathematical grounding for ensuring that all order and containment invariants are maintained.
``

----------------- ATTEMPT TO DRAW A ENOUGH SO THE EARLIER COMMANDS GENERATE THE SPECIFICATION ASSETS ------------------
MAKE TWO DIAGRAMS, THE GENERATION VIEW AND THE RESOURCE VIEW, WHERE I WILL USE THE GENERATION VIEW TO FIGURE out
HOW TO GET SOMEWHERE, SO I WILL NEED TO THINK IN TERMS OF WHAT OPERATIONS (we will repsent as nodes, and arrows are 
like an objects that are product from diifferent process.


ENSURE YOU MODEL THINGS LIKE: STAGE uses two wires from FROM START which would be the thing stage, and we will want to make it dispatch to the `oa cli` tool which i will be making the resource resolver, which does do list, and i will need to bring it into hte project you to define, how we will have a decoupled portable resource resolution depending on context. 


-----------------DEFINE A VOCAB ----------------

----------TREESITTER PROCESS----


EXPLORE HOW WOULD YOU ASSIGNED SEPARATE AGENTS SOLELY RESPONSE FROM READING A SPEC TO DELEGATE THE 
TASKS AND SCOPED AND LIMITED CONTEXT BOUNDARY, WITH THE USEFUL INFORMATION BEING ABLE TO BE DERIVED FROM THE TEXT, SO IF I RUN TAI, WHICH ADD TO THE LIST NEEDS PORTING TO RUST, BUT I WANT GOING TO DO A MESSAGE/SIGNALS BASED APPROACH, I WANT YOU TO ADD TASKS TO SERVE THE SEMANTIC SCHEMAS VIA WARP, THE DOCUMENTATION AND SPECIFICCATION AND NOTES VIA WARP TOO, FOR LOCAL USE ANYWAY. AND I WANT YOU TO ADD THE D2LANG VIM PACKAGE
WOULD YOU 


## Design
## Grammar

Also make the two perspectives, as a product is usually a graph bnased resulting from it,
a core product is getting the things that make the graph or system, and putting htem together in an enum.


, and the other is the resource or compsositional structure perspectivie
I use the triples, to triple my point on the differences. One is for me the other is for those who would

> [!todo] Need to define a simple abstract grammar for the semantic structure. 
> So something like  `diagram ::= { diagram_kind }` ` digram_kind ::= generative_diagram,resource_diagram and maybe one that allows me to focus on transformations by have like a bipartite vie.` and something the categories like the arrow/morphism/interactions so like generative_perspective, the connections generate something, and the other is like showing what resources was generated provided by the semantic resolution servicce
```DSL
(*
  Composable D2 Diagram DSL Specification
  ----------------------------------------

  The DSL is broken into independent chunks:
    • Object Declarations (Nodes)
    • Directed Relationship Declarations (Edges)
    • Styling Declarations (Styles)

  Each chunk can be parsed and validated independently, enabling modular
  composition of diagram semantics (domain) and presentation (styles).

  ************************************************************
  Grammar (in EBNF-like notation):

    diagram         ::= { declaration }+

    declaration     ::= nodeDeclaration
                      |  edgeDeclaration
                      |  styleDeclaration

    nodeDeclaration ::= identifier ':' quotedString ';'
                        (* Defines a diagram node: an identifier and its label *)

    edgeDeclaration ::= identifier '->' identifier edgeAttributes ';'
    edgeAttributes  ::= '{' edgeAttribute { ',' edgeAttribute } '}'
    edgeAttribute   ::= 'label' ':' quotedString
                        (* Add other edge attributes as needed *)

    styleDeclaration ::= 'style' identifier styleBlock
    styleBlock       ::= '{' { styleProperty ';' }+ '}'
    styleProperty    ::= identifier ':' quotedString
                        (* Typical keys include icon, fill, stroke, stroke-width, etc. *)

    identifier       ::= letter { letter | digit | '_' | '-' } 
                        (* where letter and digit are according to standard ASCII rules *)

    quotedString     ::= '"' { any-character-except-quote } '"'

  ************************************************************
  Semantics:
    - A **nodeDeclaration** defines a diagram element with a unique identifier.
    - An **edgeDeclaration** connects two nodes and carries its own properties (here, at least a "label").
    - A **styleDeclaration** assigns a set of styling properties to an object. 
      Styles are completely independent from the node or edge definitions—they can be modularly extended.
*)V
```

> [!attention] The following needs to be reordered
>   Start with reordering to start by allowing the framing of the problem
>   by considering the (co)limits where am I, and what do i want to achieve.
> So we could have a start point and endpoint from <START_POINT> and <END_POINT>...
> In fact a simple example to illustrate a compositional that is used to generate views from a object-free arrow model (where objects are added later). So put the object-free arrow model components in the other they should be thought about. Make a few examples.
> So like update the example for making a local bare git repo store notes and other data as a means of storing meta data and triggering git hooks. remember each model needs to be as small as possible, so each model should be like, it adds this and this does that each with there own graph, using markdown header levels to make things of the same nature be siblings so that a preorder can be constructed. so include that in the grammar.
> Description
 
## Example

```d2,example
# Diagram

# Node Classification (Presentational) ====

local_repo {
   icon: "assets/toy_box.svg";
   style.fill: "#F4F4F4";
   style.stroke: "#333";
   style.stroke-width: 1;
}

tracking {
   icon: "assets/note.svg";
   style.fill: "#E8F5E9";
   style.stroke: "#2E7D32";
   style.stroke-width: 1;
}

remote_repo {
   icon: "assets/github.svg";
   style.fill: "#E3F2FD";
   style.stroke: "#1565C0";
   style.stroke-width: 1;
}

ephemeral {
   icon: "assets/bear.svg";
   style.fill: "#FFF3E0";
   style.stroke: "#EF6C00";
   style.stroke-width: 1;
}


# Edge Classification (Presentational) 

## What edges are there

# Node Declarations (Entity Invocation)

local_repo: "Repository (Toy Box)";
tracking: "Tracking Branch (origin/main Note)";
remote_repo: "Remote Repository (GitHub Mirror)";
ephemeral: "Authoritative Server (Remote)";


# Edge declarations (Directed relationships with attributes)

local_repo -> tracking { label: "updates note" };
tracking -> remote_repo { label: "points to" };
tracking -> ephemeral { label: "optional config" };

# ==== Styles: Actions ====

```
