let g:deoplete#enable_at_startup=1
call deoplete#custom#option('smart_case', v:true)

inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
