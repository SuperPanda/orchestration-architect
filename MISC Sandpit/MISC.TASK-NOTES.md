# MISC Chores and Improvements Tasks Notes

    **Document Type**: Kanban Notes
    **Creation Date**: 2025-05-05
    **Project Code**: MISC
    **Resource Identifer**: urn:oa:kanban:notes#MISC
    **Linked Resources**: [Kanban: *MISC* Chores and Improvements](./MISC Kanban.md)

## MISC.TASK-001

    **DANGER: THIS WILL BE MOVED, YOU (AS IN I) MUST DECIDE WHERE TO PUT IT BEFORE I GET BACK**

> *Notice** This task will be moved to LIT_SPEC with deliverables being the 
  capability to extract web transcripts.

**Status:** Blocked (reason: refactored tasks requires fixing the terminal ai message processor).

**Deliverable**

- [✗] Techniques for getting deepseek transcripts from IndexedDB. Allow for operations to run on the logs (changed tactic).

- [ ] Copy transcripts using the web interface and create a tool to convert it to the transcripts repository (see work in oa-sandbox-private worktree).


**Steps to Take**

- [✓] Move the literate specification to the `private-oa-sandbox` repo.

- [ ] Finish Configuration Specifications from `LIT_SPEC.CONFIG` (formerly `CONFIG_SPEC`)


**Deliverables** 

- [ ] Import OLD Transcripts and the LESS OLD transcripts
    
    - [ ] Import DeepSeek Web Logs
    
    - [ ] Import OpenAI ChatGPT Logs 
    
    - [ ] Import OpenAI Playground Logs 

## MISC.TASK-002 

**Deliverables** 

- [ ] Import OLD Transcripts and the LESS OLD transcripts
    
    - [ ] Import DeepSeek Web Logs
    
    - [ ] Import OpenAI ChatGPT Logs 
    
    - [ ] Import OpenAI Playground Logs 

## MISC.TASK-003

- [✓] **OA-MISC-000** Added Dev Journal Ideas to Idea Journal

- [ ] **OA-MISC-001** Deal with WIP SUMMARY To The Ideas Section 

    - [ ] Use the diagram models to fill in the SUMMARY wip actually just make the README for the documents there... COPY DIAGRAMS

- [ ] Move oa-prototype repo as subtree for tools... make subtree...

- [ ] Update Rust Monitor (oa-monitor) and make (oa-doc) 

- [ ] Import transcripts

- [ ] Specify sandboxes 

- [ ] Import tasks from  OA-NOTE-19 ... 

- [ ] add notes and tasks

## MISC.TASK-007

### Extract Daily Notes 

```
DAILY_NOTES_PATH="$HOME/Documents/Daily Notes/*.md"
ls "$DAILY_NOTES_PATH"
rg '^#{1,5} ' "$DAILY_NOTES_PATH"
```

Current going to go through notes and fold them and import them.

[**TASK 007 Attached Scratch Space**](./misc-007.task-notes.md)
