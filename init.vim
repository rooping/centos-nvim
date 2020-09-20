"""                       _                     _           
""" _ __ ___   ___  _ __ (_)_ __   __ _  __   _(_)_ __ ___  
"""| '__/ _ \ / _ \| '_ \| | '_ \ / _` | \ \ / / | '_ ` _ \ 
"""| | | (_) | (_) | |_) | | | | | (_| |  \ V /| | | | | | |
"""|_|  \___/ \___/| .__/|_|_| |_|\__, |   \_/ |_|_| |_| |_|
"""                |_|            |___/                     
"==============================================================================
" === Auto load for first time uses
"==============================================================================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"==============================================================================
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
"==============================================================================
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

"==============================================================================
"plugin install
"==============================================================================
" 去掉有关vi一致性模式，避免以前版本的一些bug和局限，解决backspace不能使用的问题
set nocompatible 
filetype off
call plug#begin()
" Pretty Dress
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'
Plug 'bpietravalle/vim-bolt'
Plug 'theniceboy/vim-deus'
Plug 'VundleVim/Vundle.vim'
Plug 'mhinz/vim-startify'
"undotree
Plug 'mbbill/undotree'
" Autoformat
Plug 'Chiel92/vim-autoformat'
Plug 'davidhalter/jedi-vim'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'fholgado/minibufexpl.vim'
Plug 'mileszs/ack.vim'
Plug 'Lokaltog/vim-powerline'
"navigation
"Plug 'pechorin/any-jump.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
"git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'mhinz/vim-signify'
"Plug 'airblade/vim-gitgutter'
"Plug 'cohama/agit.vim'

"autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" go
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'dgryski/vim-godef'
" Python
" Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
"Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
"Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }
" Debugger
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

call plug#end()
filetype plugin indent on

"==============================================================================
"base config
"==============================================================================
let mapleader=";"
set autochdir

" 显示行号
set number
" 显示标尺
set ruler
" 历史纪录
set history=1000
" 输入的命令显示出来，看的清楚些

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

set wrap "不超出显示"
set showcmd "底部显示每次输入的命令"
set wildmenu                    " 命令模式下补全以菜单形式显示
set wildmode=list:longest,full  " 命令模式补全模式
set hidden                      " 允许不保存切换buffer
set splitright                  " 新分割窗口在右边
set splitbelow                  " 新分割窗口在下边
 
" 启用自动对齐功能，把上一行的对齐格式应用到下一行
"set autoindent
" 依据上面的格式，智能的选择对齐方式，对于类似C语言编写很有用处
"set smartindent
"关闭换行自动注释
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " This can be done as well instead of the previous line, for setting formatoptions as you choose:
    autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END
 
" 自动保存
" set autowrite
" vim禁用自动备份
set noswapfile
" 文件被改动时自动载入
set autoread
" 显示匹配的括号
set showmatch
" 文件缩进及tab个数
au FileType html,python,vim,javascript setl shiftwidth=4
au FileType html,python,vim,javascript setl tabstop=4
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4
" 高亮搜索的字符串
set hlsearch
set incsearch
set ignorecase                  " 搜索忽略大小写
set smartcase                   " 智能大小写搜索
 
" 设置显示制表符的空格字符个数,改进tab缩进值，默认为8，现改为4
set tabstop=4
" 统一缩进为4，方便在开启了et后使用退格(backspace)键，每次退格将删除X个空格
set softtabstop=4
" 用空格代替tab
set expandtab
" 设定自动缩进为4个字符，程序中自动缩进所使用的空白长度
set shiftwidth=4
" 设置帮助文件为中文(需要安装vimcdoc文档)
"set helplang=cn
"
" 状态行显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" 启动显示状态行1，总是显示状态行2
set laststatus=3
" 语法高亮显示
syntax on
syntax enable                   " 语法高亮
set fileencodings=utf-8,gb2312,gbk,cp936,latin-1
set fileencoding=utf-8
set termencoding=utf-8
set fileformat=unix
set encoding=utf-8
" 配色方案
"color snazzy
"let g:SnazzyTransparent = 0
" 指定配色方案是256色
set t_Co=256

" 检测文件的类型
filetype on
filetype plugin on
filetype indent on
 
" 突出显示当前行 
set cursorline
" 突出显示当前列
"set cursorcolumn
"设置光标样式为竖线vertical bar
" Change cursor shape between insert and normal mode in iTerm2.app
"if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
"endif
" 顶部底部保持3行距离
set scrolloff=3

"粘贴时候，如果前边的行带有注释符号，如#、//、"等时，后边的行会自动加上注释符号
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "no rm $"|endif|endif
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o<Paste>
" 共享剪贴板
" set clipboard+=unnamed

"======================================================plugin configuration===================================
"==============================================================================
"undotree
"==============================================================================
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24


" =========================================================================
" == NERDTree
" =========================================================================
let NERDTreeWinPos='right'
let NERDTreeWinSize=30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"当打开vim且没有文件时自动打开NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.git']
map <F4> :NERDTreeToggle<CR>

"==============================================================================
"minibuf
"==============================================================================
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0

"==============================================================================
" vim-go 插件
"https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2
nnoremap <leader>gg :GoDef <CR>
nnoremap <leader>gc :GoReferrers <CR>
nnoremap <leader>gb :GoImplements <CR>

" ===
" === coc.nvim
" ===
let g:coc_global_extensions = [
	\ 'coc-actions',
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-python',
	\ 'coc-go',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-todolist',
	\ 'coc-translator',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-vetur',
	\ 'coc-yaml',
	\ 'coc-yank']
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> gk :call <SID>show_documentation()<CR>

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

" Formatting selected code.
xmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)


"==============================================================================
"signify
"==============================================================================
let g:signify_vcs_list = ['git','svn']
nmap <C-g> :SignifyToggle<CR>

" =========================================================================
" == GitGutter
" =========================================================================
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
"nnoremap <LEADER>gf :GitGutterFold<CR>
"nnoremap H :GitGutterPreviewHunk<CR>
"nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
"nnoremap <LEADER>g= :GitGutterNextHunk<CR>

"==============================================================================
" cscope setting
"==============================================================================
"set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
"if has("cscope")
"set csprg=/usr/local/bin/cscope
"set csto=1
"set cst
"set nocsverb
"" add any database in current directory
"if filereadable("cscope.out")
"   cs add cscope.out
"endif
"set csverb
"endif
"
"nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>f :cs find
"nnoremap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nnoremap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>w :Ack!<space>

"==============================================================================
"tagbar
"==============================================================================
let g:tagbar_ctags_bin='ctags'          "ctags程序的路径
let g:tagbar_width=30                   "窗口宽度的设置
let g:tagbar_left=1
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
map <F3> :Tagbar<CR>

"==============================================================================
" ack setting
"==============================================================================
"let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'ag --vimgrep'

"==============================================================================
" comment setting
"加上/解开注释, 智能判断
"==============================================================================
"default nnoremap <leader>c<space> 
let g:NERDSpaceDelims=1

"python jedi-vim插件常用的功能还包括：
"python Goto assignments: <leader>g (typical goto function)
"python 跳转到定义： <leader>d
"python 显示Python文档(Pydoc)： K
"python 重命名：<leader>r
"python 展示某个变量的使用方法：<leader>n (shows all the usages of a name)
"python 打开某个模块：:Pyimport os (打开 os 模块)

"jump
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"nmap <C-w> :bwipe<CR>
nmap <leader>p :Files<CR>
nmap <F8> :copen<CR>
nmap <F7> :cclose<CR>
map <C-l> :bp<CR>
map <C-h>  :bn<CR>
map <C-k> :cp<CR>
map <C-j> :cn<CR>
nmap <PageDown> :colder<CR>
nmap <PageUp> :cnewer<CR> 
"format jsonfile
 command! Jsonf :execute '%!python -m json.tool'
  \ | :execute '%!python -c "import re,sys;sys.stdout.write(re.sub(r\"\\\u[0-9a-f]{4}\", lambda m:m.group().decode(\"unicode_escape\").encode(\"utf-8\"), sys.stdin.read()))"'


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif
