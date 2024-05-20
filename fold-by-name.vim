" File: scripts/fold-by-name.vim
" Description: This VimScript automates folding in Vim based on specified markers ('- name:') in the document, adhering to indentation levels to maintain hierarchical structure.
"              The script uses a depth-first search-like approach to dynamically manage nested and sibling folds, ensuring that sections are intuitively organized and easily navigable.
" (@project=OA-VIM)
" (@tool=VIM-FOLD)

" Haiku: Reflection on Communication and Structure
" (@haiku=OA-HAIKU-002)
" Lines of code unfold,
" Structured depths reveal their tales,
" Folded thoughts hold secrets.

" Requirements:
" (@srs=SRS-OA-VIM-FOLD-001) Provide a folding mechanism that automatically identifies and folds sections based on lines starting with '- name:' considering their indentation levels.
" (@srs=SRS-OA-VIM-FOLD-002) Ensure that folds are created only between lines with '- name:' that share the same indentation level, thereby maintaining the hierarchical structure of the document.
" (@srs=SRS-OA-VIM-FOLD-003) Preserve visibility of each '- name:' line when its subsequent content is folded, enabling users to quickly understand the structure of the document without expanding all folds.
" (@srs=SRS-OA-VIM-FOLD-004) Implement a depth-first search-like approach for determining fold boundaries to dynamically manage nested and sibling folds based on the document's indentation and structure.
" (@srs=SRS-OA-VIM-FOLD-005) Provide robust error handling to skip folding operations where line formats do not meet the expected pattern, enhancing the script's stability and usability.
" (@srs=SRS-OA-VIM-FOLD-006) Refresh the Vim display after folding operations to immediately reflect changes, improving user interaction and feedback.
" (@srs=SRS-OA-VIM-FOLD-007) Allow users to trigger folding operations via a custom command mapped to a key combination, offering flexibility and ease of use.

" Define a command in Vim that executes the FoldByName function
" (@function=FUNC_OA_VIM_FOLD_BY_NAME)
command! FoldByName call FoldByNameDepthFirst()

" Function to set up folds using a depth-first approach based on indentation levels
" (@function=FUNC_OA_VIM_FOLD_BY_NAME_DEPTH_FIRST)
function! FoldByNameDepthFirst()
    " Clear existing folds
    normal! zE

    " Set the fold method to manual to allow custom fold ranges
    setlocal foldmethod=manual

    " Process the current buffer for folding
    let l:lines = getline(1, '$')
    let l:last_line = {}
    let l:current_indent = 0

    for l:line_number in range(1, len(l:lines))
        if l:lines[l:line_number - 1] =~ '^- name:'
            let l:current_indent = indent(l:line_number)

            " Update last line if existing indent is found
            if has_key(l:last_line, l:current_indent)
                execute (l:last_line[l:current_indent] + 1) . ',' . (l:line_number - 1) . 'fold'
            endif

            " Store current line as the last line for this indentation
            let l:last_line[l:current_indent] = l:line_number
        endif
    endfor

    " Refresh the display
    redraw!
endfunction

" (@keybinds=KEYBINDS_OA_VIM_FOLD)
" Map the custom command to a leader key combination for folding by name
nnoremap <Leader>zn :FoldByName<CR>

" How to use standard Vim fold commands:
" zc - Close a fold at the cursor.
" zo - Open a fold at the cursor.
" za - Toggle a fold at the cursor.
" zM - Close all open folds.
" zR - Open all folds.
" zm - Increases the foldlevel by one.
" zr - Decreases the foldlevel by one.

