" vint: -ProhibitAutocmdWithNoGroup
" vint: -ProhibitCommandRelyOnUser
" With a map leader it's possible to do extra key combinations
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Command button as ';'
nnoremap ; :
nmap q; q:

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Disable Ex mode
nmap Q <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cnoremap $d ~/Desktop/
cnoremap $j ./
cnoremap $w ~/Workspace/

" $q is super useful when browsing on the command line
" it deletes everything until the last slash 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
tnoremap <ESC> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><esc> :noh<cr>

" Errors windows
nnoremap <leader>ln :lne<cr>
nnoremap <leader>lp :lpr<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Buffer navigation
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
"map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Fast saving
nmap <leader>w :w!<cr>

" Enter saves all files and repeats last command
" Useful for testing
nnoremap <CR> :wa<CR>:!!<CR>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some scripting languages
func! DeleteTrailingWS()
  exe 'normal mz'
  " vint: -ProhibitCommandWithUnintendedSideEffect
  %s/\s\+$//ge
  " vint: +ProhibitCommandWithUnintendedSideEffect
  exe 'normal `z'
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" System clipboard
vmap <leader>y "+y
nmap <leader>yy "+yy
vmap <leader>d "+d
nmap <leader>dd "+dd
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map auto complete of (, ", ', [
inoremap $9 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $' ''<esc>i
inoremap $" ""<esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function Calling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>t :call ToggleNumber()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute 'normal! vgvy'

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", '', '')

    if a:direction ==# 'b'
        execute 'normal ?' . l:pattern . '^M'
    elseif a:direction ==# 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction ==# 'replace'
        call CmdLine('%s' . '/'. l:pattern . '/')
    elseif a:direction ==# 'f'
        execute 'normal /' . l:pattern . '^M'
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    exe 'menu Foo.Bar :' . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr('%')
   let l:alternateBufNum = bufnr('#')

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr('%') == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute('bdelete! '.l:currentBufNum)
   endif
endfunction

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has('win16') || has('win32')
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", '')
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", '')
    endif

    if g:cmd == g:cmd_edited
        if has('win16') || has('win32')
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", '')
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", '')
        endif
    endif   

    return g:cmd_edited
endfunc

" Toggles between number and relative number
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
