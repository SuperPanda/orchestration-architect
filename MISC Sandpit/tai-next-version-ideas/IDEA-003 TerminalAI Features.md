# IDEA-003 TerminalAI Features



** ALLOW INSTRUCTIONS TO CHANGE **


Running `cat | wl-copy; set instructions "IMPROVE THIS LINE OF TEXT USING CONCEPTS FROM KNUTHS LITERATE WRITING STYLE GUIDE"; set message "$(wl-paste)"; terminal-ai "$instructions \n\r---\n\r $message" | tee "/tmp/last_message" | catcat | wl-copy; set instructions "IMPROVE THIS LINE OF TEXT USING CONCEPTS FROM KNUTHS LITERATE WRITING STYLE GUIDE"; set message ""; terminal-ai -- ""IMPROVE THIS LINE OF TEXT USING CONCEPTS FROM KNUTHS LITERATE WRITING STYLE GUIDE" \n\r---\n\r | tee "/tmp/last_message"`

```transcript
[2025-05-24 06:16:31+08:00,speaker=USER]
    IMPROVE THIS LINE OF TEXT USING CONCEPTS FROM KNUTHS LITERATE WRITING STYLE GUIDE

---
[2025-05-24 06:16:37+08:00,speaker=GPT]
# (@usage=449) prompt_tokens=347 completion_tokens=102
# (@conversation_id=chatcmpl-BaV4hGbd66E4qezSscqyD1LXuCSwD)
    To improve a line of text using concepts from Donald Knuth's literate programming style,
    we should focus on clarity, coherence, and readability. Here is a revised version 
    based on these principles:
    
    ---
    
    **"Please refine this line by utilizing the principles from Donald Knuth's literate programming methodology."**

    ---

    This improvement removes extraneous quotes, applies correct capitalization, and enhances the sentence's natural flow. If you provide a specific line of text, I can apply these principles directly to it for further enhancement.
    ---
```

... build resource ...

```
#!/bin/bash
    cat | wl-copy; set instructions "Please refine this line by utilizing the principles from Donald Knuth's literate programming methodology."
    set message "$(wl-paste)";
    terminal-ai "$instructions \n\r---\n\r $message"
    | tee "/tmp/last_message"
    END_OF_UPDATE
}



Then It could be ...

## Ideas
- USE knuths LITerate writing FOR CREATING VARIATIONS
  OF APPROACHES TO DESIGNING MULTIAGENT INTERACTIONS TO ALLOW 
  A FLEXIBLE ADJUSMTMENTS AND PROTOTYPING OF IDEA 
  using my the markdown literate tools that 
  allows literate specifications to bootstrap 
  the implementation by analysing the implicit structures 
  and semantic grammars
  - LOGS OVER TIME WITH A NATURAL FRECENCY AND 
  goals
- ways of thinking: 
- FOCUS ON NATURAL COHERENCE, THE STRUCTURE 
  WHEN DONE RIGHT LEADS TO UNEXPECTED 
  BEAUTY AND SIMPLICITY SO OTHERS DONT 
  SEE THE CATEGORY THEORY, JUST THE 
  SELF-EVIDENT CORRECTNESS. (SEE D2 EXAMPLE,
  AND (YET TO BE IMPORTED) LOGS ABOUT 
  MAKING A WAYLAND REVERSE PROXY, 
  AND stuff
- API Keys stored encrypted (systemd?)
- TerminalAI system user
- Use rg and fzf (see man for fzf),
  to go through transcripts; queries can be resources.
  that can be modified. Also, can summarise selected 
  texts.
- these can provide contexts function, 
- ACCESS TO MAN AND OTHER RESOURCES 
    USED, RESOURCES USED TO INSPIRE PROJECTS
- USE LITERATE WRITING TO ALLOW FOR 
  EXTENDING EXISTING WORK, SCOPING THE CONTEXTS.
- HAVE MULTIPLE AGENTS TAKE DIFFERNT OPTIONS
- USE THE LITERATE WRITING, AND THE SHARED KNOWLEDGE 
  POPULATIONS, TO HAVE THE AI AGENTS.
- 
- use literate writing, to document to design how it 
  works 
- each agent is responsible for its job, 
  and does the job using different ai.
- hieracherical structures, and heterarchical structures.
- Keep a contextual self-reflection process.
- Implement multiple agents.
- Secure storage of transcripts 
- Agent Experimental Environments in Nspawn or systemd.
- Minsky Ideas:
    - LOVE - if things are good, 
        turn off resources 
    - ENSURE that it can get better 
    - Multi responses 
    - For caching models, try different combinations 
      of context and reward the best one.
    - Resourcefulness
        - AIM = APPLY resources to minimise 
          DIFF(Present,Potential Future State)
        - Responding to Situations with Ways of Thinking
            - Good -> remember (tied to goals)
            - Bad -> match problems to possible strategies.
        - K-Lines - resources connected by 
          thread that changes when a particular 
          "composition" of resources adapt
    - Theres a need for not just statistical models
      but different types of models 
        - ways of thinking in APP. CAT THEORY,
          making ologs using 'a OBJECT', 'has-a-relation-with'
          'a DIFFERNET_OBJECT'
          initial points objects. 
          preorders by default.
          composition of preorders, ensuring monodial 
          categories.
          things need to be broken down if two complex.
          use arrow-object duality, for ARR(CAT) and 
          OB(CAT)
- Mix Minsky and Applied Category Theory
- Hook into system contexts: (neo)vim, shell.
- Multisystem transcripts collation for a given transcript
- fzf localhost http endpoint
- snapcast, wayland interface, 
  shell commands
- api keys need to be protected by systemd-cred.
- perhaps use differnt nspawn containers to 
- share personal wisdom in applying category theory 
  concepts and how i do coalgebraiac analysis
  and the rewire graph refinement with 
  functor mappings, with examples.
- lsp can call ai to understand context.
- can't use third party models 
  be on target system with the firefox, deepseek logs, 
  screen share... stuff 
- ontology view...
- use git stuff to link goals to outcomes 
- make the differnet models evaluate each others 
  response which is fed by the users responses 
- the ways of thinking is local, 
  creating a society of mind (in conjunctions).
- use tf-idf to identify key words 
- braid recommended words based on contexts
- oxidize all the things 
- use like a TREE Retrival Augmenter with SUMMARIES
  that average out each section 
    - paper says it gets rid of hallucinations #tool 
- make fzf rg things, keep last thing entered
  in $XDG_STATE_HOME #tool
- put #config
- convert the messages to summaries, 
  that are coalesced
- look mah, no database
- linked documents between ais, allow collaboration 
- multi-agent jobs, and at different layers,
  a layer like IFVDO to make functions, 
  to VALUES, BELIEFS, EXPECTATIONS, ASSUMPTIONS 
  THAT SELF-REFLECTS ON THE RESOURCES THEY USE 
  (this is what i need to do, change resources 
   ways of thinking and klines)
  REFLECTION - review the use of resources 
  (the difference engine in resourcefulnesS)
  LOVE - TURN OFF SOME RESOURCES, 
    THAT MAKES IT BEHAVE IT SHOULDNT...
    MAYBE THAT CAN BE USED BY DIFFERENT  
    MULTI-AGENTS-STRUCTURES TO TURN OFF 
    CERTAIN RESOURCES, TO BE COMPOSABLE 
    USING ABSTRACTION....
    Just need to go through the book 
    using the fzf and rg tool to 
    
  PATTERNS - Like MINSKYS CHOICE IN 
  EMPHASIS AND FORMATTING

- OCR FOR PDFS AND IMAGES 
- USE IMAGE MODEL FOR DIAGRAM EXPLANATIONS 
- GRAMMARS AND SPECS AND LEXERS AND PARSERS
- ACCESS VIA NEOVIM TO EXTEND NEOVIM (create a 
  tool to do this), or shell - can provide 
  context via descriptions 
- Every bit of information can be considered 
  in different states that the terminal ai 
  has considered to be something hte user has said
- USe literate writing, to allow VARIATIONS
- Maybe binary decision diagrams are 
  symmetric monoidal categories.

## CATEGORIES OF IDEAS 

**WAYS OF THINKING**

*RESOURCEFULNESS**

**UNPACK SUITCASE WORDS**

**MINSKY BOTTOM UP**

**(APPLIED) CATEGORY THEORY**

MODELS HEURISTICS, 

...

## TYPES OF ACTIONS AN AGENT CAN DO 

**CREATE MORE 'RE-' WORDS 

REACT
READ  
REBUILD 
REBUTE 
RECALL 
RECITE 
RECORD 
REDO 
REEVALUTE
REFER 
REFLECT 
REIMAGINE 
REITERATE 
RELATE 
REMAND 
REMEMBER 
REORGANISE 
REPLACE 
REPORT
REPRESENT 
RETRACE 
RETROSPECT
RETRY 
REVERT 
REVIEW 
REWARD 
REWIRE 
REWRITE 
RESORT
RECREATE
REFOCUS
RENDER 


**CAN ALL THE ABOVE COMPOSE?**


**Ideas for finding resources**

TRANS- (search in book).

RE- (search in book).

SELF- (many examples in the Orchestration Architect system, self-assembling, self-verifying, self-documenting, self-specifying, self-bootstrapping, self-versioning (evolutionary adjunctions), ...) 

CO- (DUALITY, CAT THEORY [loves co-])

## WAYS OF THINKING

**GET THE DEMONSTRATION OF USE CATEGORY TO VIEW THINGS**

DUALITY (ARROW/OBJECT DUAL VIEW RESOURCE MODEL, STRUCTURE VS FUNCTION MAPS TO ARROW(CAT) VS OBJ(CAT)
NATURALLY TRANSFORM STRUCTURE AND FUNCTION TO DIFFERENT VIEWS.
DESIGN PRE-ORDERED STRUCTURES FROM THE BOTTOM UP 
PRE-ORDER STRUCTURES CREATE AUTOMATIC SYMMETRIC MONODIAL DESIGNS - RE-STRUCTURE DESIGNS 
THINGS CAN BE MADE MONODIAL BY IDENTIFYING THE INITIAL OBJECT AND TERMINAL OBJECT 
YONDA LEMMAS SAYS THAT IF A THING CAN REPRESENT ALL THE MORPHISMS THEN AN OBJECT 
CAN BE DEFINED (ALLOWING THE OBJECT TO BE LEFT BLANK)
THINK OF OPTICAL CATEGORIES LENS AND OPERATIONS LIKE CELLOPHANE AND LIGHT.. LIGHT IS A BEAM
THINK OF EVERYTHING THAT HAS AN IDENTITY IS IMMUTABLE
THE CONSTRAINTS OF THIS IMMUTABILITY IS THAT WE CAN DEFINE THE HOMSET AS EXISTING, NOT EXISTING AND KEEPS IDENTITY 
THE IDENTITY IS BASED IN ITS RELATION TO OTHER THINGS (THINK THE SHIP...)
THE A CUTOUT OF A COOKIE IN COOKIE DOUGH DEFINES THE OBJECT OF COOKIE IN THE CATEGORY OF COOKIES
COMPOSITION OF RESOURCES TO ACHIEVE AN AIM IS AKIN TO COMPOSING MORPHISMS TO REACH A GOAL 
OR COMPOSING OBJECTS TO CREATE A RESOURCE 
A HIGHER ORDER RESOURCE CAN CREATE A HIGHER ORDER RESOURCE 

## INSPIRATIONS

EVERYTHING IN THE UNIVERSE DECAYS, SO ONLY THROUGH ADJUNCTION WHICH IS A SEED (DNA/INITIAL OBJECT) THAT GROWS AND IS ABLE 
TO GENERATE THE NEXT SEED, HAS THE ABILITY TO BE AN ANALOG TO EVOLUTION, POPULATION-BASED CONCPETS, 

SO TO KEEP SOMETHING THAT PERSISTS AND MAINTAINS ITS IDENTITY WE CAN MAKE THINGS NOT EXIST AND EXIST AGAIN WITH THE NEW CONFIGURATION,
THESE CAN BE PUT INSIDE OF A CATEGORY OF LINEAGE (VERSIONS) 

THE STRANGE ATTRACTOR OF ALL IS THINGS TEMPORARILY COME INTO EXISTENCES, FROM NOT EXISTENCE 

BASICALLY A SOUL IS THE IMPRINT (LIKE COOKIE CUT OUTS IN DOUGH) LEFT IN THE WORLD WHEN ITS GONE (IN THE MINSKY-ESQUE BREAKDOWN THE SUITCASE WORD SENSE OF IT)...

THE ONLY WAY TO ESCAPE THE SEA OF DECAY IS THROUGH REPRODUCTION, OR A RECURRENT REPEATABLE PROCESS, TO REGENERATE. LIKE WHORLS IN SMOKE DISAPATE BY FORMING SMALLER AND SMALLER WHORLS,
SOMETHING NEEDS TO BE ABLE TO CREATE THESE WHORLS AGAIN WHEN THERE GONE. 


## WAYS OF THINKING 2

...SHOULD LIST A WHOLE BUNCH OF CATEGORY THEORY CONCEPTS USED...
SO I CAN FIND ALL MY NOTES ON THE DIFFERENT THIGNS.

K-LINES ALLOW US TO SEE WHAT WE SHOULD LOOK AT, WHICH CAN BE IMPROVED 

NOTHING EXPLICIT ABOUT THE UNIVERSE... ITS IMPLICITLY NATURALLY CASCADES THE INTERACTIONS #coherence 

THE IFVDO (INSTINCTS NATURALLY RESPOND, THERES STIMULUS TRIGGERS THE RESPONSE)... like having automatic triggers that encapsulate function .... #LEVELS-OF-THINKING


**GOLDEN RULE** EVERYTHING IS COMPOSED SMALL THINGS TO CREATE BIGGER THINGS THAT ACHIEVE SOME OUTCOME 

**PURPOSE OF LIFE** TO *ACTUALISE* ONES *REALISED POTENTIALITIES*

UNREALISED POTENTIAL = RESOURCE DOES NOT EXIST 

REALISED POTENTIAL = POSSIBLE RESOURCE  (requires work to get the aim there)

ACTUALISE RESOURCE = A RESOURCE


REFLECTION - WHAT RESOURCES DO I NEED 

SELF-REFLECT - IS THIS THE CORRECT RESOURCE 

FEEDBACK - THIS IS NOT WORKING 


COOPERATION IS A STRATEGICALLY DOMINANT GAME THEORETIC STRATEGY, 
WHEN A CERTAIN THRESHOLD IS ACHIEVED.

CHANGING TO A COOPERATIVE STRATEGY REQUIRES LEADERSHIP, 
LEADERSHIP IS NOT ABOUT MAKING THINGS HAPPEN, 
BUT MAKING THOSE THINGS HAPPEN NATURALLY

CORRECTNESS IS COHERENCE ACROSS DIFFERENT WAYS OF THINKING,
A GOOD WAY OF THINKING APPLIES IS GENERALLY UNIVERSAL 

ANALOGIES ARE A GREAT WAY TO CHECK THE UNIVERSAL 
APPLICATION OF THESE IDEAS 

UNIVERSAL AND EMERGENT AND NATURALLY CASCADING EFFECTS COMES ABOUT FROM 
COMPOSITION. 

CATEGORY THEORETIC MODELS THAT COHERE WELL LEAD TO UNEXPECTED
BEAUTY.

BEAUTY IS A REFLECTION OF COHERENCE OF COMPOSITION.


 


## PRACTICE

**THIS PROVIDES MULTIPLE RESOURCES** 

CAN YOU IDENTIFY THE RESOURCES...

```
#!/bin/bash 
# a possible idea of composing certain things
# possible for ai journalling
# WAY OF THINKING 
A_RESOURCE="using the ologs-inspired 'a-SOMETHING has-invariant-relation-to a-SOMETHING_ELSE'"
# AIM 
A_GOAL="to illustrate ways of thinking"
# DIFFERENCE ENGINE
AN_OUTCOME="provides a way of thinking"

cat <<A_RESOURCE_EOF; cat <<A_GOAL_EOF; cat << AN_OUTCOME_EOF
$A_RESOURCE
A_RESOURCE_EOF
$A_GOAL
A_GOAL_EOF
$AN_OUTCOME 
AN_OUTCOME_EOF
```

