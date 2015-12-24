"============================================================================
"     FileName: _vimrc
"         Desc: This is LChao's configration
"       Author: LChao
"        Email: chao0207@live.com
"     HomePage: http://weibo.com/chao0207/
"      Version: c.0.1
"   CreateTime: 2015-07-27 16:10:30
"   LastChange: 2015-12-22 09:33:32
"      History: 
"============================================================================

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '

    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"==============================判断当前系统的类型=========================
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:vimrc_iswindows=1
else
    let g:vimrc_iswindows=0
endif
autocmd BufEnter * lcd %:p:h

"==============================判断当前终端的类型=========================
if has ('gui_running')
    let g:isGUI=1
else
    let g:isGUI=0
endif

"colorscheme Tomorrow-Night-Eighties "Tomorrow-Night-Eighties

"if has ('gui_running')
"    set background=light           "http://weibo.com/chao0207/
"else
"    set background=dark
"endif
"let g:solarized_termcolors=256
"colorscheme solarized

let g:molokai_original=0
colorscheme molokai

set regexpengine=1                  "vim-javascript

syntax enable
syntax on					"自动语法高亮
set number
set history=1000
au GUIEnter * simalt ~x     "启动时最大化

filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补
filetype on 

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set showmatch
set cursorline
set cuc
set expandtab
"set guioptions-=T
"set guioptions-=m
set ruler
set nohls
set incsearch
set nowrapscan
set autochdir
set magic
set nobackup

"set nofoldenable
"set foldclose=all
"set foldlevel=100
"set foldmethod=indent
"set foldcolumn=0
"setlocal foldlevel=2
"set foldopen=all

filetype off  

" 此处规定Vundle的路径  

set rtp+=$VIM/vimfiles/bundle/vundle/  

call vundle#rc('$VIM/vimfiles/bundle/')  

Bundle 'gmarik/vundle'  

" original repos on github  

Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'mattn/webapi-vim'
Bundle 'Wildog/airline-weather.vim'
Bundle 'Zuckonit/vim-airline-tomato'
Bundle 'mattn/zencoding-vim'  
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Yggdroot/indentLine'
Bundle 'tomasr/molokai'
Bundle 'HTML-AutoCloseTag'
Bundle 'elzr/vim-json'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ap/vim-css-color'
Bundle 'nono/jquery.vim'
Bundle 'jiangmiao/auto-pairs'

" vim-scripts repos  

Bundle 'taglist.vim'
Bundle "vim-scripts/AuthorInfo"
Bundle "vim-scripts/javacomplete"
Bundle "vim-scripts/javabrowser"

filetype plugin indent on " required!

"-------------------------------------------------------------------------
" Ctrl + C 一键保存、编译
"map <c-c> :call CompileRun()<CR>
"imap <c-c> <ESC>:call CompileRun()<CR>
"vmap <c-c> <ESC>:call CompileRun()<CR>
" F5 一键保存、运行
map <F5> :call RunCode()<CR>
imap <F5> <ESC>:call RunCode()<CR>
vmap <F5> <ESC>:call RunCode()<CR>

"C,C++的调试
map <F8> :call Debug()<CR>

"==============================NERDTree setting===========================
map <F7> :NERDTree<CR>
"let NERDTreeWinPos=1

autocmd VimEnter * NERDTree

wincmd w
autocmd VimEnter * wincmd w

let NERDTreeWinSize=25

let NERDTreeShowLineNumbers=1

let NERDTreeShowBookmarks=1 

let NERDTreeHighlightCursorline=1

"TAB页签
map <F9> gt

"运行 编译
map <F10> :!cls&&javac %&&java %:r <CR>

func! RunCode()
    exec "w"
    if &filetype == "c" 
        exec "!gcc %"
        exec "! a"
    elseif &filetype == "cpp"
        exec "!g++  %"
        exec "! a"
    elseif $filetype == "java"
        exec "!java %<"
    elseif &filetype == "python"
        exec "!python %<.py"
    endif
endfunc

func Debug()
    exec "w"

    if &filetype =='c'
        exec "!gcc % -g -o %<.exe"
        exec "!gdb %<.exe"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<.exe"
        exec "!gdb %<.exe"

    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!jdb %<"
    endif
endfunc


set encoding=utf-8

if has("win32")
    "set guifont=Consolas:h12:cANSI
    "set guifont=Source_Code_Pro_Light:h10:cANSI
    set guifont=Meslo_LG_M_for_Powerline:h10:cANSI
    set fileencoding=chinese

    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    imap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    let g:vimrc_iswindows=1
    let g:iswindows=1
    let $VIMFILES = $VIM
else
    let $VIMFILES = $HOME/.vim

endif
autocmd BufEnter * lcd %:p:h

"解决菜单乱码   
source $VIMRUNTIME/delmenu.vim   
source $VIMRUNTIME/menu.vim  
"解决consle输出乱码  
language messages zh_CN.utf-8

set showcmd
set go=
set laststatus=2

"====== :AuthorInfoDetect   自动添加作者、时间等信息，本质是NERD_commenter && authorinfo的结合
let g:vimrc_author='Liuchao'
let g:vimrc_email='chao0207@live.com'
let g:vimrc_homepage='http://weibo.com/chao0207/'
nmap <F4> :AuthorInfoDetect<cr>

"===========================java设置========================================
setlocal omnifunc=javacomplete#Complete
let JavaBrowser_Ctags_Cmd='ctags'
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1
autocmd Filetype java set omnifunc=javacomplete#Complete
autocmd Filetype java set completefunc=javacomplete#CompleteParamsInfo
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

autocmd Filetype java inoremap <buffer> . .<C-X><C-O><C-P><Down>
autocmd Filetype java inoremap <expr> <CR> pumvisible()?"\<C-Y>":"<CR>"

"========================进行Tlist的设置=================================
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=0
let Tlist_WinWidth=25
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=0
let Tlist_Inc_Winwidth=0
"let Tlist_Auto_Open=1

"=============jquery配色 js等配置=============
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "html,body,head,tbody"

let g:html5_aria_attributes_complete=0
let g:html5_microdata_attributes_complete=0
let g:html5_rdfa_attributes_complete=0
let g:html5_event_handler_attributes_complete=0

autocmd FileType python set omnifunc=pythoncomplete#Complete        "python补全
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS      "js补全
autocmd FileType css set omnifunc=csscomplete#CompleteCSS       "css补全
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags      "xml补全

"====================tags==================
set tags=tags 
set autochdir

"set list lcs=tab:\¦\       "vim list模式下将tab显示成|加空格的样子
"=================================对齐线===================================
nmap <leader>il :IndentLinesToggle<CR>

" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif

" 设置终端对齐线颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色
let g:indentLine_color_gui = '#A4E57E'

"================================airline powerline=============================
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'

let g:airline_theme="luna"
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"================================airline weather================================
let g:weather#area = 'beijing,china'
let g:weather#appid = '44db6a862fba0b067b1930da0d769e98'
let g:weather#cache_file = '$Vim/vimfiles/cache/weather.tmp'

"=================================background 透明=================================
au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 225)

if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 225
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc
    "快捷键设置
    map <s-k> :call Alpha_add()<cr>
    map <s-j> :call Alpha_sub()<cr>
    map <leader>t :call Top_window()<cr>
endif

"================================番茄时间管理===========================
let g:tomato#interval = 60 * 60 
let g:tomato#rest_time = 20 * 60 
let g:tomato#lang = 'chinese' 
let g:tomato#remind = "☻" 
let g:tomato#reminfo = "☺" 
let g:tomato#show_clock = 1
let g:tomato#auto_reset_num = 24
"let g:tomato#show_count_down = 1

"===============================括号高亮================================
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
