" ===
" ===  autocmd markdown snippets
" ===
autocmd Filetype markdown imap <buffer> ,f <Esc>/<++><cr>:nohlsearch<cr>"_c4l
autocmd Filetype markdown imap <buffer> ,w <Esc>/ <++><cr>:nohlsearch<cr>"_c5l<cr>
autocmd Filetype markdown imap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown imap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown imap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown imap <buffer> ,t <center></center> <++><Esc>F/hi
autocmd Filetype markdown imap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown imap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown imap <buffer> ,t <center></center><++><Esc>F/hi
autocmd Filetype markdown imap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown imap <buffer> ,m - [ ]
autocmd Filetype markdown imap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown imap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown imap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown imap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown imap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown imap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown imap <buffer> ,l --------<Enter>
