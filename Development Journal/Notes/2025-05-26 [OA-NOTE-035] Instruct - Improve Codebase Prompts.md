# ARCHITECTURAL PATTERN: AUTOLOGICAL COALGEBAIACS
```fish «bootstrap»
#!/bin/fish

#   File: `2025-05-26 [OA-NOTE-035] Instruct - Improve Codebase Prompts.md`
#   Location: `$OA_NOTES_PATH`
a
#   **Neovim Tip**: Write Relative Path `:r !echo %`
#                   Write Full Path `:r !echo "$PWD/%"`
#                   Write Base Path `:r !echo "$PWD"`
#                
#    Pipe "%" to get this file. And we have the file above.
#    We can make sure the `current path` matches the `base path`. 
#
# 
# 
# The `Location` (Current `$OA_NOTES_PATH`) can automatically update as it 
# moves, enabling a system that documents contain there metadata and 
# move it with them.
# 
# See `:help function` for more tips.

set -l current_file "2025-05-26 [OA-NOTE-035] Instruct - Improve Codebase Prompts.md" 
set -l current_path "$OA_NOTES_PATH" 
function identify-ext-boundary -a plane boundary; 
    # TODO Setup default pattern
    if test -z "$boundary"; set -f boundary "[-]{3}"; end
    if test -z "$plane"; return; end
echo -e "$plane" | grep -oP "$pattern"| head -n1 | cut -d\: -f1
end
echo -e "$(cat /tmp/plane)" | grep -nP "^[-]{3}"

echo ""
# END TEST
# echo -e $(identify-ext-boundary $(echo -e "a\n---\nb") "[-]{3}")

# A unique identity, due to preorder (theres only one first `---` fpr every file)
set -l plane $(cat "$current_path/$current_file")

echo -e "$plane"
set -l boundary "[-]{3}"
set -l plane_boundry $(identify-ext-boundary "$plane" "$boundary")
set -l operator $(echo "+$plane_boundary")
echo "$operator"
set -l right $(head -n $operator)
set -l left $(tail -n $operator)

echo "$left"
echo "---"
echo "$right"

set -l left (head -n(echo '+' .. boundary) $template);
set -l right (tail -n+(boundary) $template);

cat "$left"

#    **GOING TO USE THE TEMPLATE MANUALLY FOR NOW **


#    **NEXT STEPS** 
#    1. DO A MODEL WITH D2
#    2. MERGE WITH LIT. SPECIFICATION
#
#
# TESTS
function run-test -a expected actual
    if test "$expected" = "$actual";
        echo "PASSED."
    else;
        echo "FAILED."
        echo -e "$(echo Expected:\n---\n$expected\n---\nGot $actual.)"
    end
end

echo "[TEST] Test 'run-test' (SHOULD FAIL)"
run-test "true" "false" | grep -oP "FAILED." | cat | sed -E "s/FAILED/SUCCESS (FAILED SUCCESSFULLY)/g"
run-test "false" "true" | grep -oP "FAILED." | sed -E "s/FAILED/SUCCESS (FAILED SUCCESSFULLY)/g"

echo "[TEST] THAT ECHO, FILE, CAT COMPOSITIONALITY"
set -l expected $(echo -e "a\n---\nb")
echo -e "a\n---\nb" > /tmp/plane;
set -l actual $(cat /tmp/plane);
run-test "$expected" "$actual"

echo "[TEST] THE GREP WORKS WITH MULTILINE"
set -l expected "2:---"
set -l actual "echo -e "$(cat /tmp/plane) | grep -oP "^[-]{3}"
run-test "$expected" "$actual"


```

## Tests

```fish «unit tests»
# TESTS
function run-test -a expected actual
    if test "$expected" = "$actual";
        echo "PASSED."
    else;
        echo "FAILED."
        echo -e "$(echo Expected:\n---\n$expected\n---\nGot $actual.)"
    end
end

echo "[TEST] Test 'run-test' (SHOULD FAIL)"
run-test "true" "false" | grep -oP "FAILED." | cat | sed -E "s/FAILED/SUCCESS (FAILED SUCCESSFULLY)/g"
run-test "false" "true" | grep -oP "FAILED." | sed -E "s/FAILED/SUCCESS (FAILED SUCCESSFULLY)/g"

echo "[TEST] THAT ECHO, FILE, CAT COMPOSITIONALITY"
set -l expected $(echo -e "a\n---\nb")
echo -e "a\n---\nb" > /tmp/plane;
set -l actual $(cat /tmp/plane);
run-test "$expected" "$actual"

echo "[TEST] THE GREP WORKS WITH MULTILINE"
set -l expected "2:---"
set -l actual "echo -e "$(cat /tmp/plane) | grep -oP "^[-]{3}"
run-test "$expected" "$actual"
```

---
THE CONTEXT
===========

YOU ARE INSTRUCTED TO IDENTIFY ONE SMALL IMPROVEMENT BASED ON WORKING TOWARDS THE ENSURING THE REQUIREMENTS ARE ACHIEVED

THE GOAL IS TO MAKE A SMALL CHANGE THAT WILL: 

    (1) MINIMISES THE DIFFERENCE FROM THE PRESENT AND THE SPECIFIED REQUIREMENTS INCLUDED WITHIN THE DOCUMENT.

    (2) IMPROVE THE CODEBASE IN TERMS OF COHERENCE, UNDERSTANDABILITY, AND COMPOSABILITY.
        THIS OBJECTIVE IS TO IMPROVE THE FOLLWING: COMPREHENSION OF STRUCTURE AND FUNCTIONS, MINIMISE A READERS COGNITIVE LOAD.
        SOME ADVICE FROM EXPERIENCE... GOOD COMPLEX DESIGN LEADS TO AN EMERGENT BEAUTY IN SIMPLICITY. CONSIDER ALTERNATIVES, 
        AND WHAT IT COULD LEAD TOO.

    (3) LAST, BUT MOST IMPORTANTLY, IF THE CODE IS BROKEN THE PRIORITY IS TO MAKE THE CHANGE TO A PART THAT WILL MAKE SMALL INCREMENTAL CHANGES 
        SO THAT CHANGES CAN BE VERIFIED, WHICH IS ESSENTIAL TO CONTINUE THIS PROCESS.


FORMAT
------

THE RESPONSE SHOULD CONTAIN:

* A DESCRIPTION OF THE IDENTIFIED CHANGE IN RELATION TO THE REQUIREMENTS PROVIDED WITHIN THE CODEBASE.
* THE REASON IT WAS CHOSEN OVER THE OTHER ALTERNATIVES 
* A DESCRIPTIOIN OF WHAT IS GOING TO BE CHANGEFD.
* A CODEBLOCK CONTAINING THE ORIGINAL CODE PRIOR TO THE CHANGE 
* A CODEBLOCK AFTER THE MODIFICATION HAS BEEN APPLIED.
* A SHORT SUMMARY DESCRIBING HOW THE CHANGE HAS ACHIEVED PROGRESS IN THE OBJECTIVES.
* A CONCLUSION THAT RESTROPECTIVELY HIGHLIGHTS ANY INSIGHTS, INSPIRATIONS, CHALLENGES, PROBLEMS, CRITIQUES

> IF THE CODE IS BROKEN THAT PRIORITY IS TO MAKE A CHANGE THAT WILL GET THE CODE TO A EXECUTABLE STATE WE CONTINUE THIS PROCESS.

> YOU ARE EXPECTED TO THINK ABOUT HOW THINGS COULD BE CHANGED TO MAKE IT EASIER TO COMPOSE AND MODIFY AND REASON. GOOD COMPLEX DESIGN EMERGES ELEGANTLY. 

> YOU ARE TO IDENTIFY A SMALL REGION OF CODE TO MODIFY THAT WILL BE PRESENTED IN A CODE BLOCK AND THE CODE AFTER MODIFICATION IN ANOTHER CODE BLOCK. 

> THE COMMENTS ARE TO PROVIDE INFORMATION ABOUT THE CODE ITSELF THAT IS COHERENT. 

> YOU ARE TO IDENTIFY WHICH REQUIREMENT THE CHANGE WILL FILL. 


============= BEGINNING OF CODE TO APPLY INSTRUCTIONS. ALL INSTRUCTIONS HAVE CONCLUDED FROM THIS POINT ALL, THE FOLLOWING IS THE TARGET TO APPLY THE INSTRUCTIONS TOO! =============

**FILE** `$XDG_CONFIG_HOME/nvim/lua/plugins/cmp.lua`

> **CONTEXT** 
> ------------
>
>   * CUSTOM ARCH-BASED LINUX DISTRO
>   * NEOVIM


**CODE AND REQUIREMENTS**

```lua «TRANSCLUSION PLACEHOLDER»

```

---
