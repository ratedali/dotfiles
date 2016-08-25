call plug#begin()

Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer --clang-completer'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'terryma/vim-multiple-cursors'
Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" specific file types
Plug 'Valloric/MatchTagAlways'
Plug 'derekwyatt/vim-scala'
Plug 'dag/vim-fish'


" themes
Plug 'dracula/vim'
Plug 'lifepillar/vim-solarized8'
Plug 'pbrisbin/vim-colors-off'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'vim-scripts/molokai'
call plug#end()

source ~/.config/nvim/plugins/YouCompleteMe.vim
source ~/.config/nvim/plugins/deoplete.vim
source ~/.config/nvim/plugins/neomake.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/ultisnips.vim
source ~/.config/nvim/plugins/vim-tmux-navigator.vim
