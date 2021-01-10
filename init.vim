"  __  __         _   ___     _____ __  __ ____   ____
" |  \/  |_   _  | \ | \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | | |  \| |\ \ / / | || |\/| | |_) | |
" | |  | | |_| | | |\  | \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, | |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"         |___/


" Author: @hare

" ===
" ===  todos
" ===
" remove nvim vertical line between windows
" fix status line bug
" add python language server for deoplete.vim


" ===
" ===  autoload for first time uses
" ===
if empty(glob('$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim'))
	silent !curl -fLo $HOME/.config/nvim/install.sh --create-dirs
				\ https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
	silent !sh ./installer.sh $HOME/.config/nvim/dein
	autocmd VimEnter * :call dein#install() | source $MYVIMRC
endif


" ===
" ===  python supports
" ===
if has('mac')
	let g:python_host_prog='/usr/bin/python'
	let g:python3_host_prog='/usr/local/bin/python3'
endif


" ===
" ===  functions
" ===
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

"function ChangeTheme()
	"if g:colors_name == 'deus'
		"colorscheme horizon
	"elseif g:colors_name == 'horizon'
		"colorscheme onedark
	"else
		"colorscheme deus
	"endif
"endfunction


" ===
" ===  editor settings
" ===
set background=dark
set termguicolors " if dont set this option, color might not right
set list
set listchars=tab:\|\ ,eol:<,nbsp:%,trail:▫
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set conceallevel=2
"set statusline
"set fillchars=stl:-
"set fillchars+=stlnc:-
"set fillchars+=vert:\|

set ruler
set number
set showcmd
set noshowmode
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
set wildmenu
set autochdir
if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif


" ===
" ===  search settings
" ===
set hlsearch
set incsearch
set ignorecase
set smartcase


" ===
" ===  indent settings
" ===
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set shiftround
syntax enable
syntax on
"filetype off
"filetype plugin on
"filetype indent on
set smartindent
set autoread


" ===
" ===  no backup files
" ===
set nobackup
set noswapfile
set nowritebackup
set noundofile


" ===
" ===  ignore files
" ===
set wildignore+=*DS_Store
set wildignore+=*.git
set wildignore+=*.png,*.jpg,*.gif,*.jpeg


if &compatible
	set nocompatible
endif


" ===
" ===  plugins
" ===
let s:dein_path = '~/.config/nvim/dein'

" Add the dein installation directory into runtimepath
let &runtimepath = &runtimepath.','.s:dein_path.'/repos/github.com/Shougo/dein.vim'

if dein#load_state(s:dein_path)
	call dein#begin(s:dein_path)

	call dein#add(s:dein_path.'/repos/github.com/Shougo/dein.vim')

	" install third-party plugins
	" call dein#add('tpope/vim-surround')

	" colorscheme
	call dein#add('theniceboy/vim-deus')
	call dein#add('bigeagle/molokai')
	call dein#add('altercation/vim-colors-solarized')
	call dein#add('danilo-augusto/vim-afterglow')
	call dein#add('joshdick/onedark.vim')
	call dein#add('ntk148v/vim-horizon')

	" auto completion
	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#add('deoplete-plugins/deoplete-jedi')
	call dein#add('Shougo/neco-vim')
	call dein#add('jiangmiao/auto-pairs')
	call dein#add('autozimu/LanguageClient-neovim', {
				\ 'rev': 'next',
				\ 'build': 'bash install.sh',
				\ })

	" file explorer
	call dein#add('Shougo/defx.nvim')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#add('kristijanhusak/defx-icons')

	" auto format
	call dein#add('Chiel92/vim-autoformat')

	" markdown
	call dein#add('suan/vim-instant-markdown')
	"call dein#config('vim-instant-markdown', {
				"\ 'lazy': 1, 'on_ft': 'markdown',
				"\ })
	call dein#add('mzlogin/vim-markdown-toc')
	"call dein#config('vim-markdown-toc', {
				"\ 'lazy': 1, 'on_ft': 'markdown',
				"\ })

	" tagbar
	call dein#add('majutsushi/tagbar')

	" leetcode
	call dein#add('ianding1/leetcode.vim')

	" other useful plugins
	call dein#add('lambdalisue/suda.vim')
	call dein#add('tpope/vim-surround')
	"call dein#add('bling/vim-airline')
	call dein#add('itchyny/lightline.vim')
	call dein#add('scrooloose/nerdcommenter') " comment
	call dein#add('mhinz/vim-startify')
	call dein#add('kshenoy/vim-signature')
	call dein#add('wsdjeg/dein-ui.vim')

	call dein#end()
	call dein#save_state()
endif


filetype plugin indent on


"colorscheme molokai
"colorscheme deus
"colorscheme onedark
colorscheme horizon


" ===
" ===  <leader> settings
" ===
let mapleader=";"


" ===
" ===  key bindings
" ===
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>l :set list!<cr>
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>
nmap <leader>W :w sudo://%<cr>
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>
nmap <leader>g ggVG
nmap <leader>h :echo has("")<left><left>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" popup
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)
vmap <leader>s :'<,'>sort<cr>
nmap <leader>n :call NumberToggle()<cr>
nmap <F2> :Defx <cr>
"nmap <F4> :call ChangeTheme()<cr>
map <F5> :call CompileNRun()<cr>
nnoremap <silent> <F8> :TagbarToggle<cr>
nmap <leader>rp :call map(dein#check_clean(), "delete(v:val, 'rf')")<cr>
nmap <leader>rc :call dein#recache_runtimepath()<cr>


" ===
" === deoplete settings
" ===
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
			\ 'smart_case': v:true,
			\ 'auto_complete_delay': 100
			\ })
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
call deoplete#custom#option('sources', {
			\ 'cpp': ['LanguageClient'],
			\ 'c': ['LanguageClient'],
			\ 'vim': ['vim'],
			\ 'zsh': ['zsh'],
			\ 'python': ['pyls']
			\ })


" ===
" ===  defx settings
" ===
let g:defx_icons_enable_syntax_hightlight = 0
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 1
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_copy_icon = ''
let g:defx_icons_move_icon = ''
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
" Options below are applicable only when using "tree" feature
let g:defx_icons_root_opened_tree_icon = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''
call defx#custom#option('_', {
			\ 'columns': 'icons:git:indent:filename:type',
			\ 'winwidth': 30,
			\ 'split': 'vertical',
			\ 'direction': 'topleft',
			\ 'listed': 1,
			\ 'ignored_files': '.git,.svn,.__pycache__,.sass-cache,.DS_Store,*.pyc,*.swp,.netrwhist,.gitignore',
			\ 'show_ignored_files': 0,
			\ 'buffer_name': '',
			\ 'toggle': 1,
			\ 'resume': 1
			\ })
autocmd FileType defx call s:defx_mappins()
autocmd BufWritePost * call defx#redraw()

function! s:defx_mappins() abort
	nnoremap <silent><buffer><expr> <cr> defx#do_action('open_tree', 'toggle')
	nnoremap <silent><buffer><expr> <2-LeftMouse> defx#do_action('open', ['drop'])
	nnoremap <silent><buffer><expr> l defx#do_action('drop')
	nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> d defx#do_action('remove')
	nnoremap <silent><buffer><expr> r defx#do_action('rename')
	nnoremap <silent><buffer><expr> N defx#do_action('new_file')
	nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P defx#do_action('search', fnamemodify(defx#get_candidate().action__path, ':h'))
	nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> <C-r> defx#do_action('redraw')
endfunction


" ===
" ===  vim-airline settings
" ===
let g:airline_theme='dark'
let g:airline_powerline_font=1


" ===
" ===  lightline settings
" ===
let g:lightline = {'colorscheme': 'horizon'}


" ===
" ===  instant-markdown settings
" ===
"let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
let g:instant_markdown_port = 8888
autocmd VimLeave *.md silent exec "InstantMarkdownStop"
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_python = 1


" ===
" ===  gonvim settings
" ===
let g:gonvim_start_fullscreen = 1


" ===
" ===  nerdtree settings
" ===
let NERDTreeMinimalUI=0
let NERDTreeQuitOnOpen=0
let NERDChristmasTree=0
let NERDTreeDirArrows=1


" ===
" ===  tagbar settings
" ===
let g:tagbar_position='botright vertical'
let g:tagbar_iconchars = ['▶', '▼']
let g:tagbar_width=30


" ===
" ===  suda settings
" ===
let g:suda#prefix = 'sudo://'


" ===
" ===  auto-pairs settings
" ===
autocmd Filetype html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->', '<' : '>'})
autocmd Filetype php let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php' : '?>'})
autocmd Filetype vim let b:AutoPairs = AutoPairsDefine({}, ['"'])
let g:AutoPairsFlyMode = 1


" ===
" ===  autoformat settings
" ===
"let g:autoformat_verbosemode = 1
"autocmd BufWrite *.sql,*.c,*.py,*.java,*.js,*.html,*.yaml,*.toml :Autoformat
noremap <F3> :Autoformat<cr>


" ===
" ===  leetcode settings
" ===
let g:leetcode_china=1
let g:leetcode_browser='chrome'
let g:leetcode_solution_filetype='python3'
let g:leetcode_hide_paid_only=1
let g:leetcode_hide_companies=1
let g:leetcode_hide_topics=1
nnoremap <leader>ll :LeetCodeList<cr>
nnoremap <leader>lt :LeetCodeTest<cr>
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>li :LeetCodeSignIn<cr>

source $HOME/.config/nvim/snippets/markdown_snippets.vim
source $HOME/.config/nvim/snippets/vim_snippets.vim


" ===
" ===  python settings
" ===
autocmd BufNewFile *.py call ScriptHeader()
autocmd BufNewFile *.sh call ScriptHeader()


" ===
" ===  autocmd settings
" ===
autocmd! bufwritepost $MYVIMRC source %
"autocmd! bufwritepost $MYVIMRC call lightline#init()
autocmd! bufwritepost $MYVIMRC call lightline#colorscheme()
