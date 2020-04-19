call plug#begin()

Plug 'francoiscabrol/ranger.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'neomake/neomake'
Plug 'janko/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'wellle/tmux-complete.vim'
Plug 'roxma/vim-tmux-clipboard'
" ranger.vim dependency
Plug 'rbgrouleff/bclose.vim'

" specific file types
Plug 'sheerun/vim-polyglot'
Plug 'Valloric/MatchTagAlways'

" themes
Plug 'deviantfero/wpgtk.vim'
call plug#end()

" per-plugin configuration
for plugconf in globpath(expand('<sfile>:h') . '/plugins.d', '*.vim', 1, 1)
   exec 'source ' . plugconf
endfor
