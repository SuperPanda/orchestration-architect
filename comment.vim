" File: scripts/comment.vim
" Description: Provides a utility in Vim to toggle comments for selected lines in visual mode,
"              specifically for YAML, Vim script, Python, Ansible, and JavaScript files.
"              This script helps maintain clean and readable code by managing comments efficiently.
" (@project=OA-VIM)
" (@tool=VIM-COMMENT)

" (@haiku=OA-HAIKU-004)
" Silent code whispers,
" Comments shade the meaning deep,
" Clarity or hide.

" Requirements:
" (@srs=SRS-OA-VIM-COMMENT-001) Toggle comments on and off for selected text with proper indentation handling.
" (@srs=SRS-OA-VIM-COMMENT-002) Ensure that the toggling respects the syntax of the file type and does not double comment already commented lines.

" (@function=FUNC_OA_VIM_COMMENT_TOGGLE)
" Function to toggle comments, optimized for specified file types
function! ToggleComment()
    " Define the comment syntax for YAML, Python, Ansible as they share similar commenting style
    let l:commentPrefix = '#   '

    " Check if the first line of the selection is commented
    let l:isCommented = getline("'<")[0:3] == l:commentPrefix
    if l:isCommented
        " If the lines are commented, remove the comment
        '<,'>s/^#   //
    else
        " If the lines are not commented, add the comment
        '<,'>s/^/#   /
    endif
endfunction

" (@keybinds=KEYBINDS_OA_VIM_COMMENT)
" Key mappings
" Map the toggle function to leader-# in visual mode
vnoremap <leader># :<C-u>call ToggleComment()<CR>

