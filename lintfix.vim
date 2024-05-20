" File: scripts/lintfix.vim
" Description: VimScript to assist in linting and fixing common issues in Ansible playbooks,
"              particularly focusing on qualifying tasks with 'ansible.builtin' namespace and
"              removing trailing whitespaces.
" (@project=OA-VIM)
" (@tool=VIM-LINTFIX)

" (@haiku=OA-HAIKU-003)
" Scripted changes fall,
" Code aligns with namespace,
" Playbooks now refined.

" Requirements:
" (@srs=SRS-OA-VIM-LINTFIX-001) Automatically qualify Ansible module usage with 'ansible.builtin' namespace.
" (@srs=SRS-OA-VIM-LINTFIX-002) Handle 'debug' as a special case when used within tasks.
" (@srs=SRS-OA-VIM-LINTFIX-003) Provide functionality to remove trailing whitespaces.
" (@srs=SRS-OA-VIM-LINTFIX-004) Enable keybinds to trigger the linting functions easily.

" Define a list of Ansible commands to qualify with the 'ansible.builtin' namespace.
let s:ansible_modules = ['set_fact', 'include_vars', 'copy', 'find', 'file', 'assert']

" (@function=FUNC_OA_VIM_LINTFIX_REMOVE_WHITESPACES)
" Function to remove trailing whitespaces
function! RemoveTrailingWhitespaces()
    %s/\s\+$//e
endfunction

" (@function=FUNC_OA_VIM_LINTFIX_QUALIFY_ANSIBLE)
" Function to qualify Ansible commands with the 'ansible.builtin' namespace
function! QualifyAnsibleCommands()
    " Qualify general module usage at the start of the line
    for cmd in s:ansible_modules
        execute '%s/\v(^\s*)' . cmd . ':/\=submatch(1) . "ansible.builtin.' . cmd . ':"/ge'
    endfor

    " Special case handling for 'debug' module used in a task
    execute '%s/\v(^\s*)- debug:/\1- ansible.builtin.debug:/e'
endfunction

" Combine all lint functions into one main function
" (@function=FUNC_OA_VIM_LINTFIX_LINT_ANSIBLE)
function! LintAnsibleCode()
    call QualifyAnsibleCommands()
    call RemoveTrailingWhitespaces()
endfunction

" (@keybinds=KEYBINDS_OA_VIM_LINTFIX)
" Map key to run all lint fix operations
nnoremap <leader>lf :call LintAnsibleCode()<CR>

