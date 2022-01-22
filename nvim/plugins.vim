call plug#begin()

Plug 'dstein64/vim-startuptime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-multiple-cursors'
Plug 'neomake/neomake'
Plug 'janko/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'

" specific file types
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Colorschemes
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

" per-plugin configuration
for plugconf in globpath(expand('<sfile>:h') . '/plugins.d', '*.vim', 1, 1)
   exec 'source ' . plugconf
endfor
