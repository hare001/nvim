" ===
" ===  autocmd viml snippets
" ===
autocmd Filetype vim imap <buffer> ,f <Esc>/<++><cr>:nohlsearch<cr>"_c4l
autocmd Filetype vim imap <buffer> ,w <Esc>/ <++><cr>:nohlsearch<cr>"_c5l<cr>
autocmd FileType vim imap <buffer> ,t <++><Esc>O"<space>===<Esc>yyPPjA<space><space>
autocmd FileType vim imap <buffer> ,da call dein#add('')<Esc>hi
