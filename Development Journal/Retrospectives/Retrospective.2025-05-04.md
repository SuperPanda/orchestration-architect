# Retrospective Journal 2025-05-04

## Retrospection Activity

**Positive**

    ** ADD POSITIVE THOUGHTS AND EXPERIENCES HERE **

- Notes has slowed down in growth rate. Still probably to much to process backlog.

- Context shifting slightly improved.

- Every session starts with Daily Notes and Summary of Projects

- Progress made in `NOTE-031 Literate Specification` for the `DESIGN`  of
Literate Specs.

**Neutral**

    ** ADD NEUTRAL THOUGHTS AND EXPERIENCES HERE **

- I want a visual summary of thiongs.

- I wonder what the TerminalAI transcripts would be if I compared it with deepseek.

- I wonder if the Kanbans all being in one place is correct, or should I have a Directory per 
  project. I think its simpler to have each resource be under the resource, and have like a 
  bunch of resources have like multiple trees, where leaf nodes compose across trees.

- Could use the trick of Turning Files to `Intermediate Representations` to literate documentation,
  to turn legacy code into a document that ccan be used to rewrite.

- Deliverables are a hard concept to work with chaotically.

- Would be nice to have the thematic concepts that started the project included in the codebase easily.

- Remembered I needed to add the changes to 'tools' to the tasks.

**Negative**

    ** ADD NEGATIVE THOUGHTS AND EXPERIENCES HERE **

- Daily Journal seems to be getting more admin work than actual work. Or I do the work in the journal.
  This results in the work not being added directly.

- Notes are too cumbersome to work with quickly.

- No direction on projects. Lack of quality goals, too ad-hoc.

- Tasks way too big. Addressed with daily journal, but now things are not making it in the project.

- Inconsistent naming conventions between documents in related domains (like OA-NOTES is hard read the filenames
  in some contexts.

- AI is of no help, as memory recollection should be tied to a goal/context. 


### Discussion 

    ** DISCUSS RETROSPECTION ACTIVITY RESPONSES AND IDENTIFY ACTIONABLE ITEMS **

To reduce Daily Journal lost work, I will formalise the *sandbox* branch to be a list 
of tracked exeriments and prototypes.

>   **Actionable Item**: Write a SPEC document that will create the sandbox kanbans and etc.

One of the things I should keep track of was the goal of *splitting the yaml* to create collections.

>   **Actionable Item**: Create a literate spec for the collection `oa.meta`,
    so I can use it to create more templates and the like. Perhaps work on slowly over time.
    And structure as a unital resource.

For the naming conventions, I will rename the NOTES using the example script I have to do it.
I will basically rename everything and live with the consequences, or alterantively, I write a 
NOTE that can do it. 

>   **Actionable Item**: Rename notes using the example script.

Also, to make it easier to do things, I have created things like 'create-note' and 'open-note' for daily notes.
I will use this pattern for normal notes.

>   **Actionable Item**: Add specs that operations can be defined, and can generate 'tools' for create and open note.

For better visual display, I will look at the older notes and transcripts I have pertaining to the layout 
of the project task. I will make a literate note to do the move inactive-active morphism for project documents.

>   **Actionable Item**: Create sandbox for workspace aand gather the many revisions of the project system.

>   **Actionable Item**: Create a goal with candidate resources and actual resources with a roadmap to achieve it.

>   **Actionable Item**: Create sandbox for all the diagrams created. Make a webpage with the diagrams to easily view.

Projects will use the sandbox, to group development work, so each task can have its work pointed to a part.

Need to do a CONFIGURE spec that creates the tools and setups the paths in the user environment.

>   **Actionable Item**: Standardise kanban

>   **Actionable Item**: Tidy up CONFIGURE kanban to focus on creating a tool and executing it to setup environment
    variables for paths in tool.

Consider storing api keys in systemd credentials.

>   **Actionable Item**: Prototype keeping API keys in systemd credentials. 

>   **Actionable Item**: When documenting the resources it should have a diagram of the parts.

Need D2 to render as part of the literate toolchain.

>   **Actionable Item**: Get D2 to render as part of the literate toolchain. Maybe make an mdbook 
    or something using this.

Experiment literate research document, that attempts to see if better results come from a goal or context.
This can be done as a interaction between the literate specifications (LITERATE_SPEC) and (TERMINAL_AI)

>   **Actionable Item**: Sandbox experiment literate document comparing results. This involves upgrading 
    terminal ai with the improved transcript structure. It will need read and write actions, to filter the 
    new indent structure, where messages are indented.

Let's plot out how I see this going.

>   **Actionable Item**: Model how neovim and terminal ai come together.


### Review Previous Action Items 

**Review Item** Make my TMUX thing sort of automated.

    Can't remember what this was.

**Review Item** Need to note the paths outside of orchestration architect, like the transcripts

    Introduced the *CONFIG* project

**Review Item** Build a specification document to perform certain actions.

    Going poorly, as I have done this many times but it's a pain to find all examples.
    I need to move all related things to sandbox.

>   **Actionable Item**
>   Write a REQUIREMENTS, DESIGN, AND LIT-SPEC for DESIGN Document, with minimal template.
    

**Review Item** Need to make all the lookable things, lookable. So consider how to centralise tags in use, thats use to extract tags, and identify tags. 

    What was I on about? Can't be bothered checking.

**Review Item** Consider creating a collaboration environment between agents, and observe how they tackle a problem. See if the journal idea works.

    A fresher idea was to just compare transcript answers to questions.

>   **Actionable Item**
>   Get some transcripts and provide a comparison of the answers (explore evaluation of agents)

**Review Item** Make sure I finish that agent interaction critic process experiment, which made me make the extraction tool for transcripts.

>   **Actionable Item** 
>   Search for the transcript where I experimented making deepseek use Minsky model of self-reflection.

>   **Actionable Item* 
>   Before finishing design doc, compare deepseeks results, and also find source material to evaluate correctness.


**Review Item** Make sure to make the updates to the jsonl tool used to extract IndexDB transcripts is respect the identity of the lines (i.e. avoid duplication).

**Review Item** Make the bookmark tool do the same thing as the IndexDB.

>   **Actionable Item**
>   Make the Bookmark Tool and DeepSeek Web transcript extractor a OA-NOTE. Consider if extractors are a tool or spec.

**Review Item** Consider how I can manage goals using a symmetric monoidal braid such that goals can have a certain weight, and when a new point of self-organization criticality is reached, other things might be obsolete, or become essential.

    Possibly by using active/inactive such that it has a functor to another active/inactive state.
    Or possibly the fact that a limit of tasks and projects, moved the other part to inactive such that it 
    preserves the preorder of recency as it is placed to the top  (coalgebraiac concept)

**Review Item** Ensure that I can migrate to the new yaml message system earlier, since yaml manipulations still works

    This requires the Abstract Compositional Topology to be clearly explained

**Review Item** Come up with an idea to rewrite Abstract Compositional Topology, in a cleaner way, with heaps of examples to see.

    Could rewrite it with a purpose, let's start with the projects and tasks.

>   **Actionable Item**
>   Have the project and kanbans demonstrate via literate writing Abstract Compositional Topology 


**Review Item** I can compose the D2 project with the Semantic Web Project, and then use the two with the Terminal-AI project. It will be awesome, as I can see a perfected version the the equivalent of deekseek and openai. So maybe I could launch like a document editing session on web that combines with the gitoslave and gitolite interface (or cgit or something, maybe theres a way to extend), but I need to make my system capable of code reviews.

    Not sure.

**Review Item** See if I can use the resources to get an AI to write a Literate spec using the others as an example, and the relevant resources.

    What other?

**Review Item** The Projects should be organised before I create to many.

    Reorganised sort of. 

**Review Item** Ensure the project entries scaffold things so that the first thing is I have to answer, whats aim of the project (aim should be defined in the vocab/terms to mean the present state (the problematic or nonideal state), and the potential state (so it is able to track the goals needed by SWEBOK). The Tasks themselves should also be like a requirement, like having deliverables, and a discussion to say what I want, is cool because I just split things into a different tasks (taking advantage of Minskys ways of thing to solve the different kinds of problems. 

>   **Actionable Item**
>   Make Task to create Specifications for Project Docs.

    
**Review Item** The blog thing, so I can get feedback from LinkedIn, using the semantic web tool to make a resume generator using DGraph and the semantic web. I wonder if I can get OpenAI to be the critic since it has vision, and DeepSeek to do the work cause its competent.

    Scrapped, need to rethink.

**Review Item** A reminder to check if the rust TF-IDF retrieval stuff is a task in the Knowledge Management and Retrieval 

>   **Actionable Item**
>   Generate a clean view of Tasks and Projects with `nvim-orchestration-architect`

>   **Actionable Item** Ensure TF-IDF stuff is in the sandbox


**Review Item** Have a look at Telescope and use it to look at the LSP things, as when an ontology gets started the LSP can use it. 

    Change of plans, going to write a LSP.

>   **Actionable Item**
>   Add an *Idea* for LSP work.

**Review Item** Ensure neovim project is included as a project. Call it something like DevOptimisations.

>   **Actionable Item**
>   Add a max line length indictor in neovim.

**Action Item Review**: Update 'OA Specification: Development Diaries > Retrospective'

>    **Actionable Item*
>    Put this somewhere
    
    «Retrospective Document Specification»
        «Skeleton for Retrospective Activity»
        «Skeleton for Discussion»        
        «Skeleton for Actions»
        «Skeleton for Report on Previous Actions»

    «Retrospective Operations»
        «Create New Retrospective from Skeleton»
        «Locate Previous Retrospective»
        «Import Previous 'Actionable Items' as 'Review Items'»
