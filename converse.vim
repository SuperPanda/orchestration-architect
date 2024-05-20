" File: scripts/converse.vim
" Description: VimScript to assist in generating conversation markers tailored for minute taking.
"              This script includes functionalities to easily insert structured tags for user and GPT speech,
"              making documentation during conversations or meetings efficient and consistent.
" (@project=OA-META-DOCU)
" (@tool=VIM-CONVERSE)

" (@haiku=OA-HAIKU-001)
" Words across the void,
" Sender, message, receiver,
" Bridging minds with speech.

"  Requirements:
" (@srs=SRS-OA-VIM-CONVERSE-001) Function to initiate conversation with date stamp.
" (@srs=SRS-OA-VIM-CONVERSE-002) Function to insert user speech marker.
" (@srs=SRS-OA-VIM-CONVERSE-003) Function to insert GPT speech marker.
" (@srs=SRS-OA-VIM-CONVERSE-004) Automatically format entries with markdown speech tags.

" (@function=FUNCTION_OA_VIM_CONVERSE_CONVERSATION)
" Function to initiate conversation
function! Conversation()
  let l:date = strftime('%Y%m%d')
  normal! o# Minutes l:date
  normal! o# (@conversation) Conversation Record with GPT Begins
  normal! o---
endfunction

" (@function=FUNCTION_OA_VIM_CONVERSE_USER_SPEECH)
" Function to insert speech tag for User
function! UserSpeech()
  normal! o```
  normal! o# (@speech, speaker=User)
  normal! o```
  normal! o
  normal! o
  normal! o
  normal! o---
endfunction

" (@function=FUNCTION_OA_VIM_CONVERSE_GPT_SPEECH)
" Function to insert speech tag for GPT
function! GPTSpeech()
  normal! o```
  normal! o# (@speech, speaker=GPT)
  normal! o```
  normal! o
  normal! o
  normal! o---
endfunction

" (@keybinds=KEYBINDS_OA_VIM_CONVERSE)
" Map keys to trigger functions
nnoremap <leader>cc :call Conversation()<CR>
nnoremap <leader>cu :call UserSpeech()<CR>
nnoremap <leader>cg :call GPTSpeech()<CR>

