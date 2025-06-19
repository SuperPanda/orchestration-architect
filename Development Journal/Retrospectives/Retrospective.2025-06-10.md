# Retrospective Journal `2025-06-10`

## Retrospective Activity

**Positive**

> *** POSITIVE THOUGHTS AND EXPERIENCES ***

I really liked getting mdbook, tinyproxy and the custom scheme handler. #custom-urn-scheme

Having all the documents to link semantically is great. for example `oa://docs` and `oa://notes` are pointing to different 
document repositories, but can navigate between semantic things is really powerful. #custom-urn-scheme

I love that the `d2` renders with links so that framework diagram links to the relevant sections. 

I feel things will crystallise once I start using the architectural framework.

**Neutral**

> *** NEUTRAL THOUGHTS AND EXPERIENCES BELOW ***

The DoDAF2 architecture framework seems to a useful for capability focused system development.

There is many models that will be needed, but need to be as direct as possible. 

Explored composition using transcluded sections (using `includes`), but found that this caused more problems cognitively.

Need to really consider the requirements of the architect - suggesting first researching and modelling.

Wondered if I should start getting the system to report capabilities like on some ActivityPub or online site.

**Negative**

> *** NEGATIVE THOUGHTS AND EXPERIENCES BELOW ***

Now another massive pile of things to work with - the immaturity of the framework  is going to be challenging.

The live updating of documents after following links, because the websockets are not being forwarded.

It is frustrating that I don't have a requirements document standardised yet.

The Project Viewpoint and the other Viewpoints are hard to make use of.

The experiments with literate writing for literate tasks and AI caused the last block.

Hate how nothing ends up complete, due to being stuck in sandbox, due to not having CI/CD setup.

Hate the fact that I don't have a good framework for information.

## Discussion

    Discuss the retrospective activity responses 
     and identify actionable items.

So where do I begin.

Lets note the breakthroughs:

The use of **scheme handler** `oa://` using the Freedesktop XDG Handler, 
allows a web of self specifying *resources*. Though, I still need to define to formalise the spec.

I guess we should look at a capability maturity model. And definitions. Hmmm.

Lots of capabilities exist but are not properly documented. What is properly documented? Well it automatically populates 
an architectural viewpoint.

I'm aware the DoDAF2 is built on providing a meta framework.

The *mdbook preprocessors writeup* went a long way to show how to get things done quickly and fast. 

A Self-Specifying Autological Framework, requires the Architecture be Self-Specifying, from Specifications.

Need an initial object or morphism, must self assembly, it must adhere to naturality.

Start with what is an Architectural Framework, Models, etc.

So `AV-1` is the overall or whatever. I guess we should think where does it all start. 

> **Actionable Item** Define and Implement the *Architectural Framework* the work breakdown for the initial requirements - a repeatable and regenerable modelling process.

Would be good to setup the minimal documentation system. Could use AI to autosuggest from examples.

> **Actionable Item** Timeboxed Proof of Concept of Architecture-Driven Context for Neovim.

A core operation/process is the *RETROSPECTIVES*. This is a good mini-system that can be developed fully.

Since the mind can be seen as a bunch of resources, we must consider the individual first as a system.

The individiual horizon is the system is to provide a system to provide myself capabilities. These 
capabilities are expected to be battle tested by achieving a capability by being able to architect 
at the speed of thought and orchestrate system deployment and provisioning, in a secure way.

> **Actionable Item**: Timeboxed retrospective of retrospectives and other documents.

Core features of a retrospective... 

    Goal of retrospection activity: a-clear-mind
    a passing-thought-or-experience is-recorded-in a-retrospection-activity-entry 
    a-retrospection-activity-entry is-discussed-in a-discussion 
    an-actionable-item is-a-realisation-of-a-potential-action
    
... something like that

Could explore building requirements and other docs using the ontology/taxonomy.

> **Actionable Item**: Add ontology/taxonomy models for the `All Viewpoints` Viewpoint.

But I need it to be implemented. Let's say... I focus on tiny cycles for delivery, but composable.

I would need `OA/AV-1` model to provide like the view to all view points, possibly as a 'SPEC' or something.

The `OA/AV-2` model is to provide a view on all the language and stuff used.

The `OA/CV-1` model I imagine would need to provide the overall capability viewpoint.

> **Actionable Item**: Define the minimal development cycle that works.

> **Actionable Item**: Setup WBS and Timeframes, that facilitate re-design by allowing rejigging 
the scope/time/quality.

Scope to fit in Time-Quality constraints. 

Gonna need metrics for quality... in that they are reusable, 
will not require rework - easily automatable changes... etc.

Time will need to be partitioned into flexible concepts.

This will require a well defined contexts to switch between. I have some 
experience in this challenge using the capabilities added.

I'm starting to question whether SemVer is the right thing to use.

When thinking rapidly, there needs to be the capability:

- Not impede the decision process 
- Not lose important decisions 
- to maintain cognitive performance (should not overload information or make it hard to find)

I think the most important thing is the document system as is currently implemented.

> **Actionable Item** Setup `Project Viewpoint` to display existing project viewpoint.

> **Actionable Item** Consider revising the `self-assembly` requirement, as a competency maturity metric.

## Review on Previous Actionable Items 

> **Review Item**:
> Add CONFIG LIT SPEC Work to a REQUIREMENTS document.

Don't think this wasn't done due to needing to capture the current standards,

> **Actionable Item**: Capture *CONFIG LIT SPEC* Completed Work within some ARCHITECTURE Viewpoints

> **Review Item**:
> Add the useful configurations progress to CONFIG SPEC design

> **Actionable Item** Capture configurations spec DESIGN progress 

> **Review Item**: Add keymapping spec to TERMINAL-AI Ideas 

> **Actionable Item** Specify Documents in Architecture.

> **Review Item**: Add idea for modelling process to aid in design.

> **Actionable Item**: List examples and description for each type of architectural model

> **Review Item**: Create ideas that can be extended that I can easily add inefficiencies as I see it.

> **Actionable Item** Create idea conception to implementation flow in architecture 

> **Review Item**: Explore ways that I can speed up and automate certain processes incrementally 

> **Actionable Item** Timebox a meta document structural modelling.

> **Review Item**: Add *SHOULD* recommendation for limiting length of retrospective activity in the retro spec.

> **Actionable Item**: Capture retrospective activity *limited length constraint* for retrospective activity.

> **Review Item**: Add to RETROSPECTIVE Lit. Spec. that need to keep periods between reviews shorter.

> **Review Item**: Add that an Review Item *SHOULD* have the parsable invariant on first lines
  and start title on next line. *MAY* Extend lines if the two first lines is descriptive enough.

Need to make sure the different elements are rendered properly using different mediums.

Will probably do this later. Skip for now. Aim to have it built up and the specs are simple to 
ensure proper parsing.

> **Review Item**: Add tasks to integrate 'terminal-ai' *entr* viewer into shell configuration for terminal-ai 

Need to do.

> **Actionable Item**: Add tasks to integrate 'terminal-ai' *entr* viewer into shell configuration for terminal-ai 

> **Review Item**: Add tasks to implement 'terminal-ai' *neovim* calling, and  
> composition of message and last instruction 

Model LSP, NEOVIM and TERMINAL-AI system-system interaction, sort of idea.

> **Actionable Item** Define TerminalAI (required?) capabilities.

> **Review Item** Add tasks to add capabilities to integrate auto application of shell scripts configurations when developing.

Reword so the architecture guides it 

> **Actionable Item** Add tasks to include work done that allows real time dev feedback shell script configuration system

just figured i should mention I need to create a taxonomy that facilitates 
describing some degree of system-of-systems. 

> **Actionable Item** Create a taxonomy modelling process.

> **Review Item**: Add task to add last message tmp file to XDG STATE path 

> **Actionable Item** Add viewpoint that demonstrates how the `$XDG_STATE/terminal-ai/latest-message` 
  spec would be composed.

> **Review Item**: Add tasks to import the symmetric monoidial category modelling framework.

> **Actionable Item**: Import the diagramming work.

> **Review Item**: Add live task and project tracking tools in a named tmux session.

> **Actionable Item**: Experiment with using Viewpoints in *tmux* like live task and project tracking appears in tmux.

> **Review Item**: Add an IDEA doc to capture design decisions for desktop integration.

Probably defer.

> **Review Item**: Add an IDEA doc for TERMINAL-AI to record ideas for the REQUIREMENTS and DESIGN processes, such as cache optimisation strategies

> **Actionable Item**: Add an IDEA framework that would track TERMINAL-AI  ideas for the REQUIREMENTS and DESIGN processes, such as cache optimisation strategies

> **Review Item**: Explore visualising development in sandbox.

Yeah, gonna use the documents. 

> **Review Item**: Add framework for AI improvement processes to Ideas for Terminal AI 

Had another idea. When linked resources change, like the meta model, it could use a viewpoint model  
to trace changes, and then it could be automated eventually. So an IDEA becomes MANUAL WORK, then becomes 
Defined, then Tracked/Automated, or something. 

> **Actionable Item**: Capture TerminalAI Capabilities Ideas. 

> **Review Item** Create Experiment in Sandbox for neovim and terminal-ai to allow single sentence changes for routine tasks.

> **Actionable Item** Add Ability to Apply Single Sentence Changes in Neovim from TerminalAI, and identify relevant viewpoint. #architecture #terminal-ai

> **Actionable Item** Using AI responses as a proxy for instruction comphensionability and conceptual alignment,
setup an experiment, that a) using a sample description of a viewpoint, use it to generate the other viewpoints, b) 
take multiple capability efforts, from efforts related `OPERATIONS-RESOURCE-NATURALITY` or `PROJECTS-RESOURCE-NATURALITY`. #architecture

> **Review Item**: Create experiment in sandbox to explore analysing retros.

> **Actionable Item**: Spend some time setting up a framework for TERMINAL-AI HUMAN system-system interaction.

> **Review Item**: Spend time integrating actually doing a project plan, or a WBS at least to model what needs to be done and why. Use AI tools to aid and document.

> **Actionable Item**: Spend time doing higher level planning *planning* - Project/Capability/etc 

> **Review Item**: Explore how the to represent dependencies before I integrate it properly.

Guessing these are talking about configurations or something.

> **Review Item**: Explore how all the values, objectives, missions, purposes discussions and theoretic underpinnings documents can be integrated more easily.

I saw some resources in *Lean Enterprise* that contains concepts from *Computer Science* and *Organizational Behaviour* and *Management*.

I did see a good description of *mission*, *objectives*, etc. I will need to ensure cross entropy autocorrelation 
(I mean that the use of the words, line up with the semantic context and intepretation), such that 
Minsky and Applied Category Theory models hold up the purpose of these ideas are coherent. Defining coherent might 
be a good idea.

Maybe define sections like this as last context. And maybe we can get a good system going, I think using the Capabilities 
focused architecture might be useful in getting AI aligned with objectives. Also need to track the times AI got wrong.

> **Actionable Item**: Experiment with how the values, objectives, missions, purposes and theoretic underpinnings can be 
integrated and sorted into the Viewpoint, such that the normal work products naturally integrate.

> **Actionable Item**: Timeboxed experiment creating a *RATATUI* viewpoint, possibly with functors to common mark content.

> **Review Item** Make a PROTOSPEC composable nvim extensions 

I'm guessing I meant prototype specification. Eh, this can be refound through the product of nvim and literate spec
systems. The LitSpec System, is the structural and functorial mapper: that uses the structure as an *implicit preordering*
to generate a semantic enrichment achieved through carefully defined primitive operations.

> **Review Item** Write something that lists the resources in the development journal

Figure out how to add all the documents to the `oa://docs/`, configured by `$XDG_CONFIG_HOME/orchestration-architect/.config.yml`

> **Actionable Item** Create a basic document taxonomy that will populate the `oa://docs/<docuument type>`, and include a `SPEC` for the `urn` protocol.

> **Actionable Item** Have TerminalAI provide possible solutions in real time when describing a problem, possibly as a stream,
to see if there is no misunderstanding about the problem (AI as a instant feedback mechanism for highlighting incoherent requirements). Requires that no 
interaction is permitted by user from the fast feedback.
> Something like **AI Question** [TAI-INLINE_QUESTION-XXX] HOW DO I MAKE ...THIS STRING... IN ...NEOVIM... ...OUTPUT THE RESPONSE IN FIELD... etc.


> **Review Item**: Add retrospectives path to environment variable.

Improved task purpose.

> **Actionable Item**: Add environment variables to a document that contains configuration. So that the retrospectives path is added to environment variable, and captured in viewpoint. Consider the `absent`/`present` homomorphism.

> **Review Item**: Pair the configurations to journals to a summary tool.

Made clearer.

> **Actionable Item** Use the mdbook summary generator for daily notes, infact capture the tooling too.


> **Review Item** Make a list of tentative specs to work on.

I read about a term related to system engineering, like round-trip engineering or something.

Maybe a context capability might help, like look something up, maybe construct an ontology.

> **Review Item**:
> Rename notes using the example script.

> **Actionable Item**: Rename Note Schema, move notes to sandbox under `PROJECT Sandpit`

> **Review Item**:
> Add Tasks so that operations can be defined, and can generate 'tools' for create and open note.

> **Actionable Item** Capture the design of the `create-note` and `open-note` using the *create* note 
to create the latest note, and the *open-note* to open the latest, if one exists, just open the current one of something.

> **Review Item**: Create tasks in OA_PROJECT for Preamble and Kanban standardisation

> **Actionable Item** Standardise the Preamble and Kanban components.

> **Review Item** Create a task to add design for the CONFIGURE fish stuff.

> **Actionable Item** Investigate **ologs** for natural language literate capabilities

> **Review Item** Create a task to create an IDEA to put API keys behind systemd credententials.

> **Actionable Item** Explore secure secrets with systemd creds and sockets 

> **Review Item** Add a task that all configurable resources can display its contents

Think this is more of a capability of the *ARCHITECTURE*

> **Actionable Item** Define architecture capabilities specification - all configurable resources is viewable.

> **Review Item** Add a task to document D2 rendering in toolchain. 

> **Actionable Item** Capture the d2 architecture rendering within toolchain - capture how it facilitates operations (modelling).

Perhaps we could specify a taxonomy as... a slice of an ontology or ss.?

    ```
    # Retrospective Specifications 
    ## `RETROSPECTIVE` Definitions or Taxonomy (or something)... thats links to the `OA/AV-1` etc
    ---
    TERM | Definition 
    ---
    ```


> **Review Item** Add a task to TERMINAL_AI project to upgrade transcript structure.

> **Actionable Item** Capture the Transcript Structure in a Viewpoint.

Use this for more context https://en.wikipedia.org/wiki/View_model

> **Review Item** Add a task to define functors between projects.

> **Actionable Item** Identify all the core viewpoints implicit in the system design 

> **Review Item** Ensure a task to  REQUIREMENTS, DESIGN, AND LIT-SPEC for DESIGN Document, with minimal template.

> **Actionable Item** Ensure at least a template is available for REQUIREMENTS, DESIGN, SPECIFICATION, etc.

> **Review Item**
> Ensure the offline parsers and private projects have tasks to integrate

> **Actionable Item** Ensure there is a Viewpoint for retrospectives 

> **Review Item** Ensure TF-IDF is in sandbox

if needed i will...

> **Actionable Item** Make a retrospectives presentable.

cat "Retrospective.XXXXXXXXX.md" | grep -P '\W{1,8} \*\*Actionable' --after=1 | sed -E 's/Actionable/Review/g' | sed -E 's/--//g'
   
--- 
