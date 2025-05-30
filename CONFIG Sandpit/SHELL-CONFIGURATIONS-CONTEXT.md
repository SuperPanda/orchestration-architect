# UPDATE SHELL CONFIG ON CHANGE 

```sh «update fish shell config on change»
echo "./shell-configurations/orchestration-architect.fish" | entr fish "oa-load-environment.fish"
```


THIS IS CORE (THE SHELL SETUP), AS IT WILL BE USEFUL TO HAVE THE LITERATE SPEC THAT 
CAN GENERATE EVERYTHING THAT IS NEEDED, SUCH THAT THE INITIAL SPEC TO REFERENCE IMPLEMENTATION 
CAN BE USED IN THE SELF-ASSEMBLY DURING BOOTSTRAP, BY HAVING IT IN THE SEED, I THINK I NEED 
TO CONSIDER THAT IN THE CONTEXT. SO GO DO THE D2 THING AND CMD RUN SETUP AND I CAN WORK FROM THERE.

NEED TO MAKE SURE THAT THE XDG_SPECIFICATION ARE ADDRESSED, 
AND TO HAVE THE STUFF BE DEFINED AS WHERE IT WOULD PUT EVERYTHING 

...i need to finish the ARCHITECTURE BOOK D2 PREPROCESSOR, AS I HAVE ALL THE TOOLS 
AND SETUP ALREADY AND THE DIAGRAMS WHICH I CAN PROVIDE FOR CONTEXT..
AND THE CMDRUN PREPROCESS NEEDS TO BE ABLE TO USE THE SPECS,
TO POPULATE THE AUTOMATION OF THE CHECKLISTS....

NEED TO GATHER ALL THE ARCHITECTURAL CONTEXT FOR THE ARCHITECTURE DOC, 
THE ARCHITECTURE PATTERNS ENSURE THAT EACH PATTERN NATURALLY ALLOWS EACH STEP TO FLOW ...
ALL THE REQUIREMENTS FOR THE CONFIGURATION TO BE GATHERED TO BE PUT IN REQUIREMENTS-CONFIGURATION-SOME-CONFIG-THING
THE DESIGN SHOULD ADDRESS THE PROBLEM STATEMENT, THE ANALYSIS IN REGARDS TO THE REQUIREMENTS SO 
REQUIREMENTS CAN BE ADDRESSED INCREMENTALLY BY THE DESIGN ALLOWING FOR AS NEEDED IMPLEMENTATION 
BASED ON MY IMMEDIATE REQUIREMENTS AND ALIGNS WITH ARCHITECTURAL PATTERNS BASED ON UNIVERSAL CONSTRUCTION 
AND THE DESCRIBED CONTEXT. 

DESIGNS NEED TO IDENTIFY TRADEOFFS. AND TO USE PARETO FRONT TO PROVIDE SOME OPTIONS, 
IF THERE IS A CHALLENGE APPLYING RESOURCES TO APPLY THE DIFFERENCE ENGINE TO MINIMISE 


NEED TO HAVE ENOUGH INFORMATION, THAT WHEN I NEED IT THE LITERATE SPECIFICATION PROVIDES THE TOOLING 
THAT EMBEDS THE BOOTSTRAPPABLE IMPLEMENTATION VIA ADDING A LITERATE SPECIFICATION EXTENSION, 
APPENDED TO THE SPEC DOCUMENT THAT BUILDS A IMPLEMENTATION FROM THE CODEBLOCKS, 
AND CAN BE USED TO APPEND MORE SPECIFICATIONS AND VARIATIONS LIKE DIFFERENT SHELLS.
WILL NEED TO BE ABLE TO PUT THE CONFIGURATION IN EACH OF THE DIFFERENT SHELLS. 
SO THERES INFORMATION THAT WE WILL NEED.
THIS PROJECT IS DESIGNED TO COMPOSE PREORDERS AND HOMSET GENERATOR TO COMPOSE HIGHER ORDER SYSTEMS, 
AS MUCH AS POSSIBLE 

USING MANY CONCEPTS TOO LONG TO EXPLAIN ... 

BUT SINCE EVERYTHING NEEDS AN INITIAL OBJECT IN THIS PROCESS,
THE SPECIFICATION SHOULD BE ABLE TO GENERATE THE INITIAL 
LOCATIONS AS ENV VARS FROM THE SPECIFICATION.

THE INITIAL OBJECT EXISTS IN THE SYSTEM WHERE THE POTENTIALITY IS REALISED IN TERMS OF KNOWING 
HOW TO GET IT TO EXIST AT A SEED STATE, STRUCTURED TO ACHIEVE SELF-ASSEMBLY, GENERATED 
FROM A DIFFERENT SYSTEM THAT FOLLOWS ALL THE STRUCTURES.

THE GOAL IS TO ENSURE THERES ENOUGH WAYS TO THINK, 
THE MODIFICATIONS CAN BE MADE NATURALLY.


---
notes related to architecture, requirements, designs, mainteance, configurations, 
deployment 
---

Need at add paths tool. Consider setting up run isolation for nvim in systemd-run or systemd-nspawn...
can use the a systemd-nspawn container to test 
shared data $HOME/.local/lib/..orchestration-architect or terminal ai.,, c
xdg_state_home can hold things like terminal-ai last-message file. when using 
the tool called to have it rendered, so it remains static ...
i will have the binaries path configuration to be 

THIS NEEDS TO FOLLOW XDG_SPECIFICATION BEST PRACTICES.
NEED TO MAKE IT USE STANDARD WAY OF CHECKING THE XDG_PATH etc.
THEN CHECK THE LINUX PATH OR SOMETHING 

if match -z $OA_CONFIG_PATH
    set XDG_CONFIG_HOME ${XDG_CONFIG_HOME:-$HOME/.config} 
    ...
    ...
end

if match -z $OA_CONFIG_
            
end

${OA



```sh oa-load-environment.fish
#!/bin/fish
# need to set to ensure $XDG_... vars defaults are set. 
# I think it should be done like $XDG_<SOMETHING>_HOME/orchhestration-architect.fish 
# and we will have a order of precedence, so that when it becomes a package 
# XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
# XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/XDG_DATA_HOM} 
# change to "${XDG_DATA_HOME:-$HOME/.config}/orchestration-architect/" or something
# it will be stored in /usr/share/...
# and config will be /etc/orchestration-architect/
# and finally
set -l set-source-path $(pwd)/shell-configuration" 
set -l source shell-configuration-path/orchestration-architect.fish"
set -l target "$HOME/.config/fish/conf.d/orchestration-architect.fish"
echo "Copying '$source' to '$target'..."
cp "$source" "$target"
echo "Copied '$source' to '$target'."
```


`orchestration-architect.fish` --> `$XDG_CONFIG_HOME/fish/conf.d/orchestration-architect.fish`
or it might be better to put it in the `$XDG_CONFIG_HOME/.config/orchestration-architect/lib/orchestration-architect.fish`
or somethign like that and symlink it, so if the config moves, the symlink will move with it 
the tools, will be pointing to /bin:/usr/local/bin:... etc. it should be on path ...
need to have natural transformations, /usr/local/.... 

we have the orchestration-architect tools, i gues they go somewhere...
and the ... `$XDG_DATA_HOME/.../usr/var/<user-id>/`

... TERMINAL-AI NEEDS TO DO THE SAME, BUT IT NEEDS TO CONSIDER THE DISTRIBUTED 
... ENVIRONMENTS NEED TO ALLOW THE COALESCE OF TRANSCRIPTS... THE LOGS WILL BE STORED AS...
... WELL... WE CAN ADD LIKE THE HOST NAME OR SOMETHING, OR A PROVIDED AS AN ENV VAR EVERYTHING NEEDS TO BE DONE 
... WE NEED TO HAVE A CHECK LIST THAT CAN BE UPDATED AND CAN REPAIR USING TOOLS LIKE FD TOOL OR SS.
... NEED TO MODEL ALL THIS OUT SO THAT WHEN ITS IMPLEMENTED A FUNCTOR TO RENDER THE D2 DIAGRAMS CAN WORK
... SINCE THAT WE HAVE LIKE ... [LOCAL, SYSTEM] (X) [DEV,LOCAL INSTALL,SYSTEM INSTALL,]
... CAN BRAID WITH INSTALLED FROM THE MASTER SYSTEM, OR IS IT ON LIKE AUR ... OR SOMETHING...OR PACMAN 
... I WILL NEED TO ENSURE COMPOSITIONALITY, SO THAT ALLOWS INDIVIDUAL COMPONENTS THAT REQUIRE THE THING, 
... TO PROVIDE THE BIT IT NEEDS BY ITSELF. SO THAT I HAVE AN EASIER TIME SETTING IT UP.
... ALSO WE NEED TO CONSIDER HOW WE CAN MAKE IT SO IT CAN WORK WITH THE SYSTEMD-NSPAWN RUNTIME methods 
... OR REMOTELY, I GUESS THATS WHERE ENVIORNMNET VARIABLES COME IN. LIKE IF TERMINAL-AI WAS IN AN SYSTEMD-NSPAWN
... OR ETC. AND I HAVE IT GENERATE THE THING IN AN ISOLATED ENVIORNMENT THEN THE OUTPUT CAN VERIFIED,
... IN AN AUTOMATED FASHION... CREATING NOT ONLY THE SYSTEM TO BUILD THE ENVIRONMENT, AND STUFF.
,,, AND SINCE THE SYSTEM SHOULD GENERATE FOR EACH SHELL TYPE BEING USED..
... BASH, SH, ZSH, FISH ARE THE SUPPORTED ONES, AND THEY WILL BE ADDED MANUALLY, 
... USING LITERATE WRITING TO DESCRIBE HOW TO DO EACH CONCEPT LIKE A FUNCTION etc. 
... IF SOMETHING CANT BE DONE IN A WAY THAT CAN NATURALLY TRANSFORM USING THE LITERATE WRITING,
... THEN THE THING NEEDS TO CHANGE THE CONCEPTUAL BUCKET FOR TRANSLITERATION AND 
... MAKE A BIGGER CODEBLOCK. STARTING AT A HIGH LEVEL IMPLEMENTATION FOR THE FIRST SHELL.
... THEN RE-ORGANIZING IT TO WORK FOR THE OTHERS... WRITING GRAMMARS TO IDENTIFY THE STRUCTURES,
... AND TO DO THIS PROCESS AUTOMATICALLY IS A JOB FOR THE LITERATE SPECIFICATIONS.

processing step 

at the moment i have the $OA_ORCHESTRATION_WORKSACE PATH WHICH IS A FOLDER IN 
$HOME/repos/orchestration-architect which holds worktress from the bare repo $HOME/repos/orchestration-architect.git
WITH THE ORIGIN /srv/git/orchestration-architect.git bare repo, AND THE AUTHORATIVE MASTERR TRANSIENT DEPLOYMENT...
etc. POINTING TO ...

need to add the worktree-to-workspace configuration somewhere... the ability to make changes and call a tool in the path 
that keeps it in sync, or setup systemd to manage the initialisation, as the systems, 
are generated from specifications/configurations on the transient master system.
... will need to model the implicatiopns to avoid the consistency availability and partitioning capabiltiy..
thats why we have all the repos be a single monorepo - distirbuted. because availability and eventual consistency are the key.
the system is built from text specifications, so it does not matter. and availability is maintained by making 
the AVAILABILITY AND CONSISTENCY (up to isomorphism) packaged together... as if the system changes and 
would not preserve some relied upon preorder that the specs enforce, then it would auto increment versions,
and since the system can revert to seed, and combine with a different variants seed by rolling back to a common point,
and regenerating the processes, using grammars semantic meanings to be captured, so they 
can be put back in place due to the preorders. this is not meant to be a tool to serve .. but 
to build the tools to serve, allowing variations... 
... we don't need to implement it, but will serve a specification for when we do it ...

IN FACT I MIGHT DO META CONFIG BEFORE META DOCS 
OR IT CAN BE IN META CONFIG, BECAUSE IT IN A Infrastracture as SPECIFICATION...
IT CAN GENERATE THE CONFIG WHEREFVER...
AND IT CAN USE PROVIDED ENV_VAR TO OVER RIDE THINGS FOR ENVIRONMENT STUFF...
AND WE SETUP THE PKGBUILD FOR SOME OF THE COMPONENTS INCREMENTALLY 
PROBABLY NEED TO HAVE LOCAL USER, /usr/local/bin/..., /usr/bin (depending on if its a system install, 
and whether its a dev or release, etc. 
ITS A PLAN THAT CAN BE ACTUALISED IF NEEDED, AS LONG AS I DEMONSTRATE THE PROCESS OR MORPHISM ONCE AND THE 
REORGANIZING, IT WILL PROVIDE THE WAYS OF THINKING ABOUT IT SO OTHERS AI AND HUMANS, AND VERY INTELLIGENT Dogs.
...
...
...local user, local build, 
... need to specify where the config can go ...
... 


```tree command output
/home/panda/.config/fish
├── completions
│   └── bcachefs.fish
├── conf.d
│   ├── fzf.fish
│   ├── orchestration-architect.fish
│   └── zoxide.fish
├── config.fish
├── fish_variables
└── functions
    ├── fish_prompt.fish
    └── weather.fish

4 directories, 8 files
```

