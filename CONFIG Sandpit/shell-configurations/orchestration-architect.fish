#!/bin/fish
set OA_WORKSPACE_PATH "$HOME/repos/orchestration-architect" 
set OA_DOCS_PATH "$OA_WORKSPACE_PATH/documentation"
set OA_JOURNAL_PATH "$OA_DOCS_PATH/Development Journal"
set OA_TOOLS_PATH "$OA_WORKSPACE_PATH/tools"
set OA_NOTES_PATH "$OA_JOURNAL_PATH/Notes"
set OA_SANDBOX_PATH "$OA_WORKSPACE_PATH/sandbox"
set OA_KANBANS_PATH "$OA_JOURNAL_PATH/Projects/Kanban"
set OA_PROJECTS_PATH "$OA_JOURNAL_PATH/Projects/PROJECT_OVERVIEW.md"
# need to make an iso category design so that a code 
# and path are the same 
function oa-find-kanban -a query; fd "$query" "$OA_KANBANS_PATH"; end
function oa-find-note -a query; fd "$query" "$OA_NOTES_PATH"; end
# is there are ways to make 
function oa-kanban; cd "$OA_KANBANS_PATH"; end
function oa-notes; cd "$OA_NOTES_PATH"; end
function oa-sandbox; cd "$OA_SANDBOX_PATH"; end
function oa-tools; cd "$OA_TOOLS_PATH"; end
function oa-list-projects; bat "$OA_PROJECTS_PATH"; end
function oa-projects; nvim "$OA_PROJECTS_PATH"; end
# Need to make function call another function 
# to lazy load it. So oa-display-projects will be defined 
# elsewhere... 
# Should add option to filter based on active projects or all.
function oa-display-projects; echo "$OA_PROJECTS_PATH" | entr -ncc bat "$OA_PROJECTS_PATH"; end
# Need to add display tasks and edit tasks
# will need to finish LITERATE SPEC FIRST
