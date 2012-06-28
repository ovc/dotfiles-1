" Erik Westrup's gVim configuration.

" Hide toolbar.
set guioptions=acegimLt
" Set font.
if has("linux")
	set guifont=terminus\ 11
	"set guifont=Monospace\ 11
elseif has("mac")
	set guifont=Inconsolata:h14
endif
" Make shift-insert work like in xterm.
map! <S-Insert> <MiddleMouse>
" Source gvimrc on write.
autocmd! BufWritePost .gvimrc source ~/.gvimrc
" Disable (0) cursor blinking.
set guicursor+=n-v-c:blinkon0
