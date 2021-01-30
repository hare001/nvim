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
" HHKB arrow key in vim
" add vim-snippets
" add vim-codefmt
" add ag.vim
" add w0rp/ale


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
function SetTitle()
    if &filetype == 'sh'
        call append(0, '#!/bin/bash')
        call append(1, '#Author: @hare')
        call append(2, '#Time:'.strftime('%F %T'))
        call append(3, '#Name:'.expand('%'))
        call append(4, '#Description: <++>')
        call append(5, '')
    elseif &filetype == 'python'
        call append(0, '#!/usr/bin/env python3')
        call append(1, '#-*- coding: utf8 -*-')
        call append(2, '#Author: @hare')
        call append(3, '#vim: ts=4 sw=4 sts=4 expandtab')
        call append(4, '')
    endif
endfunction

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" ===
" ===  snippets
" ===
source $HOME/.config/nvim/snippets/md_snippets.vim
source $HOME/.config/nvim/snippets/vim_snippets.vim


" ===
" ===  key bindings
" ===
source $HOME/.config/nvim/_basic_keybindings.vim


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
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp,latin-1
set bs=eol,start,indent
set conceallevel=2
set concealcursor=""
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
set lazyredraw
set ttimeout
set ttimeoutlen=50
set history=200
set formatoptions+=B
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
set cindent
set shiftround
set smartindent
set autoread


" ===
" ===  code fold
" ===
if has('folding')
    set foldenable
    set foldmethod=indent
    set foldlevel=99
endif


" ===
" ===  backup files
" ===
set backup
set writebackup
set noswapfile
set noundofile
set backupdir=$HOME/.vim/tmp
set backupext=.bak
silent! call mkdir(expand('$HOME/.vim/tmp'), "p", 0755)


" ===
" ===  ignore files
" ===
set wildignore+=*DS_Store,*.ipch
set wildignore+=*.o,*.obj,*.exe,*~,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.egg,*.jar,*.class,*.pyc,*.pyo,*.dex,*.gem
set wildignore+=*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.jpeg,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.dmg,*/.rbenv/**
set wildignore+=*/.nv/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class


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
    call dein#add('neoclide/coc.nvim', {
                \ 'merged': 0
                \ })
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('sagarrakshe/toggle-bool')

    " file explorer
    call dein#add('Shougo/defx.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('kristijanhusak/defx-icons')

    " file navigation
    call dein#add('junegunn/fzf', {
                \ 'build': './install --all',
                \ 'rtp': '',
                \ 'merged': 0
                \ })
    call dein#add('junegunn/fzf.vim', {
                \ 'depends': 'fzf'
                \ })
    call dein#add('Yggdroot/LeaderF', {
                \ 'build': 'sh ./install.sh'
                \ })

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
    call dein#add('liuchengxu/vista.vim')

    " leetcode
    call dein#add('ianding1/leetcode.vim')

    " undo tree
    call dein#add('mbbill/undotree')

    " status line
    call dein#add('taigacute/spaceline.vim')
    "call dein#add('theniceboy/eleline.vim')
    "call dein#add('itchyny/lightline.vim')

    " highlight color
    call dein#add('rrethy/vim-hexokinase', {
                \ 'build': 'make hexokinase'
                \ }) " #rrggbb #rgb

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
    call dein#add('godlygeek/tabular') " aligning the table
    call dein#add('liuchengxu/vim-which-key')
    call dein#add('ryanoasis/vim-devicons')

    call dein#end()
    call dein#save_state()
endif

" auto install plugins
if dein#check_install()
    call dein#install()
endif

" remove plugins
nmap <leader>rp :call map(dein#check_clean(), "delete(v:val, 'rf')") <cr>
nmap <leader>re :call dein#recache_runtimepath() <cr>

filetype plugin indent on


"colorscheme molokai
colorscheme deus
"colorscheme onedark
"colorscheme horizon
"highlight! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
"highlight! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray


" ===
" ===  gui settings
" ===
if has("gui_running")
    set guioptions-=T
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=m
endif


" ===
" ===  fzf.vim settings
" ===
set rtp+=/usr/local/opt/fzf
nnoremap <leader>f :Leaderf file<cr>
noremap <silent> <C-f> :Rg<cr>
noremap <silent> <C-h> :History<cr>
noremap <C-t> :Btags<cr>
noremap <silent> <C-l> :Lines<cr>
"noremap <silent> <C-w> :Buffers<cr>
noremap <leader>; :History:<cr>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))

noremap <C-d> :BD<cr>


" ===
" ===  leaderf settings
" ===
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WildIgnore = {
            \ 'dir': ['.git', 'vendor', 'node_modules'],
            \ 'file': ['__vim_project_root']
            \ }
let g:Lf_UseMemoryCache = 0
let g:Lf_UseCache = 0


" ===
" ===  coc.nvim settings
" ===
let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-go',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-jedi',
            \ 'coc-markdownlint',
            \ 'coc-phpls',
            \ 'coc-prettier',
            \ 'coc-pyright',
            \ 'coc-python',
            \ 'coc-sh',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-translator',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml'
            \ ]
let g:coc_disable_startup_warning = 1

" use tab for trigger completion with cahracters ahead and navigate
inoremap <silent><expr> <tab>
            \ pumvisible() ? "\<C-n>" :
            \ <sid>check_back_space() ? "\<tab>" :
            \ coc#refresh()
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
if has('nvim')
    inoremap <silent><expr> <c-l> coc#refresh()
else
    inoremap <silent><expr><c-@> coc#refresh()
endif

" use <cr> to confirm completion
 if exists('*complete_info')
     inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"
 else
     inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
 endif

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  else
	call CocAction('doHover')
  endif
endfunction

" highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" applying codeaction to the selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" format
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"<leader>f key binding to LeaderF

" translator
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)

" apply autofix to problem on the current line
"nmap <leader>qf <Plug>(coc-fix-current)


" ===
" ===  defx settings
" ===
nmap <F2> :Defx <cr>
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
" ===  spaceline.vim settings
" ===
let g:spaceline_seperate_style = 'slant-cons'

" ===
" ===  undotree settings
" ===
noremap L :UndotreeToggle<cr>
let g:undotree_CustomUndotreeCmd = 'topleft vertical 30 new'
let g:Undotree_CustomDiffpanelCmd = 'botright 10 new'
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 8
let g:undotree_HelpLine = 0
let g:undotree_SplitWidth = 30
function g:Undotree_CustomMap()
    nmap <buffer> j <plug>UndotreePreviousState
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> J 5<plug>UndotreePreviousState
    nmap <buffer> K 5<plug>UndotreeNextState
endfunction


" ===
" ===  vim-hexokinase settings
" ===
let g:Hexokinase_highlighters = ['foregroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,colour_names'


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
" ===  gitgutter settings
" ===
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
"let g:gitgutter_sign_added = '+'
"let g:gitgutter_sign_modified = '~'
"let g:gitgutter_sign_removed = '_'
"let g:gitgutter_sign_removed_first_line = '▔'
"let g:gitgutter_sign_modified_removed = '-'
highlight GitGutterAdd guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterChangeDelete guifg=#ff2222 ctermfg=1
autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>


" ===
" ===  lazygit.nvim settings
" ===
noremap <C-g> :LazyGit<cr>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯']
let g:lazygit_use_neovim_remote = 1


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
" ===  vista.vim settings
" ===
noremap <leader>v :Vista!!<cr>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }
let g:scrollstatus_size = 15
let g:vista_sidebar_width = 40
let g:vista_update_on_text_changed = 1
let g:vista_stay_on_open = 0
let g:vista_highlight_whole_line = 1


" ===
" ===  suda settings
" ===
let g:suda#prefix = 'sudo://'
noremap <leader>W :w sudo://%<cr>


" ===
" ===  auto-pairs settings
" ===
autocmd Filetype html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->', '<' : '>'})
autocmd Filetype php let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php' : '?>'})
autocmd Filetype vim let b:AutoPairs = AutoPairsDefine({'\^"': '', '<': ''})
let g:AutoPairsFlyMode = 0


" ===
" ===  toggle-bool settings
" ===
noremap <leader>x :ToggleBool<cr>


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


" ===
" ===  autocmd settings
" ===
" auto source init.vim when saved
autocmd! BufWritePost $MYVIMRC source %

" auto add title to python & sh files
autocmd BufNewFile *.py,*.sh call SetTitle()

" auto change directory to current dir
"autocmd BufEnter * silent! lcd %:p:h

" auto reinit css color
autocmd! BufEnter * silent! HexokinaseTurnOn
autocmd! BufWrite * silent! HexokinaseTurnOn

" auto quit when main windows is closed
autocmd BufEnter *
            \ if 0 == len(filter(range(1, winnr('$')),
            \ 'empty(getbufvar(winbufnr(v:val), "&bt"))')) |
            \ qa! |
            \ endif

" go back to where you exited
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \ execute "normal g'\"" |
                \ endif
endif

" allow markdown to auto wrap
autocmd FileType markdown setlocal wrap

" remove whitespace on save
autocmd BufWritePre * call TrimWhiteSpace()
