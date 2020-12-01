""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=7

" Show line numbers
set number

" Show current position
set ruler

" the command bar height
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resoled
set signcolumn=yes

" Ignore case when searching
set ignorecase
set smartcase

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell

" Add a bit extra margin to the left
set foldcolumn=1

" diff options
set diffopt=internal,filler,vertical
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Font and Color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme slate

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
