noremap <c-p> :GFiles<CR>
noremap <a-p> :Files<CR>
noremap <c-f> :Rg<CR>
vnoremap <c-f> y:Rg<space><c-r>=escape(@", '"*?()[]{}.')<CR><CR>

" vint: -ProhibitAutocmdWithNoGroup
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
