# Prototyping Visualisations for Auto-Generation

## Ideas

Use the oa-resource-resolution engine to be able to take a semantic resource and display it.
Need to make it output to a `d2` protocol.

## Notes 

### Identified domains

#### Repository

The goal is to be able to deconstruct each system perspective.

    - Infrastructure - User, System, Authoriative, Mirrors, etc.

    - Branches: Seed, Pristine, Develop...

    - Worktrees: The mapping of branches to filesystems as worktrees.

    - Artifact generations: How the different branches are composed to create releases and Documents




## Thoughts

Needs to be able to generate visualisations on demand about the system.

Ideally there would be many ways to represent the components and systems,
however the context will change what needs to be viewed.

For example all the meta role components could be viewed from the self-assembly perspective.
This would be more relevant to the 'seed' branch for the bootstrap mechanism.

It would be a different view from a resource view. 


**Meta Components**:

meta_role generates parameters for other roles to use, as it determines the parameters that other meta components will need. 

The meta_template perspective would see it from the view of how each component is composed. As it defines the fragments and template skeletons which are used by the other meta components to interface with each other.

The meta_playbook would care about what roles it can interact with.

Also schema are derived from the specifications provided meta_role,

**Repository**:

The structure of the repository is important as it defines how the system evolves. 

**Documents**:

How is the documentation structured and link depends on the development process.





