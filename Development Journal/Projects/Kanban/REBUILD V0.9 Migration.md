# V0.9 Migration

    **Document Type**: Kanban 
    **Creation Date**: 2025-04-05
    **Project Code**: REBUILD
    **Resource Identifer**: urn:oa:docs:kanban#REBUILD

## Active Tasks

## Inactive Tasks 

### **Task 001**: Write a Literate Specification to define Bootstrap Process that captures the very first limit to colimit.

**Description**

Notes should be made from the current assembly process using a diff of the changing filesystem as it runs the bootstrap process.

The literate specification workflow should start with nothing. By identifying the self-assembly (co)limits, the parts where the *bootstrap playbook* completes a new functional change.

The literate document should also be able to generate a D2 representation. So each change can be represented by a diff in the `filesystem tree diff <-> D2 Diagram <-> Bootstrap Playbook`

The content in `OA-NOTE-019` contains some snippets and the **new specifications structure** in particular how `roles.yml` for this is now split into `base.roles.yml` and `meta.roles.yml`. The `worktree` will need to be setup from `OA-NOTE-002`.

**Possible Ideas to aid in faster feedback**

- Take advantage of the nspawn container to execute the operations. 

- We should be able to make it use the proof of concepts of in ram ephemeral btrfs snapshots between each successful state.

- And research if mkosi could be useful for setting up isolated environment to run it.

**Related Resources**

`OA-NOTE-002` Work Tree Process 

`OA-NOTE-019` Changes that need to be made.

**Deliverables**

- [ ] The documentation of the processes is captured and will be used to fully document the mappings between the growing diagram, file system changes, and the relevant playbook section. 
- [ ] A literate specification of the self-assembly process
- [ ] A list changed resources, and created resources


**Notes**

The self-assembly process will be that chunk of operatiosn defines each (co)limit to be an operation the achieves a predicted difference (ensuring that each step performs the expected action (arrow), and results in the same endpoint (object), since any dispariy will show there is something there is a error that represents a problem with the abstract concept not the code. The animation of the changes are for presentation and debugging purposes.

**Status**: Blocked (reason: awaiting the release of `oa-monitor` and `oa-tree-diff` tools).

### **Task 002**: Identify all changes and generate a documentation system for it.

### **Task 003**: Using the information above do a timeboxed attempt at using AI agents to complete 

**Description**

Attempt to use AI that is designed to use keep a journal idea as discussed in the transcripts that will be availble as soon as I finish the deepseek AI transcript parser spec.







## Completed Tasks
