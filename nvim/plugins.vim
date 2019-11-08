call plug#begin()

Plug 'francoiscabrol/ranger.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'neomake/neomake'
Plug '/usr/share/vim/vimfiles/plugin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'gabesoft/vim-ags'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'wellle/tmux-complete.vim'
Plug 'roxma/vim-tmux-clipboard'
" ranger.vim dependency
Plug 'rbgrouleff/bclose.vim'

" specific file types
Plug 'Valloric/MatchTagAlways'
Plug 'dag/vim-fish', { 'for': 'scala' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }


" themes
Plug 'deviantfero/wpgtk.vim'
call plug#end()

" per-plugin configuration
for plugconf in globpath(expand('<sfile>:h') . '/plugins.d', '*.vim', 1, 1)
   exec 'source ' . plugconf
endfor
