"    __  __         _       _ _         _           
"   |  \/  |_   _  (_)_ __ (_) |___   _(_)_ __ ___  
"   | |\/| | | | | | | '_ \| | __\ \ / / | '_ ` _ \ 
"   | |  | | |_| | | | | | | | |_ \ V /| | | | | | |
"   |_|  |_|\__, | |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"           |___/                                   

" Author: @hare

" ===
" ===  todos
" ===
" remove nvim vertical line between windows
" change tagbar to vista.vim
" add python language server for deoplete.vim
" HHKB arrow key in vim
" add vim-snippets
" add vim-codefmt
" tmux backgroud color

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
" ===  create a _machine_specific.vim file to adjusf machine specific stuff
" ===
let has_machine_specific_file = 1
if empty(glob('$HOME/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec '!cp $HOME/.config/nvim/default_configs/_machine_specific_default.vim
				\ $HOME/.config/nvim/_machine_specific.vim'
endif
source $HOME/.config/nvim/_machine_specific.vim


" ===
" ===  functions
" ===

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
	call append(0,header)
	if &filetype == 'python'
		call append(2,cfg)
	endif
endfunction


" ===
" ===  editor settings
" ===
syntax enable
syntax on
set t_ut=
set background=dark
set termguicolors " if dont set this option, color might not right
set list
set listchars=tab:\|\ ,eol:<,nbsp:%,trail:▫
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set conceallevel=2
set laststatus=2
"set statusline

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
set textwidth=79
set splitbelow
set splitright
set wildmenu
set autochdir
"set lazyredraw
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
set expandtab
set autoindent
set shiftround
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

	" dein
	call dein#add(s:dein_path.'/repos/github.com/Shougo/dein.vim')
	call dein#add('wsdjeg/dein-ui.vim')
	call dein#add('haya14busa/dein-command.vim')

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
	"call dein#add('google/vim-maktaba')
	"call dein#add('google/vim-codefmt')
	"call dein#add('google/vim-glaive')

    " git
    call dein#add('airblade/vim-gitgutter')
    call dein#add('cohama/agit.vim')
    call dein#add('kdheepak/lazygit.nvim')

	" markdown
	call dein#add('suan/vim-instant-markdown')
	call dein#config('vim-instant-markdown', {
				\ 'lazy': 1, 'on_ft': 'markdown',
				\ })
	call dein#add('mzlogin/vim-markdown-toc')
	call dein#config('vim-markdown-toc', {
				\ 'lazy': 1, 'on_ft': 'markdown',
				\ })
	call dein#add('dhruvasagar/vim-table-mode')

	" tagbar
	"call dein#add('majutsushi/tagbar')
	call dein#add('liuchengxu/vista.vim')

	" leetcode
	call dein#add('ianding1/leetcode.vim')

    " undo tree
    call dein#add('mbbill/undotree')

	" status line
	call dein#add('theniceboy/eleline.vim')
	"call dein#add('itchyny/lightline.vim')

	" other useful plugins
	call dein#add('lambdalisue/suda.vim')
	call dein#add('tpope/vim-surround')
	call dein#add('junegunn/goyo.vim')
	call dein#config('goyo.vim', {
				\ 'lazy': 1,
				\ 'on_ft': ['txt', 'markdown'],
				\ })
	call dein#add('scrooloose/nerdcommenter') " comment
	call dein#add('mhinz/vim-startify')
	call dein#add('kshenoy/vim-signature')
	call dein#add('junegunn/vim-after-object') " da= to delete what's after =

	call dein#end()
	call dein#save_state()
endif

" auto install plugins
if dein#check_install()
	call dein#install()
endif

filetype plugin indent on


"colorscheme molokai
"colorscheme deus
"colorscheme onedark
colorscheme horizon


" ===
" ===  key bindings
" ===
source $HOME/.config/nvim/_basic_keybindings.vim
noremap <leader>W :w sudo://%<cr>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)
nmap <F2> :Defx <cr>
"nmap <F4> :call ChangeTheme()<cr>
nnoremap <silent> <F8> :TagbarToggle<cr>
nmap <leader>rp :call map(dein#check_clean(), "delete(v:val, 'rf')")<cr>
"nmap <leader>rc :call dein#recache_runtimepath()<cr>


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
"let g:airline_theme='dark'
"let g:airline_powerline_font=1


" ===
" ===  vim-startify settings
" ===
let g:startify_custom_header = [
			\ "   _                    _                  _                  ",
			\ "  | |__   __ _ _ __ ___( )___   _ ____   _(_)_ __ ___         ",
			\ "  | '_ \\ / _` | '__/ _ \\// __| | '_ \\ \\ / / | '_ ` _ \\   ",
			\ "  | | | | (_| | | |  __/ \\__ \\ | | | \\ V /| | | | | | |    ",
			\ "  |_| |_|\\__,_|_|  \\___| |___/ |_| |_|\\_/ |_|_| |_| |_|    ",
			\ "                                                              ",
			\ ]
" ===
" ===  lightline settings
" ===
"let g:lightline = {'colorscheme': 'horizon'}


" ===
" ===  vim-instant-markdown settings
" ===
"let g:instant_markdown_slow = 1
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_port = 8888
autocmd VimLeave *.md silent exec "InstantMarkdownStop"
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_python = 1


" ===
" ===  vim-table-mode settings
" ===
noremap <leader>tm :TableModeToggle<cr>
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" ===  goyo settings
" ===
map <leader>gy :Goyo<cr>


" ===
" ===  vim-after-object settings
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


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
" ===  vista.vim settings
" ===
noremap <leader>v :Vista!!<cr>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista_default_executive = 'coc'
"let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
let g:scrollstatus_size = 15


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

source $HOME/.config/nvim/snippets/md_snippets.vim
source $HOME/.config/nvim/snippets/vim_snippets.vim


" ===
" ===  python settings
" ===
autocmd BufNewFile *.py call ScriptHeader()
autocmd BufNewFile *.sh call ScriptHeader()


" ===
" ===  autocmd settings
" ===
autocmd! BufWritePost $MYVIMRC source %
"autocmd! bufwritepost $MYVIMRC call lightline#init()
"autocmd! bufwritepost $MYVIMRC call lightline#colorscheme()
" auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
