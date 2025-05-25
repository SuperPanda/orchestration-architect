# Retrospective Journal 2025-05-21 

## Retrospective Activity

**Positive**

 > *Add positive thoughts and experiences below*

- Easier to regain focus with the configuration of paths into env vars

- LOVE The configuration system, hate to lose track of it.

- LOVE The print out of the last thing I did helped me recall everything
  I was just working on, before big breaks.

- LOVE the process of refining a model from diagrammatic reasoning 
  to achieve a design for tasks and other development, that lead 
  to designing a universal solution to a set of issues.

- LOVE the preliminary work with ENTR to make terminal-ai update display,
  when using tee, using a temp message file, that makes it easy to copy content 
  from a known location.

- new favourite trick: `'<,'>w !cat | wl-copy; set message "$(wl-paste)"; terminal-ai -- "$message" | tee "/tmp/last_message"`
  other cool trick is somewhere where it displays it. and "!!" to replay 
  and viewing it with `echo "/tmp/last_message" | entr -pc bat /tmp/last_message`

- other cool tricks is live application of changes from dev environment 
  `set CURRENT_SANDBOX "$OA_SANDBOX_PATH/LIT_SPEC Sandpit"; echo "$SANDBOX/shell-configurations/orchestration-architect.fish" | entr fish "$CURRENT_SANDBOX/oa-load-environment.fish"`

- this tricks need to be recorded clearly maybe in DESIGNS, or maybe SPECS.


- success experiment that makes d2lang support embedding instructions 
  or commands that can be bootstrapped via vim.
  technically supports getting markdown and embedding it in a diagram, 
  and an iso lens category that allows the diagram to be embedded in the 
  markdown, and some success demonstrating the splitting of graphs.


- did some CSS to waybar, to make it not so ugly, and added 
  workspace indicators, which is useful 

**Neutral**

> *** ADD NEUTRAL THOUGHTS AND EXPERIENCES BELOW ***

- remember i need to ensure messages have invariant first, 
  as that gets cached server side, "INSTRUCTIONS FOR THE STATIC CONTEXT APPLY VARIABLE CONTEXT  -- STATIC CONTEXT LIKE ATTACHMENTS -- variable context"
  make it so that it works by appending, and the last bit could be redone".  

- had an idea to make specs be measured in efficicacy based 
  on how stupid a model can follow spec so a pass mark is if the 
  ai acts as a useful tool to apply specs, and use multiple models from  
  a variety of LLMs, to distill the best one.

- idea to use metric of number of items from each retro, 
  to scale the shifts between positive, neutral and negative things,
  to highlight points of interest to see what big idea helped, 
  and what challenges were encountered.

- Long break, did some short work before retrospective on retrospectives.

- remembered what i was doing: {diagram -> lit spec spec, example specs -> lit spec spec}  -> literate spec for literate spec to build self implement specs documents 
  -> use literate process to build {configurations, for {bootstrap process to split component yaml specs into collections -> generate deployable collection of subsystems} ->
use meta components to build the rest of subsystem modules (to regenerate infrastructure systems) -> 
{generate a play sandbox for self-building tools, as an AI sandbox, CI/CD Pipeline, os in a webbrowser via nspawn, etc.}.
 -> {start literate tools for ai assisted generation and experiments, have a fast and clean and checkpointable development process,
 migrate neovim and other tools} ... etc... but i need to make this naturally visible
 -> rapid dev environment for infrastructure orchestration -> remember aims to be able to architect systems and orchestrate live systems 
  at the speed of thought (like i did with web design when i was young,
  applying the changes in real time to apply design ideas as its being 
  explained --> make it document and present itself, such that 
  the thing it describes, can be used independently, and played with 
  via an ephemeral system in a universal manner (web, local, whatever tool), 
  be able to describe complex things, that can be implemented with the generated
 resources, and allow universal constructions to be defined abstractably such that 
 it forms a resource that enforces the architectural design decisions such that humans-and-ai produces reliable 
 solutions in a sandbox environment, etc...} 


- did experiment, and was able to decompose graphs and specs 

**Negative**

> *** NEGATIVE THOUGHTS AND EXPERIENCES BELOW ***

- Hate how i cant see progress, i do a lot and its hard to remember 
  i did anything though i did alot

- Hate slow progress rate, but hate regressions more.

- Hate how i have practices like vsplit in neovim, but i forget to use 

- Hate how it feels that LIT_SPEC dev is taking so long.

- Hate how I have the information, but its annoying to figure out where i am at 

- Feels like I'm working harder not smarter.

- It's frustrating how LIT SPEC is not finished 

- It's frustating something as easy as RETROSPECTIVE template 
  took so long, and even half assed it to write this.

- tmux sessions and waybar is annoying cause i cant which desktop 
  or nvim session things are on easily, and desktop numbering 
  in waybar is better than no indicator, but could be better 

- its so frustating that i don't have ai resources built yet 

- keep writing too much, and get too attached, as its overly verbose

- i have everything done, why can't i focus and get it done. need 
  to have a system that makes me feel comfortable with flying through work 

- hate how i keep having urges to check if my models are right, 
  before testing them.

- hate how i feel like im making progress, only for a slight distraction
  to create a mess of the work.

- hate how neovim can resolve ENV VARS in autocompletions, so when i search 
  Sandbox I can't auto complete (the bigger problem is I forgot how idiot proof 
  I made the naming scheme, and it took me a little bit to remember).

- I don't like how I didn't add Retrospectives path to the OA CONFIG stuff

- hate when i do restrospectives theres so much to go through,
  nice to have some automation in neovim, i have the framework, where
  all my neovim extensions are based on leader key, plugin or concept specifc keys
  and plugin actions like `:LspSaga outline` mapped to things like `<LEADER>+s` and `o` 
  to display outline (provided by things like zoxide-markdown or whatever`.
  
  

## Discussion

    Discuss the retrospective activity responses 
     and identify actionable items.


*Discussion of the configuration systems*

The configuration system, and how it allows me to build the system,
it is important that the configuration system is added to CONFIG LIT-SPEC
hate to lose track of it.

> **Actionable Item**:
> Add CONFIG LIT SPEC Work to a REQUIREMENTS document.

It is easier to maintain focus with the configurations putting 
useful paths into the env vars. 

> **Actionable Item**:
> Add the useful configurations progress to CONFIG SPEC design


*Discussion on tooling*

> **Actionable Item**: Add keymapping spec to TERMINAL-AI Ideas 

*Discussion on regaining lost context*

The print out of the last thing I did helped me recall everything
I was just working on before a big break.

The process of refining a model from diagrammatic reasoning 
to achieve a design for tasks and other development, that lead 
to designing a universal solution to a set of issues (the tasks system),
needs to be recorded. 

> **Actionable Item**: Add idea for modelling process to aid in design.

*Discussion on Tasks*

Everything takes too long 

> **Actionable Item**: Create ideas that can be extended that I can easily add inefficiencies as I see it.

> **Actionable Item**: Explore ways that I can speed up and automate certain processes incrementally.

*Discussion on Retrospective*

I need to constrain the messages to be limited to like a post it note

> **Actionable Item**: Add *SHOULD* recommendation for limiting length of retrospective activity in the retro spec.

Or more importantly, it should be done more frequently, ideally after a set amount of work has occured,
after a set amount of time, when some project finishes, but don't want to make it to constraining.

I've spent hours on this retrospective.

> **Actionable Item**: Add to RETROSPECTIVE Lit. Spec. that need to keep periods between reviews shorter.

Need to make it so the actionable item title starts on next line for 
readability.

> **Actionable Item**: Add that an Actionable Item *SHOULD* have the parsable invariant on first lines
  and start title on next line. *MAY* Extend lines if the two first lines is descriptive enough.

Need to move the tools to be generated to a *LIT SPEC* for tools.
But to do that I really need to do lit spec first.

When using tee, using a temp message file, that makes it easy to copy content from a known location.

The useful command is: `echo "/tmp/last_message" | entr -pc bat /tmp/last_message`

> **Actionable Item**: Add tasks to integrate 'terminal-ai' *entr* viewer into shell configuration for terminal-ai 

> **Actionable Item**: Add tasks to implement 'terminal-ai' *neovim* calling, and  
> composition of message and last instruction 

Proposed improvement is to have instructions and message be composed into the command:

```nvim
'<,'>w !cat | wl-copy; set message "$(wl-paste)"; terminal-ai -- "$message" | tee "/tmp/last_message"
```

Need to show how NVIM and ENTR terminal-ai solutions with "!!" to replay. This tricks need to be recorded clearly maybe in DESIGNS, or maybe SPECS.

Need to implement live application of changes during dev:

`set CURRENT_SANDBOX "$OA_SANDBOX_PATH/LIT_SPEC Sandpit"; echo "$SANDBOX/shell-configurations/orchestration-architect.fish" | entr fish "$CURRENT_SANDBOX/oa-load-environment.fish"`

> **Actionable Item** Add tasks to add capabilities to integrate auto application of shell scripts configurations when developing.

> **Actionable Item**: Add task to add last message tmp file to XDG STATE path 

> success experiment that makes d2lang support embedding instructions 
> or commands that can be bootstrapped via vim.

The Literate D2 graph and stuff was cool. But more importantly is: 

> **Actionable Item**: Add tasks to import the symmetric monoidial category modelling framework.

*Which reminds me, this would be a useful action:*

> **Actionable Item**: Add live task and project tracking tools in a named tmux session.

In relation to waybar and workspace stuff. Honestly, might not even be worth it until I migrate 
the desktop submodule.

> **Actionable Item**: Add an IDEA doc to capture design decisions for desktop integration. (Probably defer).

> **Actionable Item**: Add an IDEA doc for TERMINAL-AI to record ideas for the REQUIREMENTS and DESIGN processes, such as cache optimisation strategies

> **Actionable Item**: Explore visualising development in sandbox.

> **Actionable Item**: Add framework for AI improvement processes to Ideas for Terminal AI 

> **Actionable Item**: Create Experiment in Sandbox for neovim and terminal-ai to allow single sentence changes for routine tasks.

> **Actionable Item**: Create experiment in sandbox to explore analysing retros.

*Discussion on WHY I WORKED ON WHAT I DID*

```text
Let's see if I can come up with an instruction to take the following, and just tidy up output with things.

Context: This is a single discussion item from a retrospective (from a one-person team).

Instruction: Create a **set of instructions** to make the following easier to read adhering to the Common Markdown Spec and improve readability (consider whats wrong, and what instruction could be given to improve it)...

Result: ...Doesn't listen to instructions...

```

> **Actionable Item**: Spend time integrating actually doing a project plan, or a WBS at least to model what needs to be done and why. Use AI tools to aid and document.

**TRYING TO FIGURE OUT THE DEPENDENCY ON TASKS FOR PRIORITISATION OF TASKS AND IDENTIFICATION OF MORE EFFICACY DEVELOPMENT**

Diagrams -> Lit. Spec. Specification - i wanted to put diagrams in lit. spec.

Example Specs (Configuration of Shells, etc) -> Lit. Spec. Specification - i wanted to workshop example specs

Sandboxed Shell Configuration Experiment 

- I was getting frustrated not having 
environment vars when i needed them.

ENTR stuff -> needed to make project/tasks/terminal-ai/config dev display automatically.

Retrospective Spec... Design of Process Framework... etc... I need to control the inputs, as skipping steps causes more problems than it solves.

though i should note that need, is based on doing work such that if changes are made there is no drift (it will always work), as 
the literate specification is used as the core of the system.


So: lit_spec spec is needed to create self assembling specs

self assembling spec is needed for configuration spec, making the self-assembling meta components a literate spec 

need the self-assembling meta components literate spec to braid extensions through the regeneration of the seed 

need the literate specification, to braid aim to problems in requuirements or retrospectives,

that flow to design that analyses it all and defines the components and rationale 
behind requirements,

and the designs are used to provide context when working on specs, the specs are self-assembling, though it should be noted that I going out of order 
has only caused hardache. 

I want to automate most of the work or provided a bespoke Language Server, that can be defined in a literate specification.
I need the literate specification to specify tools that will aid in the process.

the need to update the self-bootstrap process is to provide method to make changes to the subsystems globally, to 
allow individual functionality to be split as independent deployable components (so the system can break apart and provide its self-assembled systems as individual 
components for distribution). 

the literate spec specification is needed to rapidly increase velocity in adding new composable systems 

the literate spec specification is needed to implement other specifications (such as the resolution and auto contextual web of project and engineering docs, and etc.).

the literate spec specification is needed to implement tooling that braids with the rest of the system naturally.
the literate spec specification is core for the rebuild of terminal-ai to support multi-agent experiments 

the meta component subsystem being detachable, will allow for more complex braiding, like taking a part of the system and using the generated ephemeral systemd-nspawn containers, running in ephemeral ram-backed loop devices which hold the btrfs overlay for systems, such that it can allow instantenous traversal and replay and auto-feedback systems. 

the a couple of the components subsystems are core to the self-bootstrapping of the OA001 Master Transient Infrastructure Encrypted Deployer of PXE-Bootable hardened ephemeral ram-backed nested hypervisors.

The subsystem modules are needed to self-assemble a CI/CD pipeline. The CI/CD pipeline is needed to implement the model of the self-verifying and auto-versioning based on colimit and etc. 

The literate spec is needed to automate tests, ensure certain architectural decisions on category theoretic are verifiable.

The super fast ephemeral sandbox is needed to provide a controlled and isolated enviornment for multi-AIs to have full freedom to experiment with the system  design.

The literate spec lit. spec. is needed to write a literate spec to apply the distillation of the SWEBOK areas of knowledge.

The literate spec specification is needed to define the specifications for making a functor between the system and the graph parser and generator.

The super fast ephemeral sandbox is needed to run bootstrap processes faster.

The splitting of yaml meta specs of the subsystem components is needed to make the yamls more managable by humans (and so I can split the base spec, so they can be deployed within subsystem module collection).

The literate specification of the subsystems modules, will mean that I will never have issues with making changes like this.

The infrastructure orchestration system is needed to demonstrate a ephemeral demonstrative and fully working deployments on the fly. 

The component subsystem modules are needed to do any work with trying to make a fully usable and demonstrative rust app that allows deploying live sandboxes people can try within a browser.

The configuration spec is needed to ensure global consistency, the containerised sandbox environment needs to be able to test the self-assembly for different sections 
and etc. 

The literate spec lit. spec. is needed to take the earlier prototypes and convert them to an implementation.

Need literate specifications to support reuse of abstractions as a resource, so I can more easily autogenerate the diagrams 

that provide observability in this graph (well preorder) tensor product, that composes new higher order units of preorderable components, that compose up and also downwards if needed. 

use literate process to build {configurations, for {bootstrap process to split component yaml specs into collections -> generate deployable collection of subsystems}

use meta components to build the rest of subsystem modules (to regenerate infrastructure systems) 

generate a play sandbox for self-building tools, as an AI sandbox, CI/CD Pipeline, os in a webbrowser via nspawn, etc

start literate tools for ai assisted generation and experiments, have a fast and clean and checkpointable development process

migrate neovim and other tools} ... etc... but i need to make this naturally visible 

rapid dev environment for infrastructure orchestration -> remember aims to be able to architect systems and orchestrate live systems 

at the speed of thought (like i did with web design when i was young,

applying the changes in real time to apply design ideas as its being 

explained --> make it document and present itself, such that 

the thing it describes, can be used independently, and played with 

via an ephemeral system in a universal manner (web, local, whatever tool), 

be able to describe complex things, that can be implemented with the generated

resources, and allow universal constructions to be defined abstractably such that it forms a resource that enforces the architectural design decisions such that humans-and-ai produces reliable solutions in a sandbox environment, etc...} 

> **Actionable Item**: Explore how the to represent dependencies before I integrate it properly.

> **Actionable Item**: Explore how all the values, objectives, missions, purposes discussions and theoretic underpinnings documents can be integrated more easily.

Oh a thing I forgot is that I liked is how I manage daily notes. I also have to bring in some work done outside of the main project, but for the project. It 
is in a private prototype sandbox repo, to prevent accidently commiting things like my shell history, extract browser indexdb exports, browser bookmarks, vim history, and other work towards making 
parsers and other such things accessible to the ambient contextual intelligence framework. The shell history, and vim stuff, idea is to figured out where you are and what you are doing, 
so it can compose with the semantic hypertree imposed on what was created by what. But later things.

**STUFF I CANT BE BOTHERED DISCUSSING**

> Hate how it feels that LIT_SPEC dev is taking so long.

> Hate how I have the information, but its annoying to figure out where i am at 

> Feels like I'm working harder not smarter.

> It's frustrating how LIT SPEC is not finished 

> It's frustating something as easy as RETROSPECTIVE template 
> took so long, and even half assed it to write this.

> tmux sessions and waybar is annoying cause i cant which desktop 
> or nvim session things are on easily, and desktop numbering 
> in waybar is better than no indicator, but could be better 

> its so frustating that i don't have ai resources built yet 

> keep writing too much, and get too attached, as its overly verbose

> i have everything done, why can't i focus and get it done. need 
> to have a system that makes me feel comfortable with flying through work 


> hate how i keep having urges to check if my models are right, 
> before testing them.

> need to make models and resources more accessible, and get all the existing models 

> hate how i feel like im making progress, only for a slight distraction
> to create a mess of the work.

> hate how neovim can resolve ENV VARS in autocompletions, so when i search 
> Sandbox I can't auto complete (the bigger problem is I forgot how idiot proof 
> I made the naming scheme, and it took me a little bit to remember).

really need to do something about this vim stuff, should dedicate some time 
to implementing this. 

> **Actionable Item** Make a PROTOSPEC composable nvim extensions 

> **Actionable Item** Write something that lists the resources in the development journal

> I don't like how I didn't add Retrospectives path to the OA CONFIG stuff

> **Actionable Item**: Add retrospectives path to environment variable.


## Review on Previous Actionable Items 

**Review Item**:
Write a SPEC document that will create the sandbox kanbans and etc.

Did a good model will need to integrate.

> **Actionable Item** Pair the configurations to journals to a summary tool

**Review Item**:
Create a literate spec for the collection `oa.meta`, so I can use it to create more templates and the like. Perhaps work on slowly over time.

> **Actionable Item** Make a list of tentative specs to work on.

**Review Item**:
Rename notes using the example script.

Need to do 

> **Actionable Item**:
> Rename notes using the example script.

**Review Item**:
Add specs that operations can be defined, and can generate 'tools' for create and open note.

Just add to backlog 

> **Actionable Item**:
> Add Tasks so that operations can be defined, and can generate 'tools' for create and open note.

**Review Item**:
Create sandbox for workspace aand gather the many revisions of the project system.

I did this I think. I created a sandbox called sandpit per project.

**Review Item**:
Create a goal with candidate resources and actual resources with a roadmap to achieve it.

Screw it for now, thats pretty well ingrained in my head, 
I'll add it later.

> **Review Item**: 
> Create sandbox for all the diagrams created. Make a webpage with the diagrams to easily view.

This is basically the architecture sandpit I created.

> **Review Item**: 
> Standardise kanban

Not yet done. 

> **Actionable Item**: Create tasks in OA_PROJECT for Preamble and Kanban standardisation

> **Review Item**: 
> Tidy up CONFIGURE kanban to focus on
> creating a tool and executing it to setup environment
> variables for paths in tool.

I created a tool need to document. 

> **Actionable Item** Create a task to add design for the CONFIGURE fish stuff.

**Review Item**:
Prototype keeping API keys in systemd credentials. 

> **Actionable Item** Create a task to create an IDEA to put API keys behind systemd credententials.

**Review Item**:
When documenting the resources it should have a diagram of the parts.

> **Actionable Item** Add a task that all configurable resources can display its contents

**Review Item**: Get D2 to render as part of the literate toolchain. Maybe make an mdbook or something using this.

> **Actionable Item** Add a task to document D2 rendering in toolchain. 

**Review Item**:
Sandbox experiment literate document comparing results. This involves upgrading terminal ai with the improved transcript structure. It will need read and write actions, to filter the 

> **Actionable Item** Add a task to TERMINAL_AI project to upgrade transcript structure.

**Review Item**: Model how neovim and terminal ai come together.

> **Actionable Item** Add a task to define functors between projects.

**Review Item**: Write a REQUIREMENTS, DESIGN, AND LIT-SPEC for DESIGN Document, with minimal template.

> **Actionable Item** Ensure a task to  REQUIREMENTS, DESIGN, AND LIT-SPEC for DESIGN Document, with minimal template.

**Review Item**
Get some transcripts and provide a comparison of the answers (explore evaluation of agents)

Not important now.

**Review Item** 
Search for the transcript where I experimented making deepseek use Minsky model of self-reflection.

Don't care anymore.

**Review Item**
Before finishing design doc, compare deepseeks results, and also find source material to evaluate correctness.

Nope. Just couldn't be bothered.

**Review Item**
Make the Bookmark Tool and DeepSeek Web transcript extractor a OA-NOTE. Consider if extractors are a tool or spec.

> **Actionable Item**
> Ensure the offline parsers and private projects have tasks to integrate

**Review Item**
Have the project and kanbans demonstrate via literate writing Abstract Compositional Topology 

Screw it for now.

**Review Item**
Make Task to create Specifications for Project Docs.

**Review Item**
Generate a clean view of Tasks and Projects with `nvim-orchestration-architect`

later.

**Review Item** Ensure TF-IDF stuff is in the sandbox

meh i'll check.

> **Actionable Item** Ensure TF-IDF is in sandbox

**Review Item**
Add an *Idea* for LSP work.

Nah can't be bothered.

**Review Item**
Add a max line length indictor in neovim.

I can't be bother right now.

---

## Literate Writing Bits 

```sh «get actionable items»
cat "Retrospective.2025-05-21.md" | grep -P '\W{1,8} \*\*Actionable' --after=1 | sed -E 's/Actionable/Review/g' | sed -E 's/--//g'
```


