let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1

nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>G :YcmCompleter GoToImprecise<cr>
nnoremap <leader>d :YcmCompleter GetDoc<cr>
nnoremap <leader><F1> :YcmCompelter FixIt<cr>
nnoremap <F2> :YcmCompleter TheRefactorRename 
