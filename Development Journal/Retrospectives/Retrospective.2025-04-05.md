# Retrospective Journal

## *_2025-04-05_*

> This activity is done first to ensure participants have the week fresh in mind. 
> Participants independently simulantenous spend time writing thoughts on the previous weeks experiences (no discussion), and adding the idea under the headings: 'positive :)', 'neutral :|' or 'negative :('.
> This activity ensures that each person can get their ideas down, and during discussions, others can pay more attention, due to not thinking of what to say next.
> Refer to a management textbook for more information.


### **Positive :)**

- Holy crap splitting different things into Projects, and having a single Kanban for Project; the best idea ever. I think the Project and Tasks where I can control the size of each project, since a project is meant to achieve an overall goal, but there are parts where I can use them, and so I can have big ambitions, but once the task from the project is useful, I can move to the task that was relying on it.

- Starting to see some alignment 

- Definitely need to ensure that my tmux window for Project Management, Configurations and Notes being in the Overlay window with what im working on a Desktop underneath is so good 

- Rust is great 

- DeepSeek your too much. I got credit but haven't needed to use it yet. 

- Oh! I did a good job making a quick way to extract IndexedDB Local Storage. I like the way deepseek structures there api schemas (it is much better than OpenAIs)

- I found a good example of semantic web application that I will look into `ESCO` which is the EU Skills and Occupations Dataset. I am going to write a blog about using it to write a resume. I will even do a study, where I compare my old resume to the one that is built using the same data source resume scanners use. I can even make the document an example of my literate specification so itself assembles.

- I like the NotebookLLM.google as it is very critical at novel ideas, but when I work through the problem and supply the references, and demonstrate hey, it actually does meet it from any frame of reference, to have to earn the compliments is nice.


### **Neutral :|**

- I noticed that when discussing things with DeepSeek about designs to implement these patterns as like 'emotion machine' but not using the common understanding of it, but the structures that can map to different domains that allow a society of agents to use a journal to provide context, and thing that can note when no progress is being made that it shift resources, that it randomly in its thoughts saying, I need to make it clear that this is not AGI this is a <whatever i asked it to do>, but AGI was never brought up, like it was programmed to not work on AGI. 

- Knowledge Management and Retrieval needs to be put together.

- I think I might prefer using litearte specification to rust to generate the tooling to modify things in the system. As for one, it literally uses a semantic web, so I can easily do feature toggling, by swapping a single line, and the macro resolver just magically works.

- I just noticed something and instantly forgot it when I finished, 'I just noticed'.

- There is no good mobile d2lang renderer. I will make one. I will practice putting things in WASM. Release a free version, then use the base to make a tool where I can implement the learnings and use the base of the free version to provide a on the go portable architecture solution. Probably could be monetised once I figure out the semantic hypergraph enrichment with the resource resolution system with protocol translation bridge.

- I fixed TerminalAI

- Might put aside the Transcript Topic System using different files for now. I might make the files after my extraction of IndexedDB store as a very simple YAML. Since the issue I had with the current transcription storage method, where there are certain things (like adding a transcript to a message), can break the transcript. And I was previously thinking of adjust my system to overcome the issue using like an unusual character to pad that would be invisible, so the transcripts is still readable. 

- Rust is slow to develop with, but... my literate specification experiments, did show that literate programming allowed me to easily generate a weave/code file, and when I wanted to experiment what it was like to use warp vs axum, the literate tooling I made it extremely simple to just pull in everything, and then swap out the relevant bit, and then regenerate the system the tangle. Much cool, also good design for AI.

- Got to learn Go to package some wasm in your mobile and pwa.

- I had an interesting session with DeepSeek using Marvin Minsky's emotion machine to simulate goals, and having it keep a journal, etc. 

- I should look at llama.

- I will be focusing on building the tooling for the visualisation.

### **Negative :(**

- I don't know if I want to waste my time with svelte, maybe go work with a company for a bit that uses svelte and see how it is.

- Fuck OpenAI, fucking 6 requests being 30$. It only have a good response once (the first time), I feel as if this is an AI scheme the way that happened to try and make up there money.

- Very disappointed with rate of progress 

- Annoying not having scaffolding yet



## Discussion

> Discuss retrospective activity response and identify actionable items

I need to start making the specs for operations to scaffold the documents. I also want safety with like a btrfs overlay or something. 

I need to get a way to make these documents enrich a semantic web, as the idea for the AI agents to do one small task, which can review my journals, can also review theres. I'm going to need to set up a demonstration soon. But all this stuff has been captured by my new strategy. Instead of writing in Notes, I am at the project view, and if I need to do something else as it would make this faster, I should do that first.

I want to see how things are changing. I have timestamps of all the notes. Oh! I remember I need to put the cinema tools in the repo.

The project/tasks structure has made some much different, because the information overload was real, but reading Minsky (2008) and coming across the different kinds of problems and solutions, was the solution to too much information. And getting stuck or frustrated or distracted, allow me to simplify tasks or just create a new one, as generally the tasks are added slowly, and so when a problem arrives that means things go slower, I literally have a set of solutions I will need to share (such as a good idea to direct the large language model to access the resources with the goal of having the information fresh so the abstract nature or the patterns I observed are more easily communicated when the information is processed. Because the way people can communicate is that the structure in one persons mind is similar, but bot to do with the brain, the abstract functorial spooky sort of pattern recognition, hurts my head sometimes these things. But just need to keep getting good.


>   _**Actionable**_
    Make my TMUX thing sort of automated.

>   _**Actionable**_
    Need to note the paths outside of orchestration architect, like the transcripts

>   _**Actionable**_ 
    Build a specification document to perform certain actions.

>   _**Actionable**_ 
    Need to make all the lookable things, lookable. So consider how to centralise tags in use, thats use to extract tags, and identify tags. 

>   _**Actionable**_ 
    Consider creating a collaboration environment between agents, and observe how they tackle a problem. See if the journal idea works.

>   _**Actionable**_ 
    Make sure I finish that agent interaction critic process experiment, which made me make the extraction tool for transcripts.

>   _**Actionable**_ 
    Make sure to make the updates to the jsonl tool used to extract IndexDB transcripts is respect the identity of the lines (i.e. avoid duplication).

>   _**Actionable**_ 
    Make the bookmark tool do the same thing as the IndexDB.

>   _**Actionable**_ 
    Consider how I can manage goals using a symmetric monoidal braid such that goals can have a certain weight, and when a new point of self-organization criticality is reached, other things might be obsolete, or become essential.

>   _**Actionable**_ 
    Ensure that I can migrate to the new yaml message system earlier, since yaml manipulations still work.

>   _**Actionable**_ 
    Come up with an idea to rewrite Abstract Compositional Topology, in a cleaner way, with heaps of examples to see.

>   _**Actionable**_ 
    I can compose the D2 project with the Semantic Web Project, and then use the two with the Terminal-AI project. It will be awesome, as I can see a perfected version the the equivalent of deekseek and openai. So maybe I could launch like a document editing session on web that combines with the gitoslave and gitolite interface (or cgit or something, maybe theres a way to extend), but I need to make my system capable of code reviews.

>   _**Actionable**_ 
    See if I can use the resources to get an AI to write a Literate spec using the others as an example, and the relevant resources.

>   _**Actionable**_ 
    The Projects should be organised before I create to many.

>   _**Actionable**_ 
    Ensure the project entries scaffold things so that the first thing is I have to answer, whats aim of the project (aim should be defined in the vocab/terms to mean the present state (the problematic or nonideal state), and the potential state (so it is able to track the goals needed by SWEBOK). The Tasks themselves should also be like a requirement, like having deliverables, and a discussion to say what I want, is cool because I just split things into a different tasks (taking advantage of Minskys ways of thing to solve the different kinds of problems. 

## Review: Updates on Previous Actionable Items [2025-02-14]


### Action Item Review: Create a visual example of the concepts in the Literate Programming Specification.

### Action Item Review: Implement the TF-IDF retrieval tool in rust.

>   _**Actionable**_ 
    The blog thing, so I can get feedback from LinkedIn, using the semantic web tool to make a resume generator using DGraph and the semantic web. I wonder if I can get OpenAI to be the critic since it has vision, and DeepSeek to do the work cause its competent.

>   _**Actionable**_
    A reminded to check if the rust TF-IDF retrieval stuff is a task in the Knowledge Management and Retrieval 

>   _**Actionable**_ 
    Have a look at Telescope and use it to look at the LSP things, as when an ontology gets started the LSP can use it. 

>   _**Actionable**_ 
    Ensure neovim project is included as a project. Call it something like DevOptimisations.


### Action Item Review: Explore subtree clustering operations in a notebook

I still want to track this.

>   _**Actionable**_
    Add subtree clustering operations in a notebook (Knowledge Management and Retrieval) Project



### Action Item Review: Ensure the term 'Literate Programming' is used instead of 'Literate Document' in the Specification

Yeah, well I'm redoing it, and its Literate Specifications.

### Action Item Review: The concept of the week is 'Amortised Analysis'

Okay I completely forgot what that was, lets look it up again. I knew what that was, but seeing the definition reminded me of the interaction I had that made me put this there. That's nice.

### Action Item Review**: Create the 2025-02-07.md retrospective.

Yep did it just then.
     
**Action Item Review**: Ensure the document mirroring is currently active.

Whatever this was is no good.

**Action Item Review**: Update 'OA Specification: Development Diaries > Retrospective'
>    _**Actionable**_
    Put this somewhere
    
    «Retrospective Document Specification»
        «Skeleton for Retrospective Activity»
        «Skeleton for Discussion»        
        «Skeleton for Actions»
        «Skeleton for Report on Previous Actions»



---

## Execute Document

Run the following command on the file to see all the action items.

```bash
tail -n2 *2025-04-05.md  | head -n 1 | sh
```

which will call the following:

```bash
OA_RETROSPECTIVES_PATH="$HOME/repos/orchestration-architect/documentation/Development Journal/Retrospectives"
grep -P "^>\W{1,8}\_\*\*Actionable\*\*\_" --after=1 "$OA_RETROSPECTIVES_PATH/OA-RETROSPECTIVE-002 2025-04-05.md"
```
