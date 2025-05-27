# Terminal AI Ideas

## Problem Statement

    ... MANAGING CONTEXT ...

    ... INFORMATION OVERLOAD ...

    ... DIFFERENT MODELS ARE GOOD FOR DIFFERENT THINGS ...

    ... LEARNING WORKS BY COMPOSING RESOURCES THAT MINIMISES THAT 
        THE CURRENT STATE AND THE FUTURE STATE ...

    ... KNOWLEDGE IS OBTAINED BY LINKING IT WITH OTHER KNOWLEDGE ...

    ... THE MIND IS VIEWED AS DIFFERENT DUMB AGENTS WORKING TO 
        ACHIEVE INTELLIGENT-ADJACENT BEHAVIOUR ...

    ... TO BE ABLE TO MANAGE DIFFERENT CONTEXT TO ADDRESS CHALLENGES
        WE NEED TO BE ABLE TO APPLY DIFFERENT WAYS OF THINKING 
        DEPENDING ON THE PROBLEMS THAT ARE FACED...

    ... WAYS OF THINKING ARE RESOURCES 
          - INFORMATION OVERLOAD: BREAK IT DOWN 
    
    ... WE NEED TO BE ABLE TO ADD RESOURCES TO SOLVE 
        SIMPLE PROBLEMS THAT CAN BE COMPOSED 

    ... DIFFERENT PROBLEMS CAN BE ADDRESSED USING K-LINES 
        A SET OF RESOURCES THAT ALLOW CALLS UPON A SET 
        OF RESOURCES THAT HAVE BEEN HELPFUL IN THE PAST.

    ... THIS LITERATE APPROACH TO DEVELOPING AND EVALUATING ITSELF
        BOUNDING THE PROBLEM AND SOLUTION AND VERIFICATION
        TO A SINGLE RESOURCE. AND THE RESOURCE IS ABLE TO GENERATE 
        VARIATIONS. THIS ALLOWS FOR COMPOSITION OF RESOURCES (AGENTS)
        THAT CAN BE COMPOSED TO ACHIEVE A HIGHER ORDER GOAL.
        THE RESOURCES CAN CHANGE DEPENDING ON THE PERSPECTIVE,
        ALLOWING THE DESIGN OF A BRAIDED SYMMETRIC MONOIDAL CATEGORY.

    ...THIS WILL ALLOW FOR THE AGENTS TO COLLECTIVELY 
       SELF-REFLECT, IN THAT IT REFLECTS ON HOW IT REFLECTS. 

## Requirements 

## Capability DESIGNS

**CANDIDATE IDEA** [IDEA DOCUMENTS](../../documentation/Development Journal/Ideas/IDEA-XXX TERMINAL AI.md)

###  Live of Display Last Message 

This design allows for traversal of the messages by simply having a tool 
sending the relevant section of the transcript to that file.

Issues seem to be with navigating the output within `bat` or other inactive 
displays, but this can be addressed by using the terminal or multiplexers `tmux` 
scroll capabilities.  

### COMMAND STRUCTURE

```literate 
cat | «clipboard copy»; «set message variable»
```

```literate «set message variable»
«set message variable»; «terminal ai» -- «message variable» | tee «path to last message»
```

This should be changed to `$XDG_STATE_HOME/terminal-ai/last_message-default` DIRECTORY.
Or the path should be configured in `$XDG_HOME_CONFIG/terminal-ai/...`, such that it can be overridden
by with Environment Variables.

```sh «path to last message»
"/tmp/last_message"
```

```sh «configured path to display message»
"${TAI_DISPLAY_MESSAGE_BUFFER:-1}"
```


```sh «message variable»
"$message"
```
### FISH Shell

See [TOOLS README](../../tools/README.md)


```fish «set message variable for fish»
set message "$(«clipboard-paste»)"
```

```sh «set message variable»
message="$(«clipboard-paste»)"
```

```nvim  
:'<,'>.w !cat | wl-copy; set message "$(wl-paste)"; terminal-ai -- "$message" | tee "/tmp/last_message"
```

Should make command  to pipe DATA to INSTRUCTIONS tools 

```fish 
function process_data -a instructions value
    echo "$instructions"
    echo "$value"
end 

function process_data_2 -a instruction 
    cat | wl-copy 
    set -f instructions "$instruction"
    set -f message "$(wl-paste)"
    
# maybe there is a way to make it easy to make more instructions 
# like simple agents like "IMPROVE CODE" "REVIEW"

echo "hi" | cat | wl-copy | process_data "read this" (wl-paste)
```

```sh
echo "/tmp/last_message" | entr -pc bat /tmp/last_message
```


### Fixing the Transcript in Transcript Problem.


### Agent Specification: Support Evaluation Using A Literate Document

**COMBINES THE LITERATE SPECIFICATION AND TERMINAL AI**

Tags: #Minsky #Resourcefulness

Whats the point? It provides a single document that can be revised, 
documented, and evaluated; as it provides a way to develop a resource, and 
the problem it was trying to solve in a single document. As pain points 
are discovered, it can be added alongside a description of why it was added.


**WITH THE GOAL OF USING LITERATE WRITING TO ENSURE THE STRUCTURE CAN 
ALLOW FOR MORE PROVIDERS**



