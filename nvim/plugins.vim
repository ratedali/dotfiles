call plug#begin()
call plug#end()

" per-plugin configuration
for plugconf in globpath(expand('<sfile>:h') . '/plugins.d', '*.vim', 1, 1)
   exec 'source ' . plugconf
endfor
