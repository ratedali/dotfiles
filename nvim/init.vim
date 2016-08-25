if &shell =~# 'fish$'
    set shell=sh
endif

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/ui.vim
source ~/.config/nvim/mappings.vim

" Ignore compiled and temporary files on completions
set wildignore=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*,__pycache__\*

" A buffer becomes hidden when it is abandoned
set hid

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic


" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" Turn persistent undo on 
"means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim/tmp/undodir
    set undofile
catch
endtry



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set smartindent " Copy last line indention
set wrap "Wrap lines

" Mappings input timeout
set timeoutlen=350
