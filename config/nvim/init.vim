" .vimrc / init.vim
" The following vim/neovim configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
" if you not to use, enter:
"     nvim -u NONE filename
call functions#PlugLoad()
call plug#begin('/root/.dotfiles/config/nvim/plugged')

" General {{{
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set autoread " detect when a file is changed

    set history=1000 " change history to 1000
    set textwidth=120

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamed

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
" }}}

" Appearance {{{
    set number " show line numbers
    set wrap " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set showbreak=↪
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    set laststatus=2 " show the status line all the time
    set so=7 " set 7 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set updatetime=300
    set signcolumn=yes
    set shortmess+=c
    " indicate cursorline"
    set cursorline

    " Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set shiftwidth=4 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'

    " code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1
    set t_Co=256

    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set termencoding=utf-8
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936
    set fileencoding=utf-8

    " toggle invisible characters
    " set list
    " set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

    " toggle column mode"
    map <F2> :call TogglecolumnMode()<CR>
    let s:enabledcolumn = 1

    function! TogglecolumnMode()
        "IndentLinesToggle
    if s:enabledcolumn
        set nonu
        set scl=no
        let s:enabledcolumn = 0
    else
        set nu
        set scl=yes
        let s:enabledcolumn = 1
        let g:indentLine_enabled = 0
    endif
    endfunction

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Load colorschemes
    "Plug 'chriskempson/base16-vim'
    "Plug 'joshdick/onedark.vim'
    Plug 'crusoexia/vim-monokai'

" }}}

" General Mappings {{{
    " set a map leader for more key combos
    let mapleader = ';'

    " remap esc
    inoremap jk <esc>

    " set paste toggle
    set pastetoggle=<leader>v

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

    nmap <leader>l :set list!<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    map <silent> <C-h> <Plug>WinMoveLeft
    map <silent> <C-j> <Plug>WinMoveDown
    map <silent> <C-k> <Plug>WinMoveUp
    map <silent> <C-l> <Plug>WinMoveRight
    nnoremap <S-j> 4j
    nnoremap <S-k> 4k
    nnoremap <S-h> 5h
    nnoremap <S-l> 5l

    nmap <leader>z <Plug>Zoom

    map <leader>wc :wincmd q<cr>

    " move line mappings
    " ∆ is <A-j> on macOS
    " ˚ is <A-k> on macOS
    nnoremap ∆ :m .+1<cr>==
    nnoremap ˚ :m .-2<cr>==
    inoremap ∆ <Esc>:m .+1<cr>==gi
    inoremap ˚ <Esc>:m .-2<cr>==gi
    vnoremap ∆ :m '>+1<cr>gv=gv
    vnoremap ˚ :m '<-2<cr>gv=gv

    vnoremap $( <esc>`>a)<esc>`<i(<esc>
    vnoremap $[ <esc>`>a]<esc>`<i[<esc>
    vnoremap ${ <esc>`>a}<esc>`<i{<esc>
    vnoremap $" <esc>`>a"<esc>`<i"<esc>
    vnoremap $' <esc>`>a'<esc>`<i'<esc>
    vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
    vnoremap $< <esc>`>a><esc>`<i<<esc>

    " toggle cursor line
    " nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> ^ g^
    nnoremap <silent> $ g$

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!

    " Custom text objects

    " inner-line
    xnoremap <silent> il :<c-u>normal! g_v^<cr>
    onoremap <silent> il :<c-u>normal! g_v^<cr>

    " around line
    vnoremap <silent> al :<c-u>normal! $v0<cr>
    onoremap <silent> al :<c-u>normal! $v0<cr>

    " Interesting word mappings
    nmap <leader>0 <Plug>ClearInterestingWord
    nmap <leader>1 <Plug>HiInterestingWord1
    nmap <leader>2 <Plug>HiInterestingWord2
    nmap <leader>3 <Plug>HiInterestingWord3
    nmap <leader>4 <Plug>HiInterestingWord4
    nmap <leader>5 <Plug>HiInterestingWord5
    nmap <leader>6 <Plug>HiInterestingWord6

    " open current buffer in a new tab
    nmap <silent> gTT :tab sb<cr>
" }}}

" AutoGroups {{{
    " remember last position"
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "no rm $"|endif|endif
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}

" General Functionality {{{
    " better terminal integration
    " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    "Plug 'scrooloose/nerdcommenter'

    " easy commenting motions
    Plug 'tpope/vim-commentary'
        Plug 'luochen1990/rainbow'
        let g:rainbow_active = 1
        let g:rainbow_conf = {
        \   'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
        \   'ctermfgs': ['lightyellow', 'lightcyan','lightblue', 'lightmagenta'],
        \   'operators': '_,_',
        \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \   'separately': {
        \       '*': {},
        \       'tex': {
        \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
        \       },
        \       'lisp': {
        \           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
        \       },
        \       'vim': {
        \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
        \       },
        \       'html': {
        \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
        \       },
        \       'css': 0,
        \   }
        \}

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-surround'

    " tmux integration for vim
    Plug 'preservim/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-sleuth'

    " Startify: Fancy startup screen for vim {{{
        Plug 'mhinz/vim-startify'

        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': function('helpers#startify#listcommits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \   { 'uc': [ 'Update CoC Plugins', ':CocUpdate' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '/root/.dotfiles/config/nvim/init.vim' },
            \ { 'g': '~/.gitconfig' },
            \ { 'z': '~/.zshrc' }
        \ ]

        autocmd User Startified setlocal cursorline
        nmap <leader>st :Startify<cr>
    " }}}

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>b :Bdelete<cr>

    " Writing in vim {{{{
        Plug 'junegunn/goyo.vim'

        autocmd! User GoyoEnter nested call helpers#goyo#enter()
        autocmd! User GoyoLeave nested call helpers#goyo#leave()
    " }}}

    " context-aware pasting
    Plug 'sickill/vim-pasta'

    Plug 'ryanoasis/vim-devicons'

    " FZF {{{
        Plug $HOMEBREW_PREFIX . '/root/.dotfiles/fzf'
        Plug 'junegunn/fzf.vim'

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>

        nmap <silent> <leader>b :Buffers<cr>
        nmap <silent> <leader>p :FZF<cr>
        nmap <silent> <leader>w :Rg<space>
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>.' || true', 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
        function! RipgrepFzf(query, fullscreen)
            let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
            let initial_command = printf(command_fmt, shellescape(a:query))
            let reload_command = printf(command_fmt, '{q}')
            let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
            call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
        endfunction

        let $FZF_DEFAULT_OPTS= $FZF_DEFAULT_OPTS
            \ . " --layout reverse"
            \ . " --pointer ' '"
            \ . " --info hidden"
            \ . " --color 'bg+:0'"

        let g:fzf_preview_window = ['right:50%:hidden', '?']
        let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
    " }}}


    " minibuffer {{{
        Plug 'fholgado/minibufexpl.vim'
        let g:miniBufExplMapWindowNavVim = 1
        let g:miniBufExplMapWindowNavArrows = 1
        let g:miniBufExplMapCTabSwitchBufs = 1
        let g:miniBufExplModSelTarget = 1
        let g:miniBufExplMoreThanOne=0
        let g:miniBufExplBRSplit = 0
        let g:bufferline_echo = 0
        let g:miniBufExplBuffersNeeded = 1
        map <C-h>  :bp<CR>
        map <C-l> :bn<CR>
    " }}}


    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        nmap <silent> <leader>gs :Gstatus<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :Gblame<cr>

        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'sodapopcan/vim-twiggy'
        Plug 'rbong/vim-flog'
    " }}}

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
        let g:UltiSnipsExpandTrigger="<C-l>"
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    " }}}
    
    " leaderf {{{
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
        let g:Lf_ShortcutF = '<C-P>'
    " }}}
    
    " nerdtree {{{
        Plug 'preservim/nerdtree'
        Plug 'Xuyuanp/nerdtree-git-plugin'
        " autocmd vimenter * NERDTree  "自动开启Nerdtree
        let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
        let NERDTreeShowBookmarks=1  " 开启Nerdtree时自动显示Bookmarks
        "打开vim时如果没有文件自动打开NERDTree
        " autocmd vimenter * if !argc()|NERDTree|endif
        "当NERDTree为剩下的唯一窗口时自动关闭
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        " 设置树的显示图标
        let g:NERDTreeDirArrowExpandable = '+'
        let g:NERDTreeDirArrowCollapsible = '-'
        let NERDTreeIgnore = ['\.pyc$']  " 过滤所有.pyc文件不显示
        let g:NERDTreeShowLineNumbers=0 " 是否显示行号
        let g:NERDTreeHidden=0     "不显示隐藏文件
        ""Making it prettier
        let NERDTreeMinimalUI = 1
        let NERDTreeDirArrows = 1
        nnoremap <F3> :NERDTreeToggle<CR> " 开启/关闭nerdtree快捷键
    " }}}


    " coc {{{
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-tsserver',
        \ 'coc-git',
        \ 'coc-eslint',
        \ 'coc-tslint-plugin',
        \ 'coc-pairs',
        \ 'coc-json',
        \ 'coc-sh',
        \ 'coc-go',
        \ 'coc-pyright',
        \ 'coc-vimlsp',
        \ 'coc-emmet',
        \ 'coc-prettier',
        \ 'coc-explorer',
        \ 'coc-diagnostic'
        \ ]

        autocmd CursorHold * silent call CocActionAsync('highlight')

        " coc-prettier
        command! -nargs=0 Prettier :CocCommand prettier.formatFile
        nmap <leader>f :CocCommand prettier.formatFile<cr>

        let g:go_def_mode='gopls'
        let g:go_info_mode='gopls'

        " coc-git
        nmap [g <Plug>(coc-git-prevchunk)
        nmap ]g <Plug>(coc-git-nextchunk)
        nmap gs <Plug>(coc-git-chunkinfo)
        nmap gu :CocCommand git.chunkUndo<cr>

        nmap <silent> <leader>k :CocCommand explorer<cr>

        "remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> gh <Plug>(coc-doHover)

        " diagnostics navigation
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " rename
        nmap <silent> <leader>c <Plug>(coc-rename)

        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        " organize imports
        command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

        " Use K to show documentation in preview window
        " nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        "tab completion
        inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        if has('nvim')
            inoremap <silent><expr> <c-space> coc#refresh()
        else
            inoremap <silent><expr> <c-@> coc#refresh();
        endif

        function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if exists('*complete_info')
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
            imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " For enhanced <CR> experience with coc-pairs checkout :h coc#on_enter()
        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " }}}
" }}}

" Language-Specific Configuration {{{
    " html / templates {{{
        " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'mattn/emmet-vim'
        "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

        " match tags in html, similar to paren support
        Plug 'gregsexton/MatchTag', { 'for': 'html' }

        " html5 support
        Plug 'othree/html5.vim', { 'for': 'html' }

        " mustache support
        Plug 'mustache/vim-mustache-handlebars'

        " pug / jade support
        Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }

        " nunjucks support
        Plug 'niftylettuce/vim-jinja'

        " liquid support
        Plug 'tpope/vim-liquid'
    " }}}

    " JavaScript {{{
        Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
        " Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
        Plug 'MaxMEllon/vim-jsx-pretty'
        let g:vim_jsx_pretty_highlight_close_tag = 1
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
        " Plug 'Shougo/vimproc.vim', { 'do': 'make' } TODO what still needs this?
    " }}}


    " Styles {{{
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        Plug 'groenewege/vim-less', { 'for': 'less' }
        Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
        Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
        Plug 'stephenway/postcss.vim', { 'for': 'css' }
    " }}}

    " markdown {{{
        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]

        " Open markdown files in Marked.app - mapped to <leader>m
        Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
        nmap <leader>m :MarkedOpen!<cr>
        nmap <leader>mq :MarkedQuit<cr>
        nmap <leader>* *<c-o>:%s///gn<cr>
    " }}}

     "JSON {{{
        "Plug 'elzr/vim-json', { 'for': 'json' }
        "let g:vim_json_syntax_conceal = 0
     "}}}

    Plug 'ekalinin/Dockerfile.vim'
    Plug 'jparise/vim-graphql'
    " airline {{{
       Plug 'vim-airline/vim-airline'       
       Plug 'vim-airline/vim-airline-themes' "airline 的主题
       " 设置状态栏
       let g:airline#extensions#tabline#enabled = 1
       let g:airline#extensions#tabline#left_alt_sep = '|'
       let g:airline#extensions#tabline#buffer_nr_show = 0
       let g:airline#extensions#tabline#formatter = 'default'
       let g:airline_theme = 'desertink'  " 主题
       let g:airline#extensions#keymap#enabled = 1
       let g:airline#extensions#tabline#buffer_idx_mode = 1
       let g:airline#extensions#tabline#buffer_idx_format = {
             \ '0': '0 ',
             \ '1': '1 ',
             \ '2': '2 ',
             \ '3': '3 ',
             \ '4': '4 ',
             \ '5': '5 ',
             \ '6': '6 ',
             \ '7': '7 ',
             \ '8': '8 ',
             \ '9': '9 '
             \}
       " 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
       nmap <leader>1 <Plug>AirlineSelectTab1
       nmap <leader>2 <Plug>AirlineSelectTab2
       nmap <leader>3 <Plug>AirlineSelectTab3
       nmap <leader>4 <Plug>AirlineSelectTab4
       nmap <leader>5 <Plug>AirlineSelectTab5
       nmap <leader>6 <Plug>AirlineSelectTab6
       nmap <leader>7 <Plug>AirlineSelectTab7
       nmap <leader>8 <Plug>AirlineSelectTab8
       nmap <leader>9 <Plug>AirlineSelectTab9
       " 设置切换tab的快捷键 <\> + <-> 切换到前一个 tab
       "nmap <leader>- <Plug>AirlineSelectPrevTab
       " 设置切换tab的快捷键 <\> + <+> 切换到后一个 tab
       "nmap <leader>+ <Plug>AirlineSelectNextTab
       " 设置切换tab的快捷键 <\> + <q> 退出当前的 tab
       nmap <leader>q :bp<cr>:bd #<cr>
       " 修改了一些个人不喜欢的字符
       if !exists('g:airline_symbols')
           let g:airline_symbols = {}
       endif
       let g:airline_symbols.linenr = "CL" " current line
       let g:airline_symbols.whitespace = '|'
       let g:airline_symbols.maxlinenr = 'Ml' "maxline
       let g:airline_symbols.branch = 'BR'
       let g:airline_symbols.readonly = "RO"
       let g:airline_symbols.dirty = "DT"
       let g:airline_symbols.crypt = "CR" 

   " }}}
" }}}

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    "if filereadable(expand("~/.vimrc_background"))
        "let base16colorspace=256
        "source ~/.vimrc_background
    "else
        "let g:onedark_termcolors=16
        "let g:onedark_terminal_italics=1
        ""colorscheme onedark
    "endif
    syntax on
    filetype plugin indent on
    set background=dark
    colo monokai
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333

    " make comments and HTML attributes italic
    highlight Comment cterm=italic term=italic gui=italic
    highlight htmlArg cterm=italic term=italic gui=italic
    highlight xmlAttrib cterm=italic term=italic gui=italic
    " highlight Type cterm=italic term=italic gui=italic
    highlight Normal ctermbg=none
    hi Normal ctermfg=252 ctermbg=none "背景透明

    let g:python_host_prog  = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
" }}}

" vim:set foldmethod=marker foldlevel=0
"
"
"format jsonfile
 " command! Jsonf :execute '%!python -m json.tool'
 "  \ | :execute '%!python -c "import re,sys;sys.stdout.write(re.sub(r\"\\\u[0-9a-f]{4}\", lambda m:m.group().decode(\"unicode_escape\").encode(\"utf-8\"), sys.stdin.read()))"'

