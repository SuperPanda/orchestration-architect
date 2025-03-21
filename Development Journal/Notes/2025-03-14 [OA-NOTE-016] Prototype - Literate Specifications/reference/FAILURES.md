# Failures

## Using AI For Useful Input

---- AN EXAMPLE USING THE PREVIOUS PROMPT ------
```
> [!prompt] This is the prompt the feedback was for.

> Context: You are helping me structure this consistently.
> Objective: You are to demonstrate you know what to do.
> Instructions: You are agoing to read the document. And provide what you will change and why.

> Your responses, will include a sample fragment for each change class you are consider.
> And it will provide a succinct fragment of the relevant contexts. and what it will change.
> for changes that involve big structure changes, or outlines, refer to how changes chunks would be changed..
> so that it would be like 'Under [#Coomposable ...], In order to achieve ... currently structured as «this section»,«that section»...  I will do modification at '--SOMETHING--' as it will be .... 
> and you can define for each section, what you are to change and why, so for example in tasks checklist you be deciding which to turn into tasks and not. define what you are going to do declaratively. you will respond as 
-----------------------------------------

> [!proposal] TITLE OF PROPOSED
> ....
> ...
> Status: Reopened (Reason: This needs to be integrated into a comprehensive response)
```
-----------PROVIDE CONTENT HERE--------

-------------------------------------
You need to refine prompts that perform each tasks, so the prompts you design for literate spec are made to perform narrow tasks

Use the following example to make a better prompt template and system message. Add the types of things you would wnat to see by writintg prompts for everything after reorganising everything.


```
bash -c cat ./README.md ./README.md.proposal | wl-copy
```

You Should Define Tasks as being define as having a vocabulary 
as In Progress, No Status, Completed, Backlog. Assume this cannot be varied,
as instead of adding more attributes, okay add a Discarded pile. Focus on  definiing the initial morphism, what makes it initial, what happens when each thing occurs, and to create a new task, define instead of adding a test step, it would just add test task, and attach itself.

