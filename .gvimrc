" Erik Westrup's gVim configuration.

" Hide toolbar.
set guioptions=acegimLt

" Disable (0) cursor blinking.
set guicursor+=n-v-c:blinkon0

" Set font.
let s:os=GetRunningOS()
if s:os == "linux"
	"set guifont=Monospace\ 11
	set guifont=Terminus\ Medium\ 11
elseif s:os == "mac"
	set guifont=Inconsolata:h14
endif

" Make shift-insert work like in xterm.
map! <S-Insert> <MiddleMouse>

" Source gvimrc on write.
autocmd! BufWritePost .gvimrc source ~/.gvimrc
