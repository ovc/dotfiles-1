" Erik Westrup's Vim configuration.
" Modeline {
"	vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8:
" }

" TODO replace all UNIX-specific paths with $VIMhome or something clever

" Vundle {
	let s:using_vundle = 1		" Vundle will break default behaviour of spellfile. Let others know when using Vundle.

	set nocompatible              " be iMproved, required
	filetype off                  " required

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" Git {
		"Plugin 'git://git.wincent.com/command-t.git'
	"}

	" Github {
		"Plugin 'Rip-Rip/clang_complete'
		"Plugin 'maxbrunsfeld/vim-yankstack'
		"Plugin 'mbbill/undotree'
		"Plugin 'mhinz/vim-startify'
		"Plugin 'rhysd/vim-clang-format'
		"Plugin 'tpope/vim-unimpaired'
		Plugin 'LaTeX-Box-Team/LaTeX-Box'
		Plugin 'MarcWeber/vim-addon-mw-utils'
		Plugin 'Rykka/lastbuf.vim'
		Plugin 'Townk/vim-autoclose'
		Plugin 'airblade/vim-gitgutter'
		Plugin 'altercation/vim-colors-solarized'
		Plugin 'bkad/CamelCaseMotion'
		Plugin 'davidhalter/jedi-vim'
		Plugin 'editorconfig/editorconfig-vim'
		Plugin 'erikw/snipmate-snippets'
		Plugin 'erikw/vim-unimpaired'
		Plugin 'fatih/vim-go'
		Plugin 'fisadev/vim-isort'
		Plugin 'flazz/vim-colorschemes'
		Plugin 'garbas/vim-snipmate'
		Plugin 'godlygeek/tabular'
		Plugin 'kana/vim-operator-user'
		Plugin 'kana/vim-textobj-function'
		Plugin 'kana/vim-textobj-user'
		Plugin 'majutsushi/tagbar'
		Plugin 'mattn/gist-vim'
		Plugin 'mattn/webapi-vim'
		Plugin 'michaeljsmith/vim-indent-object'
		Plugin 'python-rope/ropevim'
		Plugin 'rbonvall/snipmate-snippets-bib'
		Plugin 'rhysd/vim-clang-format'
		Plugin 'salsifis/vim-transpose'
		Plugin 'scrooloose/nerdcommenter'
		Plugin 'scrooloose/nerdtree'
		Plugin 'scrooloose/syntastic'
		Plugin 'sjl/gundo.vim'
		Plugin 'suan/vim-instant-markdown'
		Plugin 'tmhedberg/matchit'
		Plugin 'tmux-plugins/vim-tmux'
		Plugin 'tomtom/tlib_vim'
		Plugin 'tpope/vim-capslock'
		Plugin 'tpope/vim-fugitive'
		Plugin 'tpope/vim-markdown.git'
		Plugin 'tpope/vim-repeat'
		Plugin 'tpope/vim-speeddating'
		Plugin 'tpope/vim-surround'
		Plugin 'wincent/command-t'
	"}

	" Github, vim-scripts.org {
		"Plugin 'LanguageTool'
		"Plugin 'OmniCppComplete' " Incompaitble with clang_complete.
		"Plugin 'TaskList.vim'
		"Plugin 'last_edit_marker.vim'
		"Plugin 'taglist.vim'
		Plugin 'AutoTag'
		Plugin 'Color-Sampler-Pack'
		Plugin 'ConflictMotions'
		Plugin 'CountJump'
		Plugin 'FuzzyFinder'
		Plugin 'L9'
		Plugin 'Rename'
		Plugin 'argtextobj.vim'
		Plugin 'autoload_cscope.vim'
		Plugin 'buffergrep'
		Plugin 'ingo-library'
		Plugin 'lbdbq'
		Plugin 'rename.vim'
	"}

	call vundle#end()            " required
	filetype plugin indent on    " required
" }

" Environment {
	if v:version < 703
		echoerr 'WARNING: This vimrc is written for Vim >= v.703; this is' v:version
	endif
	let s:use_plugins=1				" Enable plugin references in this rc.
	set nocompatible				" Be IMproved. Should be first.
	set viminfo+=n~/.vim/viminfo			" Write the viminfo file inside the Vim directory.
	set undodir=~/.vim/undo/			" Collect history instead of having them in '.'.
	set tags+=./tags;/				" Look for tags in current directory or search up until found.
	set encoding=utf-8				" Use Unicode inside Vim's registers, viminfo, buffers ...

	if s:use_plugins
		"call yankstack#setup()			" Allow own yank mappings by calling this before.
		"call pathogen#infect()			" Set up pathogen.
		"call pathogen#helptags()		" Generate help tags for all bundles.
	endif

	" Also use $HOME/.vim in Windows
	if has('win32') || has('win64')
		set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	endif

	let s:helper_funcs="~/.vim/helper-functions.vim"
	if filereadable(expand(s:helper_funcs))
		execute "source" . s:helper_funcs
	endif
" }

" General {
	filetype plugin indent on			" File type specific features.
	syntax enable					" Syntax highlighting but keep current colors.
	"syntax on					" Use default colors for syntax highlighting.
	set mouse=a					" Enable mouse in all modes.
	set viewoptions=folds,cursor,slash,unix		" What to save with mkview.
	set history=512					" Store much history.
	"set spell					" Enable spell highlighting and suggestions.
	set spellsuggest=best,10			" Limit spell suggestions.
	set spelllang=en_us				" Languages to do spell checking for.
	if exists("s:using_vundle")
		" Set spellfile dynamically.
		execute "set spellfile=" . "~/.vim/spell/" . matchstr(&spelllang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
	endif
	set dictionary+=~/.vim/spell/*.dic		" Use custom dictionaries.
	"set dictionary+=/usr/share/dict/words		" Use system dictionary.
	set thesaurus+=~/.vim/thesaurus/*		" Use a thesaurus file.
	"set complete-=k complete+=k			" Put the dictionaries in the normal completion set.
	set completeopt=longest,menu,preview		" Insert most common completion and show menu.
	set omnifunc=syntaxcomplete#Complete		" Omni completion.
	set shortmess=filmnrxtToOI    			" Abbreviate messages.
	set nrformats=alpha,octal,hex			" What to increment/decrement with ^A and ^X.
	set hidden					" Work with hidden buffers more easily.
	set sessionoptions-=options			" Don't store global and local variables when saving sessions.
	set undofile					" Save undo to file in undodir.
	set undolevels=2048				" Levels of undo to keep in memory.history.
	"set nomodeline					" Turn off possibly malicious Ex command execution.
	set ttyfast					" Smoother changes.
	set clipboard+=unnamed				" Use register "* instead of unnamed register.
	set timeoutlen=1500				" Timout (ms) for mappings and keycodes.
	if !has('gui_running')
		if !has('win32') && !has('win64')
			set term=$TERM       		" Make arrow and other keys work.
		endif
		if &l:term  =~ "screen.*"
			set ttymouse=xterm2		" Needed for mouse support inside GNU Screen.
		endif
	endif

	" Function keys {
		" Urxvt does not emit what Vim expects for the function keys.
		" This must be after "set term".
		" NOTE Not needed anymore it seems.
		"if !empty($TERMEMU) && $TERMEMU  =~ ".*rxvt.*"
			"set <F1>=[11~
			"set <F2>=[12~
			"set <F3>=[13~
			"set <F4>=[14~
			"set <F5>=[15~
			"set <F6>=[17~
			"set <F7>=[18~
			"set <F8>=[19~
			"set <F9>=[20~
			"set <F10>=[21~
			"set <F11>=[23~
			"set <F12>=[24~
			""set termencoding=latin1 	" This will make Meta key work if meta8 is enabled.
		"end
	" }
" }

" UI {
	if s:use_plugins
		"let g:solarized_termtrans=1			" Fix bacground problem in gnome-terminal.
		"let g:solarized_termcolors=16 			" Colors to use in solarized.
		colorscheme solarized				" Use the solarized colorscheme.
	else
		colorscheme default				" Use default color scheme.
	endif
	"set t_Co=16						" Set number of colors.
	set t_Co=256						" Set number of colors.
	"hi Normal ctermbg=NONE                                 " Transparent background.
	set title						" Show title in console title bar.
	" Adjust colors to this background.
	if has('gui_running')
		set background=light
	elseif filereadable(expand("~/.solarizedtoggle/status"))
		let &background = readfile(expand("~/.solarizedtoggle/status"), '', 1)[0]
	else
		"set background=dark
		" Lighter bg during night.
		" Source:  http://benjamintan.io/blog/2014/04/10/switch-solarized-light-slash-dark-depending-on-the-time-of-day/
		let s:hour = strftime("%H")
		if 7 <= s:hour && s:hour < 18
			set background=dark
		else
			set background=light
		endif
	endif
	set number						" Show line numbers.
	set tabpagemax=64					" Upper limit on number of tabs.
	set showmode						" Show current mode in the last line.
	set backspace=indent,eol,start				" Make backspace work like expected.
	set linespace=0						" No line spacing.
	set showmatch						" Shortly jump to a matching bracket when match.
	set wildmenu						" Enable tab-completion menu.
	set wildmode=full					" Full completion.
	set wildignorecase					" Case insensitive filename completion.
	set scrolljump=5 					" Lines to scroll when cursor leaves screen.
	set scrolloff=3 					" Minimum lines to keep above and below cursor.
	set splitbelow						" Open horizontal split below.
	set splitright						" Open vertical split to the right.
	set foldenable						" Use folding.
	"set gdefault						" Use global by default on :s
	set showcmd						" Show incomplete commands in the lower right corner.
	set ruler						" Show current cursor position in the lower right corner.
	set laststatus=2					" Always show the status line.
	set nolist						" Don't show unprintable characters.
	set listchars=eol:$,tab:>-,trail:¬,extends:>,precedes:<,nbsp:. 	" Characters to use for list.
	set cursorline						" Highlight the current line.
	"set cursorcolumn					" Highlight the current column.
	" Colors of the \cancel{hardstyle} CursorLine.
	"hi CursorLine cterm=NONE ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
	"hi CursorColumn cterm=NONE ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black

	" Statusline {
		" Not needed now when I use powerline.
		"set statusline=%t       					" Tail of the filename.
		"set statusline+=%m     					" Modified flag.
		"set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},	 	" File encoding.
		"set statusline+=%{&ff}]					" File format.
		"set statusline+=%h     					" Help file flag.
		"set statusline+=%r     					" Read only flag.
		"set statusline+=%y     					" Filetype.
		""set statusline+=['%{getline('.')[col('.')-1]}'\ \%b\ 0x%B] 	" Value of byte under cursor.
		"if s:use_plugins
			"set statusline+=%#StatusLineNC#			" Change highlight group
			"set statusline+=%{fugitive#statusline()}		" Show current branch.
			"set statusline+=%*
			"set statusline+=%{tagbar#currenttag('[#%s]','')}	" Current tag.
		"endif
		"set statusline+=%=     					" Left/right-aligned separator.
		""set statusline+=[\%b\ 0x%B]\  				" Value of byte under cursor.
		""set statusline+=[0x%O]\ 					" Byte offset from start.
		"set statusline+=%l/%L, 					" Cursor line/total lines.
		"set statusline+=%c    						" Cursor column.
		"set statusline+=\ %P   					" Percent through file.
		"set statusline+=\ 0x%B						" Character valur under cursor.
	" }
" }

" Searching {
	set hlsearch						" Highlight search.
	set incsearch						" Incremental search.
	set ignorecase						" Case insensitive search.
	set smartcase						" Smart case search.
	set nowrapscan						" Don't wrap search around file.
" }

" Formatting {
	set wrap					" Wrap long lines.
	set linebreak					" Wrap on 'breakat'-chars.
	"set showbreak=>				" Indicate wrapped lines.
	set showbreak=…					" Indicate wrapped lines.
	set autoindent					" Auto indent lines.
	set smartindent					" Indent smart on C-like files.
	set preserveindent				" Try to preserve indent structure on changes of current line.
	set copyindent					" Copy indentstructure from existing lines.
	set tabstop=8					" Let a tab be 8 spaces wide.
	set shiftwidth=8				" Tab width for auto indent and >> shifting.
	"set softtabstop=8				" Number of spaces to count a tab for on ops like BS and tab.
	set noexpandtab					" Do not expand tabs to spaces!
	set matchpairs+=<:>				" Also match <> with %.
	set formatoptions=tcroqwnl			" Formatting options.
	set cinoptions+=g=				" Left-indent C++ access labels.
	"set pastetoggle  = <Leader>p     		" Toggle 'paste' for sane pasting.
" }

" Commands {
	" Sort words on the current line.
	command! Sortline call setline(line('.'),join(sort(split(getline('.'))), ' '))
	" Write with extended privileges.
	command! Wsudo silent w !sudo tee % > /dev/null
	" Update and run make.
	command! Wmake update | silent !make >/dev/null
	" See buffer and file diff.
	command! Wdiff w !diff % -
	" Close tabs.
	command! Qt tabc

	" Change to directory of current file.
	command! Cdpwd cd %:p:h
	command! Lcdpwd lcd %:p:h

	" Write to temporary yank ring -- a low tech copy-paste.
	command! Wr w! /tmp/vim_erikw_yankring.txt
	" Read from temporary yank ring.
	command! Rr r /tmp/vim_erikw_yankring.txt

	command! -nargs=* Wrap set wrap linebreak nolist	" Set softwrap correctly.
	autocmd BufWinLeave * silent! mkview			" Save fold views.
	autocmd BufWinEnter * silent! loadview			" Load fold views on start.
	"autocmd! BufWritePost .vimrc source $MYVIMRC		" Source first found vimrc on change.
" }

" Mappings {
	let mapleader = "\\"								" The key for <Leader>.
	nmap <silent> <C-_> :nohlsearch<CR>						" Clear search matches highlighting. (Ctrl+/ => ^_)
	nmap <silent> <Leader>v :source $MYVIMRC<CR>					" Source vimrc.
	nmap <silent> <Leader>V :tabe $MYVIMRC<CR>					" Edit vimrc.
	"nmap Y y$									" Consistency with C and D. Does not work with YankRing.
	"nmap <silent> <Leader>d "=strftime("%Y-%m-%d")<CR>P 				" Insert the current date.
	noremap <silent> <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>		" Open tags definition in a new tab.
        "noremap <silent> <M-\> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>      		" Open tags definition in a vertical split.
        noremap <silent> <Leader>] :vsp<CR>:exec("tag ".expand("<cword>"))<CR>      		" Open tags definition in a vertical split.
	"nmap <silent> <Leader>S :%s/\s\+$//ge<CR>					" Remove all trailing spaces.
	nnoremap <silent> gfs :wincmd f<CR>						" Open path under cursor in a split.
	nnoremap <silent> gfv :vertical wincmd f<CR>					" Open path under cursor in a vertical split.
	nnoremap <silent> gft :tab wincmd f<CR>						" Open path under cursor in a tab.
	nnoremap <silent> gV `[v`]							" Visually select the text that was last edited/pasted.
	nnoremap <Leader>ct :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>	" Generate tags file (for OmniCppComplete).
	nnoremap g^t :tabfirst<CR>							" Go to first tab.
	nnoremap g$t :tablast<CR>							" Go to last tab.
	noremap Yf :let @" = expand("%")<CR>						" Yank current file name.
	noremap YF :let @" = expand("%:p")<CR>						" Yank current (fully expanded) file name.

	" Redraw window so search terms are centered.
	nnoremap n nzz
	nnoremap N Nzz

	" Insert one chracter.
	nmap <Space>i i_<Esc>r
	" Insert one chracter after the cursor.
	nmap <Space>a a_<Esc>r

	" Calculate current Word.
	inoremap <C-c> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

	" Enable ^d and ^u movement in completion dialog.
	inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
	inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

	if &l:term  =~ "screen.*"
		noremap <silent> <C-x>x <C-x>						" Decrement for consistency with GNU Screen.
	endif

	" Generate ctags with python site packages
	map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>

	" Movements {
		nnoremap <silent> <C-j> gj						" Down one visual line (wrapped).
		nnoremap <silent> <C-k> gk						" Up one visual line (wrapped).
		"nmap <silent> <Left> gT						" Change tab to the left.
		"nmap <silent> <Right> gt						" Change tab to the right.
		"nmap <silent> <C-p> gT							" Change tab to the left.
		"nmap <silent> <C-n> gt							" Change tab to the right.
	" }

	" Toggles {
		noremap <silent> <Leader>w :set wrap!<CR>:set wrap?<CR>				" Toggle line wrapping.
		noremap <silent> <Leader>` :set list!<CR>					" Toggle listing of characters.
		noremap <silent> <ESC>p :set paste! paste?<CR>					" Toggle 'paste' for sane pasting.
		noremap <silent> <leader>p :set paste<CR>o<ESC>:normal "*p<CR>:set nopaste<CR>	" Paste on line after in paste-mode from register "*.
		noremap <silent> <leader>P :set paste<CR>O<ESC>:normal "*P<CR>:set nopaste<CR>	" Paste on line before in paste-mode from register "*.

		noremap <silent> <Leader>ac :AutoCloseToggle<CR>				" Toggle AutoClose mode.

		" Toggle spell with a language. {
		function! ToggleSpell(lang)
			if !exists("b:old_spelllang")
				let b:old_spelllang = &spelllang
				let b:old_spellfile = &spellfile
				if exists("s:using_vundle")
					let b:old_dictionary = &dictionary
				endif
			endif

			let l:newMode = ""
			if !&l:spell || a:lang != &l:spelllang
				setlocal spell
				let l:newMode = "spell"
				execute "setlocal spelllang=" . a:lang
				if exists("s:using_vundle")
					execute "setlocal spellfile=" . "~/.vim/spell/" . matchstr(a:lang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
				endif
				execute "setlocal dictionary=" . "~/.vim/spell/" . a:lang . "." . &encoding . ".dic"
				let l:newMode .= ", " . a:lang
			else
				setlocal nospell
				let l:newMode = "nospell"
				execute "setlocal spelllang=" . b:old_spelllang
				if exists("s:using_vundle")
					execute "setlocal spellfile=" . b:old_spellfile
				endif
				execute "setlocal dictionary=" . b:old_dictionary
			endif
			return l:newMode
		endfunction
		" }
		nmap <silent> <F7> :echo ToggleSpell("en_us")<CR>			" Toggle English spell.
		nmap <silent> <F8> :echo ToggleSpell("sv")<CR>				" Toggle Swedish spell.

		" Toggle between static and relative line numbers. {
		function! ToggleLine()
			if &number
				set relativenumber
			else
				set number
			endif
		endfunction
		" }
		" Toggle static/relative line numbering.
		if v:version >= 74
			nmap <Leader>l :set relativenumber!<CR>
		else
			nmap <Leader>l :call ToggleLine()<CR>
		endif

		" Toggle Cursor {
			function! HighlightNearCursor()
				if !exists("s:highlightcursor")
					match Todo /\k*\%#\k*/
					let s:highlightcursor=1
				else
					match None
					unlet s:highlightcursor
				endif
			endfunction
		" }
		nmap <silent> <Leader>J :call HighlightNearCursor()<CR>			" Toggle highlight on cursor-word.

		" Toggle mouse {
			function! ToggleMouse()
				if &mouse == "a"
					set mouse=
				else
					set mouse=a
				endif
				set mouse?
			endfunction
		" }
		nmap <Leader>m :call ToggleMouse()<CR>					" Toggles mouse on and off.
	" }

	" Cmaps {
		" Prevent saving buffer to a file '\'.
		cmap w\ echoerr "Using a Swedish keyboard?"<CR>
	" }
" }

" Abbreviations {
	" Expand my name.
	iabbrev ew Erik Westrup
" }

" Plugins {
if s:use_plugins
	" AutoClose {
		"let g:AutoClosePairs = AutoClose#ParsePairs("() [] {} <> «» ` \" '") " Pairs to close. Does not seems to work with vundle.
		let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"]	" Syntax regions to ignore.

	" }

	" Clang Complete {
		let g:clang_auto_select = 1				" Select first entry but don't insert.
		let g:clang_complete_copen = 1				" Open quickfix on error.
		"let g:clang_periodic_quickfix = 1			" Periodically update quickfix window.
		"let g:clang_snippets = 1				" Do snippet magic.
		"let g:clang_snippets_engine = 'snipmate'		" Use snipmate for snippets.
		let g:clang_close_preview = 1				" Close preview after completion.
		let g:clang_user_options = '2>/dev/null || exit 0'	" Ignore clang errors.
		let g:clang_complete_macros = 1				" Complete preprocessor macros and constants.
		let g:clang_complete_patterns = 1			" Complete code patters e.g. loop constructs.
		"let g:clang_jumpto_declaration_key = "" 		" Disable ctags jump override.
	" }

	" Clang Format {
		let g:clang_format#auto_format = 0			" Auto format on save.
		let g:clang_format#auto_formatexpr = 1			" Let vim's formatexpr be set to clang-format (format with gq).
		autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

		" Git pull request for this: https://github.com/rhysd/vim-clang-format/pull/17
		function! ClangFormatAutoToggleFunc()
			if !exists("g:clang_format#auto_format") || g:clang_format#auto_format == 0
				let g:clang_format#auto_format = 1
				echo "Auto clang-format: enabled"
			else
				let g:clang_format#auto_format = 0
				echo "Auto clang-format: disabled"
			endif
		endfunction
		" Toggle auto clang-format.
		command! ClangFormatAutoToggle call ClangFormatAutoToggleFunc()
		nmap <Leader>C :ClangFormatAutoToggle<CR>
	"}

	" Eclim {
		let g:EclimXmlValidate=0			" Don't validate XML-files on write.
	" }

	" Fugative {
		autocmd BufReadPost fugitive://* set bufhidden=delete	" Close Fugative buffers when leaving.
	" }

	" FuzzyFinder {
		let g:fuf_dataDir = '~/.vim/fuf-data'			" Where to put stored data.
		"let g:fuf_keyOpenSplit = '<C-s>'			" How to open file in split.
		"let g:fuf_keyOpenVsplit = '<C-v>'			" Open file in vertical split.
		"let g:fuf_keyOpenTabpage = '<C-t>'			" Open in new tab.
		" Comments can't be after the mapping, that starts the fuzzyview in normal mode.
		" Launch File-mode.
		noremap <silent> ,f :FufFile<CR>
		" Launch Buffer-mode.
		noremap <silent> ,b :FufBuffer<CR>
		" Launch Dir-mode.
		noremap <silent> ,d :FufDir<CR>
		" Launch Tag-mode
		noremap <silent> ,t :FufTag<CR>
		" Launch Tag-mode with current word.
		noremap <silent> ,tw :FufTagWithCursorWord<CR>
		" Launch with Filecoverage-mode.
		noremap <silent> ,c :FufCoverageFile<CR>
	" }

	" Gist {
		let g:gist_detect_filetype = 1				" Detect filetype from name.
		let g:gist_show_privates = 1				" Let Gist -l show private gists.
		"let g:gist_clip_command = 'xclip -selection clipboard'	" Copy command.
		"let g:gist_private = 1					" Make private the default for new Gists.
		"let g:gist_open_browser_after_post = 1			" Open in browser after post.
		"let g:gist_browser_command = 'w3m %URL%'		" Browser to use.
		let g:gist_browser_command = 'firefox  %URL%'		" Browser to use.
	" }

	" Gundo {
		nmap <silent> <F4> :GundoToggle<CR>		" Toggle Gundo.
		let g:gundo_close_on_revert=1			" Automatically close on revert.
		let g:gundo_preview_bottom=1			" Draw preview below current window.
	" }

	" Jedi {
		"let g:jedi#auto_initialization = 0  " Don't autoload jedi.
		let g:jedi#use_tabs_not_buffers = 1  " Go to a tab when opening a definition.
		"let g:jedi#popup_on_dot = 0	" Do't autostart completion when typing a periond.
		"let g:jedi#show_call_signatures = 1	" 0 = now signature preview, 1 = signature in split buffer, 2 = ?


	" }

	" LanguageTool {
		let g:languagetool_jar='/usr/share/java/languagetool/languagetool-commandline.jar'
	" }

	" NERDCommenter {
	" Swap invert comment toggle.
		"map <silent> <Leader>c<Space> <plug>NERDCommenterInvert
		"map <silent> <Leader>ci <plug>NERDCommenterToggle
	" }

	" NERDTree {
		noremap <silent> <F2> :NERDTreeToggle<CR>	" Toggle the NERDTree file browser.
		let g:NERDTreeCaseSensitiveSort=1		" Sort case sensitive.
		let g:NERDTreeMouseMode=3			" Single click opens folders and files.
		let g:NERDTreeQuitOnOpen=1			" Close tree after open.
	" }

	" OmniCppComplete {
		"let OmniCpp_ShowPrototypeInAbbr = 1 	" Show whole prototype (inc. parameters).
		"let OmniCpp_ShowScopeInAbbr = 1 	" Show the scope.
	" }

	" Pathogen {
		nmap <silent> <Leader>H :call pathogen#helptags()<CR>		" Generate help tags for all bundles.
	" }

	" Powerline {
		" Check if vim plugin exists, e.g. debian's powerline does not
		" currently have it.
		if isdirectory($POWERLINE_ROOT . "/bindings/vim")
			python from powerline.vim import setup as powerline_setup
			python powerline_setup()
			python del powerline_setup
		endif
	" }

	" Rope {
		let g:ropevim_enable_autoimport = 1 	" Enable the RopeAutoImport command.
		let g:ropevim_autoimport_modules = ["os.*","shutil","random","django.*","rest_framework.*",]
	" }

	" Solarized {
		"call togglebg#map("<Leader>%")		" Toggle background with solarized. Not nice because it maps in insert mode too.
		call togglebg#map("<F5>")		" Toggle background with solarized.
	" }

	" Syntastic {
		"let g:syntastic_check_on_open=0		" Don't automatically do syntax check on open buffers.
		"let g:syntastic_check_on_wq=0		" Don't save on write.
		noremap <silent> <F11> :SyntasticToggleMode<CR>					" Toggle syntastic checking.
		" Do syntax check on files with exceptions (passive ones).
		let g:syntastic_mode_map = { 'mode': 'active',
		                        \ 'active_filetypes': [],
		                        \ 'passive_filetypes': ['java', 'python'] }
		" Python, use prospector.
		let g:syntastic_python_checkers = ['prospector']
	" }

	" Tagbar {
		nmap <silent> <F3> :TagbarToggle<CR>		" Toggle the Tagbar window.
		let g:tagbar_left		= 0		" Keep the window on the right side.
		let g:tagbar_width		= 30		" Width of window.
		let g:tagbar_autoclose		= 1		" Close tagbar when jumping to a tag.
		let g:tagbar_autofocus		= 1		" Give tagbar focus when it's opened.
		let g:tagbar_sort		= 1		" Sort tags alphabetically.
		let g:tagbar_compact		= 1		" Omit the help text.
		let g:tagbar_singleclick	= 1 		" Jump to tag with a single click.
		let g:tagbar_autoshowtag	= 1		" Open folds if tag is not visible.
	" }

	" Taglist {
		"nmap <silent> <F3> :Tlist<CR>				 	" Toggle the Tlist browser.
		""let g:Tlist_Close_On_Select        = 1			" Close list on tag selection.
		"let g:Tlist_Auto_Update             = 1			" Update newly opend files.
		"let g:Tlist_Compact_Format          = 1			" Trim spaces in GUI.
		"let g:Tlist_Auto_Highlight_Tag      = 1			" Highlight tags.
		"let g:Tlist_GainFocus_On_ToggleOpen = 1			" Move cursor to list on open.
		"let g:Tlist_Sort_Type               = "name"		" Sort by name instead of definition order.
		"let g:Tlist_Use_SingleClick         = 1			" Jump to definition with a single click.
		"let g:Tlist_Show_One_File           = 1			" Only show current buffers tags.
		"let g:Tlist_Use_Right_Window        = 1			" Display on the right.
		""let g:Tlist_Display_Prototype      = 1			" Show prototypes instead of tags.
		"let g:Tlist_Exit_OnlyWindow         = 1			" Close Vim if only Tlist open.
	" }

	" Tasklist {
		nmap <Leader>T <Plug>TaskList		" Open TaskList. Default mapping interferes with Command-T.
	" }

	" YankRing {
		nmap <silent> <Leader>y :YRShow<CR>		" Toggle YankRing.
		let g:yankring_enabled = 1 			" Enable the yankring.
		let g:yankring_max_history = 128		" Number of items to save.
		let g:yankring_share_between_instances = 1	" Reuse the ring.
		let g:yankring_window_auto_close = 1		" Close YR after action.
		let g:yankring_window_use_horiz = 1		" Use horizontal split
		let g:yankring_window_height = 10		" The window heigth.
		let g:yankring_window_use_bottom = 1		" Split to bottom.
		let g:yankring_manage_numbered_reg = 1		" Still update the default registers.
		let g:yankring_history_dir = '~/.vim/'		" Where to put the yankfile.
		let g:yankring_history_file = 'yankring'	" Filename of the yankfile.
		let g:yankring_default_menu_mode = 3		" Let alt+y activate the menu.

		let g:yankring_paste_using_g = 0		" Don't remap gp and gP.
		let g:yankring_replace_n_pkey = "[p"		" Cycle backwards in yankring on paste.
		let g:yankring_replace_n_nkey = "]p"		" Cycle forwards in yankring on paste.

		" Not anymore
		"let g:yankring_clipboard_monitor = 1		" YR and Vim X-connection does not work. Start with -X
		"set clipboard=exclude:.*			" X is incompatible with YankRing at the moment.
	" }

	" YankStack {
		"let g:yankstack_map_keys = 0		" Don't make mappings for me.
		"nmap [p    <Plug>yankstack_substitute_older_paste
		"nmap ]p    <Plug>yankstack_substitute_newer_paste
		"imap <M-y> <Plug>yankstack_substitute_older_paste
		"imap <M-Y> <Plug>yankstack_substitute_newer_paste
		""imap <C-y> <Plug>yankstack_insert_mode_paste
	"}
endif
" }

" Source local {
	if filereadable(expand("~/.vimrc.local"))
		source ~/.vimrc.local
	endif
" }
