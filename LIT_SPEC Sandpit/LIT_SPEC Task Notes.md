# LIT_SPEC TASK NOTES

### **Task Notes LIT_SPEC.008**: Finish the `RETROSPECTIVES.md` Literate Specification

**Created**: 2025-05-10

**Linked Resources**

- [Task Notes LIT_SPEC.008](../../../../sandbox/LIT_SPEC Sandpit/LIT_SPEC Task Notes.md#task-lit-spec-008)

- [Drafts - LIT_SPEC Retrospectives](../../../../sandbox/LIT_SPEC Sandpit/lit-spec-retrospective-drafts/)

- [Retrospectives Literate Specification](../../Retrospectives/RETROSPECTIVES.md)

## **Task Notes LIT_SPEC.006**: Create `DESIGN-001 Literate Specifications`

```sh «bootstrap»
bootstrap="${1:-LIT_SPEC Task Notes.md}"
cat "$bootstrap" | sed -n '/^```sh «bootstrap»/,/^```/p' | sed '1d;$d'
```

## **Task Notes LIT_SPEC.007: Added Prototype Tool to view projects and tasks**

**Summary**

This task involves streamlining the organization of LIT-SPEC projects by moving 'Tasks Notes' to Notes,
renaming and tracking all references to OA-NOTES, and consolidating with the CONFIG-SPEC project.
Additionally, it includes developing a prototype tool for efficiently viewing projects and tasks,
ensuring consistency across Kanban boards, and facilitating easy identification of numeric IDs.

There is also a consideration for adding a "DESIGN-XXX PROJECT"

And renaming the project code to standardize task identifiers. As part of the deliverables,a task template is to be created.

- [CANCELLED] Move 'Tasks Notes' to Notes.

- [MOVE] Find Task and Project Templates

     

- [CANCELLED] Combine project **CONFIG-SPEC** 

- [COMPLETE] Create a prototype tool to quickly view projects, and tasks.

- [MOVE THIS]Use prototype tool to check each Kanban is consistent. At the very least, be able to see the next numeric id easily.

- [LETS GET DESIGN DONE FIRST] Consider adding a "DESIGN-001 PROJECT". 

- [COMPLETE] Rename `LIT_SPEC` project code to `LIT_SPEC` so the tasks can be `TASK-LIT_SPEC.XYZ`

**Deliverables**

```text
[MOVE TO OA_PROJECT] Create Task Template 
```

### **Task Notes LIT_SPEC.004**: Check progress and take inventory

**Created**: 2025-04-09

**Completed**: 2025-04-09

**Description**

[Task Notes LIT_SPEC.004](../../../../sandbox/LIT_SPEC Sandpit/LIT_SPEC Task Notes.md#task-lit-spec-004)
> Prepare the project so that work can be continued later.

**Pause Thoughts**

> there is a **backlog of potential literate capability**

> need to be able to bootstrap a **literate capability** from a specification 

> need for `literate specs` to be **capable of self-actualisation**

>  this is to allows extensions to the specifications to autogenerate the capabilities 

> **leverage emergent literate capability**: *actualise* a literate capability

>   this is done by achieve an emergent capability from the composition of literate resources


**A Good place to resume**

 *Literate Spec:Core* `LIT_SPEC#Core`.

Project Summary
    
> Sub Task **Execute a Literate Specification: Set Environment Variables**:

>   This will allow for environment variables to be executable from the literate specifications  

>   This will enable `«oa project docs from env vars»/Kanban/LIT_SPEC Self-Bootstrap Literate Specifications.md`

**DEV JOURNAL ACTIONS**

> Sub Task **Create `LIT_SPEC Development Journal` Literate Commands** 

> Sub Task **Add `Structure Preserving Composition Operation Primitives` Literate Specification**

- [LIT_SPEC Kanban](LIT_SPEC Self-Bootstrap Literate Specifications.md)

- [CONFIG-SPEC Kanban](CONFIG-SPEC Configurations Literate Spec.md)

