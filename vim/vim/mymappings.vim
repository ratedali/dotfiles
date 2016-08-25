" System clipboard
vmap <leader>y "+y
nmap <leader>yy "+yy
vmap <leader>d "+d
nmap <leader>dd "+dd
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

"vmap <C-c> "+yi
"vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p
"imap <C-v> <ESC>"+pa

" plugins
map <leader>w <Plug>(expand_region_expand)
map <leader>e <Plug>(expand_region_expand)

" errors
nnoremap <leader>ln :lne<cr>
nnoremap <leader>lp :lpr<cr>

" windows
nnoremap <leader>q :close<cr>

" functions
nnoremap <leader>t :call ToggleNumber()<cr>

" shortcuts
nnoremap <leader>cw :cd ~/Workspace<cr>

" Enter saves all files and repeats last command
" Useful for testing
nnoremap <CR> :wa<CR>:!!<CR>

