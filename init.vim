"  __  __         _   ___     _____ __  __ ____   ____
" |  \/  |_   _  | \ | \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | | |  \| |\ \ / / | || |\/| | |_) | |
" | |  | | |_| | | |\  | \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, | |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"         |___/
" 
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'
"let g:python3_host_prog='/usr/bin/python3'
set nocompatible



" ##########
" Functions
" ##########
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
		exec "!python %"
	endif
endfunction

function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber number
	else
		set relativenumber
	endif
endfunc



" ########
" Plugins
" ########
call plug#begin('~/.local/share/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'bigeagle/molokai'
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle' } "lazy loading must be enabled
Plug 'mhinz/vim-startify' "start screen
Plug 'kshenoy/vim-signature' "bookmark
"Plug 'davidhalter/jedi-vim', {'for': 'python' } "python autocompletion
"Plug 'w0rp/ale'
"Plug '/usr/local/opt/fzf'
"Plug 'junegunn/fzf.vim'
"Plug 'terryma/vim-multiple-cursors'
Plug 'euclio/vim-markdown-composer', { 'for': 'markdown', 'do': function('BuildComposer') }
Plug 'lambdalisue/suda.vim' "sudo in nvim, use :w sudo://% to force write
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme molokai

set background=dark
set list lcs=tab:>-,eol:<,nbsp:%

set ruler
set number
set showcmd
set showmode
set scrolloff=10
set cursorline
set cursorcolumn
set nowrap
set relativenumber
set hidden
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=number


set hlsearch
set incsearch
set ignorecase
set smartcase


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

" ################
" No backup files
" ################
set nobackup
set noswapfile
set nowritebackup
set noundofile

" ##################
" <leader> Settings
" ##################
let mapleader=';'
vnoremap <leader>y "+y
nmap <leader>p "+p
nmap <leader>l :set list!<CR>
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>W :w sudo://%<CR>
nmap <leader>h :help
nmap <leader>o o<ESC>
nmap <leader>O O<ESC>
nmap <leader>g ggVG
map <F2> :NERDTreeToggle<CR>
vmap <leader>s :'<,'>sort<CR>
map <F5> :call RUN()<CR>
nnoremap <leader>n :call NumberToggle()<CR>


" ##################
" coc.nvim Settings
" ##################
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-jedi', 'coc-explorer']
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
inoremap <silent><expr> <c-l> coc#refresh()
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
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
nmap <leader>qf <Plug>(coc-fix-current)



" #####################
" vim-airline Settings
" #####################
let g:airline_theme='dark'
let g:airline_powerline_font=1



" ###########################
" markdown-composer Settings
" ###########################
let g:markdown_composer_autostart = 1
let g:markdown_composer_open_browser = 1



" ################
" gonvim Settings
" ################
let g:gonvim_start_fullscreen = 1



" ##############
" suda Settings
" ###############
let g:suda#prefix = 'sudo://'

" ##########################
" autocmd Markdown Snippets
" ##########################
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,t <center></center> <++><Esc>F/hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>



" #################
"  Python Settings
" #################

autocmd BufNewFile *.py call ScriptHeader()
autocmd BufNewFile *.sh call ScriptHeader()

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



" ##################
"  autocmd Settings
" ##################
autocmd! bufwritepost .vimrc source %
