"  __  __         _   ___     _____ __  __ ____   ____
" |  \/  |_   _  | \ | \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | | |  \| |\ \ / / | || |\/| | |_) | |
" | |  | | |_| | | |\  | \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, | |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"         |___/


" Author: @hare


" === 
" ===  Auto load for first time uses
" === 
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === python Supports
" ===
if has("win32")||has("win64")
	let g:python_host_prog='C:\Users\root\Anaconda2\python.exe'
	let g:python3_host_prog='C:\Program Files (x86)\Python36-32\python3.exe'
else
	let g:python_host_prog='/usr/bin/python'
	let g:python3_host_prog='/usr/local/bin/python3'
endif


" ===
" === Functions
" ===
function! BuildComposer(info)
	if a:info.status != 'unchanged' || a:info.force
		if has('nvim')
			!cargo build --release --locked
		else
			!cargo build --release --locked --no-default-features --features json-rpc
		endif
	endif
endfunction

function! RUN()
	exec "w"
	if &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype =='markdown'
		exec 'InstantMarkdownPreview'
	endif
endfunction

function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber number
	else
		set relativenumber
	endif
endfunc

function ScriptHeader()
	if &filetype == 'python'
		let header = '#!/usr/bin/env python'
		let cfg = '# vim: ts=4 sw=4 sts=4 expandtab'
	elseif &filetype == 'sh'
		let header = '#!/bin/bash'
	endif
	let line = getline(1)
	if line == header
		return
	endif
	"normal m'
	call append(0,header)
	if &filetype == 'python'
		call append(2,cfg)
	endif
	"normal ''
endfunction


" ===
" === editor Settings
" ===
set background=dark
set list
set listchars=tab:>-,eol:<,nbsp:%
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

set ruler
set number
set showcmd
set showmode
set scrolloff=20
set cursorline
set cursorcolumn
set nowrap
set relativenumber
set hidden
set cmdheight=2
set updatetime=100
set shortmess+=c
set splitbelow
set splitright
if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif


" ===
" === search Settings
" ===
set hlsearch
set incsearch
set ignorecase
set smartcase


" ===
" === indent Settings
" ===
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set shiftround
syntax enable
syntax on
filetype off
filetype plugin on
filetype indent on
filetype plugin indent on
set smartindent
set autoread


" ===
" === No backup files
" ===
set nobackup
set noswapfile
set nowritebackup
set noundofile



" ===
" === Plugins
" ===
call plug#begin('$HOME/.config/nvim/plugged')

Plug 'bling/vim-airline'

" Colorscheme
Plug 'bigeagle/molokai'
Plug 'theniceboy/vim-deus'

Plug 'scrooloose/nerdcommenter'
Plug 'mhinz/vim-startify' "start screen
Plug 'kshenoy/vim-signature' "bookmark
"Plug 'terryma/vim-multiple-cursors'
"Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle' } "lazy loading must be enabled

" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown' }
"Plug 'euclio/vim-markdown-composer', { 'for': 'markdown', 'do': function('BuildComposer') }

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'davidhalter/jedi-vim', {'for': 'python' } "python autocompletion

" Other useful things
Plug 'lambdalisue/suda.vim' "sudo in nvim, use :w sudo://% to force write

call plug#end()

"colorscheme molokai
colorscheme deus

" ===
" === <leader> Settings
" ===
let mapleader=";"


" ===
" === key Bindings
" ===
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>l :set list!<CR>
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>W :w sudo://%<CR>
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>
nmap <leader>g ggVG
"map <F2> :NERDTreeToggle<CR>
map <F2> :CocCommand explorer<CR>
vmap <leader>s :'<,'>sort<CR>
map <F5> :call RUN()<CR>
nmap <leader>n :call NumberToggle()<CR>


" ===
" === coc.nvim Settings
" ===
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-python', 'coc-explorer']
let g:coc_disable_startup_warning = 1
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? "\<C-n>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
	inoremap <silent><expr> <c-l> coc#refresh()
else
	inoremap <silent><expr><c-@> coc#refresh()
endif

" Use <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  else
	call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Applying codeAction to the selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line
"nmap <leader>qf <Plug>(coc-fix-current)


" ===
" === vim-airline Settings
" ===
let g:airline_theme='dark'
let g:airline_powerline_font=1


" ===
" === markdown-composer Settings
" ===
let g:markdown_composer_autostart = 0
let g:markdown_composer_open_browser = 1


" ===
" === gonvim Settings
" ===
let g:gonvim_start_fullscreen = 1


" ===
" === nerdtree Settings
" ===
let NERDTreeMinimalUI=0
let NERDTreeQuitOnOpen=0
let NERDChristmasTree=0
let NERDTreeDirArrows=1


" ===
" === suda Settings
" ===
let g:suda#prefix = 'sudo://'


" ===
" === autocmd Markdown Snippets
" ===
autocmd Filetype markdown imap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown imap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
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


" ===
" === autocmd VimL Snippets
" ===
autocmd FileType vim imap <buffer> ,t " ===<Esc>yyppkA 


" ===
" === python Settings
" ===
autocmd BufNewFile *.py call ScriptHeader()
autocmd BufNewFile *.sh call ScriptHeader()


" ===
" ===  autocmd Settings
" ===
autocmd! bufwritepost $MYVIMRC source %
