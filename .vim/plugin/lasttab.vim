" Toggle the last used tab.
let g:lasttab = 1
nmap <C-^> :execute "tabnext ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()
