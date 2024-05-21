# Terminal AI Notes
## Reactive Store
### Concepts
1. Store is the central state of the different components
2. Stores consist of:
    - Reducers: Takes an Action and supplied objects
                and updates the store
    - Actions: The operations that can be dispatched to
                the store
    - Selectors: Slices that store to only listen to regions of the state
                  that are relevant.
                 Also used to compose different pure functions that
                  allow for eassy modification and maintainence
                 Provides Memoisation via builtin LRU.
    - Action Stream: In bound stream of actions
    - State Change Stream: Stream that reports the action taken,
                            and the before and after state.
## UI
### Concepts
1. NCurses is to take a stream of (y,x, text) that will allow for efficient direct redraws
2. The components from the store will generate a mask and using the offset and dimensions of the
     component
3. The maxyz size will dispatch resize actions to the store
4. The stream will be composed from streams that memoise common operations to generate the update stream.
5. The masks will be overlaid with a mask of the available view port, allowing for components to exist
   in a space that won't cause side effects based on the view port.
6. Clearing the screen will be avoid (unless a refresh is called (need a saga to modify the selector to compute entire update)
7. Components mask should be composed in a way that the region that has been modified can easily trigger related components - idea: store values such that each bit represents a different component. and if the view
naask in the update region has a cell where the highest bit changed, use the memoised operations for the components, to use the offset, and highest bit position, to index to character being updated ( will need define limit and colimits for ensuring proper boundary checking).
8. Functors are used to convert different categories or objects into a text representation, that uses natural transformation to be able to change its representation based on context.


### Output
1. The system must always persist the state as it changes.
2. The system must resume to the exact position when reloaded.
3. The system shall support various schemas based on a specification document.

### Input
1. The keybinds are able to be set to particular actions.
2. Those actions can change.
3. The system keeps a cursor index, that points to elements in the store
4. The structure of navigation like a mindmap to determine whether to go to child or sibling,
    or a anscestors sibling if the parent has no siblings and you press to go down, is achieved
    by applying a topological sort, a depth first or breadth first depending on direction.

### Animations, Motion and ASCII Physics
Vectors, Parameteric Equations and good old linear algebra (even quarternions if crazy), using functors and
morphisms, etc. we will use the demo from the category store, to generate vector graphics in the terminal
and animations of the ascii vector graphs.

## Mindmap
### Concepts
A mind map that takes any item, and make it representable in the 


# Other things I got to fill in
## Schema, Serializationand Deserialization
### Concepts
Serialisation and Deserialsation is govern by schema specifications.
The code is not to assume any structure of the provide specifications.


## Objects
Graph
Text
Files
Program STDOUTs
...

### Concepts
## Abstract Compositional Toplogy
## Knowledge and Language Tools Integration
##  - integrate git tooling to display content
##  - Link to tagging system
##  - Link the meta document system which identifies tags
##    and allows via the tooling to adjust the scope of the tag
##    which allows automatic embedding and change detection in the 
##    generated documentation
##  - Apply the ACT used to work on files, to do layouts and 
##       to interface with the system





