# Architectural Views

Adapted from <https://en.wikipedia.org/wiki/Department_of_Defense_Architecture_Framework> as a starting point.

```d2
vars: {
  d2-config: {

    layout-engine: elk

    # Terminal theme code

    theme-id: 300

  }
}
classes: {
    column: {
        label: ""
        grid-columns: 1;
    }
    container: {
        grid-rows: 1;
    }
}
style.fill: transparent;
Viewpoints.column*.class: column 
Viewpoints.class: container;
Viewpoints: {
    column-1: {
        All View: {
            grid-columns: 1;
            Themes;
            Concepts;
            Mission;
            Values;            
        }
    }
    column-2: {
        Data and Information View: {
            grid-columns: 1;
            Conceptual: {
                Strategic;
                Tactical;
                Operational;
                
            }
            Logical: {                              
                grid-columns: 1;
                Requirements;
                Analysis;
                Designs;
                Specifications;
            }
            Physical: {
                Location;
                Formats;
            }
        }
    }
    column-3: {
        External: {
            grid-columns: 1;
            XDG SPEC;
            POSIX SPEC;
            Languge SPEC;
            IEEE RFCs;
            W3C RFCs;
            ISO Standards;
        }
        Internal: {
            grid-columns: 1;
            Templates;
            Vocabulary;
            Semantics;
            Languages;
            Grammars;
        }
    }
    column-4: {
        Capability View: {        
            grid-columns: 3;
            Self-Verification;
            Self-Assembling;
            Self-Organizing;
            Self-Documenting;
            Self-Modifying;            
            Self-Improving;
        }
        Operational View:  {            
            grid-columns: 1;
            grid-rows: 2;        
            Domain: {
                grid-rows: 1;
                Development;
                Deployment;
                Operations;
            }
            Layer: {
                grid-rows: 1;
                Component;
                System;
                Infrastructure;
            }
            Domain -- Layer;
        }
        Services View: { }
        Systems View: { }
    }   
    column-5: {
        Projects View: {
            grid-columns: 1;
            Projects Summary;
            Project Kanban; 
            Tasks;                        
        }
    }
}

```
