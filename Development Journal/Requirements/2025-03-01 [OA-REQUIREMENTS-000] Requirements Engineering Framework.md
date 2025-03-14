# Web Application Interface
 
 ```oa-document
     
     Doc Type: Notes [urn:oa:semantics:specifications/oa-document/Notes]
     Status: Blocked (Awaiting Completion of Current Tasks) []
     Comments:
       - This document will change from Notes to Requirements upon completion
     Purpose: 
 ```
> ### Current Task
> 
>    - Read SWEBOK and write up [SWEBOK and Requirements Study Notes](urn:oa:resource:oa-document?type=Notes&date=2025-03-01&name=understanding-requirements-according-to-swebok&format=md) and improve the structure of this documented. Complete when it outlines the stages and what morphisms are achieved. Aim to list all the stages of the requirements stage and the 'deliverables' and what its used for and why. Add references. The study notes should be usable. The task is complete when `Development Journal/Notes/2025-03-01-understanding-requirements-according-swebok.md`

>    - Improve the AI task operations and make it return changes one at a time, and use it then go fix this document with AI put development journal notes in Notes/2025-03-01-targetted-ai.md in notes and put it on a simple web application, which will be a quick refresher before designing the next step.


## Requirement Analysis
### Current Problem

1. The combinatorial explosion (though it works), is hard to keep track of all the entities and resources, and map there interactions.
2. Distractions due to too much information. And lack of awareness due to the out of sight, out of mind problem.
3. Slow migrations due to the last leg of the design of the evolving code lifecycle has yet to be properly implemented, which will involve one more large scale rebuild but this time should be the last before it works.

### Proposal
To deal with problem (1), I have processed that we use the strategy of tracing the resources classifications, so for each system will have its own bounded context.
The strategy will be to use semantic web technologies to make a dashboard of the whole system. So starting with the goal of completing the independent collection distribution, and packaging of software systems, I will start by identifying in the domain of `oa-collections`. I will model the `specifications`, `roles`, and the effects each has on the system.

I want to be able to show diagrammatically how functorial structures between `specifications`, `components` and the interaction with the `environment`. 

I want a web app that deals with problem (2), so that semantic web can bring related information together, but using a webapp dashboard will be able to provide a reminder of things that exist.

I will also use the web app as an interface with the system, to provide interactive documentation such that the semantic work around resources, will allow me to make resource resolvers, that can allow semantically mapping to file line ranges, or git commits, or refer to external documentation.

The semantic work and the web app will help deal with tracking the tasks, sincethe project itself ungoes periods to death and rebirth (as intended, only a chaotic driver can control chaotic systems).

It will also give me a place to view transcripts, and flesh out the data mining capabilities. 


The dashboard, will also allow me to generate the self-revealing architecture matrix (well not a matrix, but the indices are preorders, and adding concepts semantically allow you to use the element to derive the coproducts (doomain and hierarchy based on system composition containment). The walks/morphisms that cycle through the different stages of the matrix is the process, and the process will evolve in conjunction with the architecture pseudo-matrix.

The pseudo-matrix will derive the structure of the web app.

With all these semantics, it will be important to generate a proper specification, or model, so displaying specifications... as well making documentation available using weaved resources using linked data.

Most importantly, I will create the semantic task management system, which will be able to make it possible that each cell in the pseudo-matrix has limited interface with higher or lower systems within a domain, and there is consistency with the level of complexity (as things get too complex or overloaded the cell splits) and each cell is able to provide a view into information relevant to that domain x architectural perspective. Not only will this be useful for users and humans, but it will allow the start of the automation framework. With a set of actions and operations that the walk through the different domains of development to be handled by specialised agents, with access to semantically relevant information. Furthermore, adding more data mining capabilities with have a generated effect if taken in the context of the categorical product of data mining tooling and the semantic richness of the resources it can work with.


### Considerations
In order to deal with problem (3) of not finishing a version, well technically it does not need it yet. As finishing the last leg means that I can verify that the `dev` state can extract the irrepresentable `seed` that can build itself. Which involves a lot of cleaning up files that are in seed that kept getting carried over prior to the full design of the model.

But the number (1) priority, is make something look cool but in an extendable way. And since the most important thing is tracking tasks... lets build a minimal semantic interface for tasks tracking.
Priority number (2), Ensure that I don't get bogged down in doing too much, so having things be in a grid (that fits on a screen) and can use transparencies to show whats mapped or not.
Priority number (3), I need to ensure that I follow the matrix. Hence starting at writing the requirements and constraints.
Priority number (4), theres always too much to do, so map the resources used in the system.

Possible Goal (1) - Model the Resource Schema and thoroughly document the `oa-resource:collection`, «@note: I think `oa-semantics` will be used as a resource schema like how things are related, the `oa-resource` refers to resources (abstract or concrete)for example the themes that started this endeavour has played out pretty much expected». By modelling all the resources (or at least the resources for different domains) then it should be easy to identify containment relations and then finding places of high cohesiveness that those that cluster within another system, indicates a possible analysis in to modelling this phenomena I keep seeing but hard to describe.

Possible Goal (2) - I can begin modelling the bootstrap process, and use linked data to model certain concepts. 

Possible Goal (3) - Find all the past gems like the neovim plugins, and things like the motd quote.

Possible Goal (4) - Find all the things that were achieved in the past but are not yet present, in an easy to extend model.

Possible Goal (5) - Be able to work with Conversation Transcripts using Rust (started learning), in conjunction with my specialty, web app development.

Possible Goal (6) - Basically be able to start the meta_document subsystem, and migrate all the document tools so they can be organised and documented accurately.

Challenges - I don't want to maintain a bunch of rust apps. So ideally do not use many dependencies. Make tools and cli simple and small, with the constraint being that it should be able to be implemented in bash and a couple of other basic tools.
- As much as I love angular... nah I better use it, only good things occur when using it. Just keep it simple.

Resources that may be relevant:
(1) Spivak and Fong, Seven Sketches in Compositionality, Chapter on Monoidal Resource Theory
    - 
(2) GraphViz 2015 Manual
(3) JSON-LD specifications

Things that might help...
- Getting a proper Neovim Plugin to format markdown.
- Make it so neovim can open a document path and later resolve things, like leader-ov oa-view to resolve it in a buffer perhaps... or use treesitter.
- Add Requirements, Tasks, Retrospectives to the Development Journal...
- Actually look at Githooks for making sure I get constant updates.


>	@note
	the things that might help should be semantically linkable, since this is the current context of working it might be nice on the dash, possibly with some AI Recommended Steps like an Outline.


Next steps. 
1. Refine the Requirement Steps. I have done the elicitation. Now I need to be able to do requirement tracability, and analysis stuff (Flick through the Guide to SWEBOK). In other words read a book, improve the structure of this document, and make a ttl for it. So I have extracted the semantic information, and then this document can be used to enrich other parts. So having a consistent structure, ideally with industry best practice so it doesnt have to be worked on. 

>	*Task*
	Restructure the requirements Tasks.md found in oa-resources:git-branch:0.8.0-document@/srv/git/orchestration-architect.git - Completion of Task Ends with Requirements being added to documentation under Requirements/2025-03-01-«SLUG WITH WORDS THAT HIGHLIGHT WHATS REQUIRED» While I'm there make it so that I can store concepts. 

>	**task**
>
>	make it so that I can call AI to apply certain tasks to a page... and generate the slug 

>	@idea
	use an critic AI to check that it was implemented correctly and its confidence, use the critic AI to store common issues per document type 

>	@idea
	make treesitter grammer to highlight tags

2. Then next step is design. (@task generate software requirement specifications using information from requirements doc `Development Journal/Requirements/2025-03-01*.md and add the tasks that need to be done and mock a semantic resource for the requirements and design docs, so that I can hand iterate it. So task is completed with I have a prototype of the web app that is able to show the requirements and designs and link semantically. «@idea

3. Construction. 

>	@task
	Task completed upon impressing someone else and get it checked off as it seems cool enough, followed by using the artifacts or new view to generate the resources in sufficient detail that all the collections are list and semantically tagged, and the `meta` collection components are mapped out at a high level (user guide level with the subsystems for template and role and playbooks are scaffolded.) 

>	@task
	Create a design doc for the urn:oa scheme and implement a resolver to view the resources described.

9. [Optional  Side Project] Make all the Transcripts in one place and apply the TF-IDF tooling and see if I can find a clustering based on similarities based on possibly a stocastic sampling and mapping the similiarities. Ahh how good it is to have high performance languages like Julia and Rust. I should find a way to put Julia Notebooks on the App. 


## Appendix: Current AI Instructions
I need to waffle, so can you split the parts that are less relevant in a block like:
```
    > **Side Note**
    > ....
```
Can you represent definitions of goals or priorities, or other thing that should be used to refer to different sections to be like:
```
    > **Goal 1**
    >
```
And identify certain topics discussed and add them as hash tags at the start of the section under the relevant heading such that if i grep for headings and look at the next line, all the hash tags should be there. Things that should be extractable like anything that has the two element sequence: `«` and `@`; and has a `»` afterwards. Look at the existing ones, and convert any thing that attempts a similar things or 
