" ===
" ===  basic keybindings
" ===
let mapleader=" "
noremap ; :

noremap Q :q<cr>
noremap <C-q> :qa<cr>
noremap S :w<cr>
" close the window below the current window
noremap <leader>q <C-w>j:q<cr>


" copy and paste
vnoremap <leader>y "+y
noremap <leader>p "+p

" indentation
nnoremap < <<
nnoremap > >>

" add new line below/above
noremap <leader>o o<Esc>xx
noremap <leader>O O<Esc>xx

" select all text
noremap <leader>g ggVG

" search
noremap <leader><cr> :nohlsearch<cr>

" open the vimrc file anytime
noremap <leader>rc :e $HOME/.config/nvim/init.vim<cr>

" sort selected lines
vnoremap <leader>s :'<,'>sort<cr>

" resize splits with arrow keys
noremap <up>:res +5<cr>
noremap <down>:res -5<cr>
noremap <left>:vertical resize-5<cr>
noremap <right>:vertical resize+5<cr>

" place the two screens up and down
noremap sh <C-w>t<C-w>K
" place the two screens side by side
noremap sv <C-w>t<C-w>H

" press <leader> twice to jump to the next '<++>' and edit it
noremap <leader><leader> <esc>/<++><cr>:nohlsearch<cr>c4l

" spell check
noremap <leader>sc :set spell!<cr>

" call figlet
noremap tx :r !figlet

" find and replace
noremap \s :%s//g<left><left>

" number toggle
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber number
	else
		set relativenumber
	endif
endfunc
noremap <leader>n :call NumberToggle()<cr>

" compile & run
function! CompileNRun()
	exec "w"
	if &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'markdown'
		exec 'InstantMarkdownPreview'
	elseif &filetype == 'sh'
		set splitbelow
		:sp
		:term
	elseif &filetype =='html'
		silent! !open %
	endif
endfunction
noremap <F5> :call CompileNRun()<cr>



noremap <leader>l :set list!<cr>
noremap <leader>h :echo has("")<left><left>

 "noremap qf <C-w>o
" disable the default s key
 noremap s <nop>

 " split the screens to up, down, left, right
 " noremap su :set nosplitbelow<cr>:split<cr>:set splitbelow<cr>
 " noremap se :set splitbelow<cr>:split<cr>
 " noremap sn :set nosplitright<cr>:vsplit<cr>:set splitright<cr>
 " noremap si :set splitright<cr>:vsplit<cr>

