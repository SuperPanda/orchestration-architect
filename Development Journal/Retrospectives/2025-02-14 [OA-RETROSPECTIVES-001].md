# Retrospective Journal

## *_2025-02-14_*

> This activity is done first to ensure participants have the week fresh in mind. 
> Participants independently simulantenous spend time writing thoughts on the previous weeks experiences (no discussion), and adding the idea under the headings: 'positive :)', 'neutral :|' or 'negative :('.
> This activity ensures that each person can get their ideas down, and during discussions, others can pay more attention, due to not thinking of what to say next.
> Refer to a management textbook for more information.


### **Positive :)**

- Built a tool to find documents using TF-IDF and using it with rg to find files and show the context.
- Found Julia came naturally to me when using dataframes and applying maps, etc.
- Working on the Literate Document and using concepts
    realised that instead of doing headings for each section,
    I write the abstract structures influenced
    from category theory, and then it can be reused when
    the abstract structure is used in a different context.

### **Neutral :|**

- Realised that the Literate Document Spec will take about the next week.
- Noticed:
      Meta is too casual
      DeepSeek is too formal
      ChatGPT is good at getting me fed up with AIs that 
        I just research it myself and discover things

- I accidently found a way to extract from transcripts
    that make things seem AI content annoying.

### **Negative :(**

- Julia pain to get working due to stack-exec bit bug.
    But in the end worth it for what it achieved.

---

## Discussion



Put placeholder that basically says:

> Discuss retrospective activity response and identify actionable items

In reality we can write what we want, but we need to add action items.

There is no way AI can determine Action Items from our chaotic discussions.

Explore making a parody ad, with a magazine containing videos playing on it, to introduce a retrospective literate document, that gets the previous retrospective document and engages with the audience, but represent it as a magazine playing a video. And say its not false advertising, its isomorphic. Post-modern marketing.  

>   _**Actionable**_
	Create a visual example of the concepts in the Literate Programming Specification.
-


Since Julia has trouble with reliability, but fast to do exploratory activities, make it so Julia is used to explore, and implement in rust. TF-IDF tool. Focus on clustering directories based on the similarity of the subdirectories to make it so I can have a better picture of projects evolution.
	 
>   _**Actionable**_
    Implement the TF-IDF retrieval tool in rust.
-
>   _**Actionable**_
	Explore subtree clustering operations in a notebook
-


Change 'Literate Document Specification' title to 'Literate Programming Specification' 

>   _**Actionable**_
    Ensure the term 'Literate Programming' is used instead of 'Literate Document' in the Specification
-

Continue Work on the 'Literate Document Specification' as getting it correct to begin with will lead to less time spent (amotization). But deadline is the end of the week for a executable outcome.

Spend a day writing with the new abstract notation, after one day, try writing larger chunks (lower quality writing), and if on third day not done (write the script to process literate documents), 

Experiment with variable quality, and if it leads to any problems.

Word of the week: 'Amortisation'


>   _**Actionable**_
    The concept of the week is 'Amortised Analysis'
-

Didn't finish the retroactive spec. Look up Process Modelling for next week.

Probably good idea to get last weeks tasks and put them in 2025-02-07.md
and get the non-public retrospective content removedfrom the public specification.


>   _**Actionable**_
    Create the 2025-02-07.md retrospective.
-

Probably should back up non cloud documents.

>   _**Actionable**_
    Ensure the document mirroring is currently active.
-

---

## Review: Updates on Previous Actions [2025-02-07]

### Update on *Try Get DeepSeek AI to Finish the Specification*

Couldn't be bothered. Must not be the right time.

Want to use literate document to define retrospective.

This will allow for the previous retrospective data 
 to be added to the document.

I envision the document facilitating the process 
 as facilitating the stages of the retrospective.

>    _**Action Item**_
    Update 'OA Specification: Development Diaries > Retrospective'
-    
        «Retrospective Document Specification»
            «Skeleton for Retrospective Activity»
            «Skeleton for Discussion»        
            «Skeleton for Actions»
            «Skeleton for Report on Previous Actions»



### **Consider Building Design Rubrics**

Nope.

### **Build Retrospective Process**

Status: COMPLETE

Did it by writing this document. Already added.

### **Build Task Management Process**

Status: INCOMPLETE

Priorites were elsewhere.

>   _**Actionable**_
    Use TF-IDF Tool to retrieve discussions and designs of
    task management system.
-

### **Explore Task Management**

Basically the same thing as above, focus is on small things.


>   _**Actionable**_
	Update 'OA Specification: Retrospective Activity'
-

	Action items are from the most recent retrospective
	past action items expire every retrospective unless redeclared

--

### **Focus on Literate Document to Design Workspace Rebuild**

Status: WIP

Found that 'literate programming' leads to a lot of insights and allows for complex things to be build. However, it seems that it can lead you down rabbit holes.
	
>   _**Actionable**_
	Use task scope for work on 'OA Specification: Literate programming'
-

Use existing concepts section to:

1. build a reference implementation of weave and tangle operations such that:
			- weave generates an updated reference implementation
			- tangle appends it to the end of the specification
		
	the concatenated reference implenmentation, generates the references implementation from the weave. The tangle generates the script for it."

Lastly, go through the previous week retrospective action items,
that were not discussed. This is done last to allow fresh ideas
to be compared to ones in the week before.

>   _**Actionable**_
    Deal with the Continuous Improvement :: Process documents.
-
>    **Notes**:
    Probably same, but need to make the source this was copied from under continuous improvement in the sandbox, and do the following: 
    
    Use the rationale to enrich the specification.
    
    Use the document, to write the previous retrospective.


---
```TODO: MOVE THIS FILE OUT OF HERE```

## *_2025-02-07_*

> The following is last weeks retrospective activity for reference. Not usually included, but to rebuild the first retrospective.


```START OF FILE: 2025-02-07.md```

### **POSITIVE**

    - Learnt a new programming language (rust)
    
    - Devised a way to easily build self-hosted app server with
    websocket
    
    - DeepSeek is amazing for learning through its reasoning.

### **NEUTRAL**

    - Initiated Continuous Quality Management
    
    - Began Literate Programming

### **NEGATIVE**

    - Need to restore my git workspace after removing items
        
    - Need better balance.
        
    - Need better managment of everything.
        
    - OpenAI LLM is not useful and wastes time



```END OF FILE: 2025-02-07.md```

---

## Execute Document

Run the following command on the file to see all the action items.

```bash
tail -n2 Developmnet_Journal.md  | head -n 1 | sh
```

which will call the following:

```bash
grep -P "^>\W{1,8}\_\*\*Actionable\*\*\_" --after=1 $HOME/Documents/Orchestration\ Architect/Retrospectives/2025-02-14.md
```
