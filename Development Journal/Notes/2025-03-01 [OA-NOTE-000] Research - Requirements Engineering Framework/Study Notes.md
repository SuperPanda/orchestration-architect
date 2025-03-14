I need to recreate the '2025-02-28 [Requirement] REQ-20250228-A-000'in 'Development Requirements/Requirements' that uses `2025-02-28-DOC-REQ-20250228-A-000.md`

Mext step is to make a tool that generates the file above. So I need the Unique Identifer schema for this file, and the outline. Or... 



```
2025-03-01 [Elicitation] Invisible System Dilemma: Hard to See the World when Staring at Atoms (Web Application Interface and Semantic Resource Modelling).md
2025-03-02 [Analysis] Mapping out Requirements Process.md:11:> *Unique Identifier:* DOC-NOTES-20250302-A-000
2025-03-01 [Analysis] Understanding SWEBOK Requirements Activities.md:11:> *Unique Identifier:* DOC-NOTES-20250301-A-000
```

I make a git commit and push then I analysis every goal+problem->need constraint, that the other constraint of requirements achieve needs listed in the document. And experiment with the script.

Not sure the order I should do it.

Lets just ensure the scaffold is documented. 
Remember the Elicitation document hasn't been structured to match the requirements.

It seems it is missing goals and that I noted the next task is AI. But I think I should manually make the scheme fit. Then I will make the specification without AI.
Then I will make a oa-document tool that generates the needed things. 
Need to make sure generated documents are no earlier than the Requirement document (fix i need to do) as it will could mess up searching. So lets get it right now.
It will need to be able to:

Also add a markdown linter to the workflow.

probably need to workshop this.


Ensure the specifications can represent this information when go to write the proper spec. So this will be done after I write the requirements. Maybe think about using the ontology to do this... perhaps its best that I don't do this. hmm...
`oa-document Note init --slug=...`
`oa-document Requirement init`... which add requirement and the elicitation and analysis document in a draft state. 
`oa-document Requirement update [--slug=...] [--ai]`... updates slug the ai will provide feedback and generate a .new file to merge, and record the diff and feedback for later improvements, for each of the files
... `... Requirement generate-fix ...` 
... `oa-document Requirement apply-fix ...
... `oa-document Requirement update-slug [--ai|--slug=...]
... this will be used to ensure the meta data stays in sync... until i integrate oa-document into the oa-meta subsystem. Need commands to automatically populate.
... `oa-document Requirement create-revision [elicitation|analysis]` Thats what git is for 
... `oa-document Requirement revert-revision` Thats what git is for move to backlog.
... `oa-document Requirement history]` Thats a git thing
`oa-document Requirement summary [--only=..[goals,problems,needs,requirements] [--all [--since=""][--before=""]]`
`oa-document Requirement list [--all] [--since=""][--before]]`
`oa-document Requirement [complete|discard|restore] (Elicitation) [--quiet] [--since=...] [--before=..]` quiet just fails the operation instead of prompts if there are multiple ... maybe just modle this.
>   Well lets at least make it generate a Requirement and the linked metadata, perhaps I will make it so you cant have multiple subcompoonents.

So lets make it the requirements docs doesn't map to it persay, but they map to it in a one way correspondence (at least in the meta data), then when the Requirements need to be populated i can just say populate Requirements from requirements. Or it can just be used to refine the fragments, so the Elicitation populates the goals, needs, etc. so once analysis starts, I can added them with Analysis and discard others, and then the specification will state the all the goals,needs,

Actually... You know what I need to consider the semantic web stuff... maybe screw it, just write the SLUG at the beginning, put something to map the Requirements in a separate file so its like a resource mapping. How about I deal with it when its time

ACTUALLY I WILL JUST START MAKING THE THING NOW BASED ON CURRENT REQUIREMENTS!
ITS SIMPLE PUT REQUIREMENTS Stuff In Requirements... and keep the slugs in sync infact it should just be done at initialisation time.
make the assets judt be the date-assets... because i will only attach things where its needed anyway...
