"============================================================================
"     FileName: _vimrc
"         Desc: This is Liuchao's configration
"       Author: Liuchao
"        Email: chao0207@live.com
"     HomePage: http://blog.sina.com.cn/liuchao0207
"      Version: c.0.1
"   CreateTime: 2015-07-27 16:10:30
"   LastChange: 2015-09-30 10:45:33
"      History: 
"               c.0.1:
"                   --vim的一些基本配置，例如显示行号，背景配色，启动最大
"                       化中文编码，无菜单栏工具栏等等
"                   --添加Tlist列表，配合Ctags插件来使用，设置其相关配置，
"                       例如随vim开启而开启，窗口宽度，快捷键等等
"                   --添加NERDTree，设置其相关配置，例如随vim开启而开启，
"                       矿口宽度，快捷键等等
"                   --添加全屏gvimfullscreen插件，映射键F11
"                   --添加jquery及html相关基本配置
"                   --添加自动添加作者信息AuthorInfo插件，配合NERD_commen
"                       -ter来使用
"                   --添加java自动提示javacomplete插件，java代码自动提示，
"                       Ctrl+n,p提示，'.'提示等等
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

"========================判断当前系统的类型===============================
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:vimrc_iswindows=1
else
    let g:vimrc_iswindows=0
endif
autocmd BufEnter * lcd %:p:h

"set fenc=utf-8
syntax enable
syntax on					"自动语法高亮
colorscheme Tomorrow-Night-Eighties "desert Tomorrow-Night-Eighties 配色
set number					"显示行号
set history=1000
au GUIEnter * simalt ~x     "启动时最大化

filetype on 
filetype indent on          "针对不同的文件类型采用不同的缩进格式
filetype plugin on          "针对不同的文件类型加载对应的插件
filetype plugin indent on   "启用自动补

" 缩进
set autoindent              "把当前行的对齐方式应用到下一行
set smartindent             "智能的选择对齐方式
set tabstop=4				"设定 tab 长度为 4
set shiftwidth=4            "将换行的总动缩进设置成4个空格
set showmatch               "高亮显示
set cursorline              "突出显示当前行
set cuc                     "竖状突出显示
set expandtab               "空格代替tab
"set guioptions-=T          "隐藏工具栏
"set guioptions-=m          "隐藏菜单栏
set ruler					"打开状态栏标尺
set nohls                   "关闭匹配的高亮显示
set incsearch				"输入搜索内容时就显示搜索结果
set nowrapscan              "查找到末尾停止查找
set autochdir               "自动切换当前目录为当前文件所在的目录
set magic                   "设置魔术
set nobackup                "取消自动备份

"set nofoldenable           "开始折叠
"set foldclose=all          "设置光标移开时自动关闭折叠
"set foldlevel=100          "启动vim时不要自动折叠代码
set foldmethod=indent       "设置折叠方式
set foldcolumn=0            "设置折叠区域的宽度
setlocal foldlevel=99       "设置折叠层数为
set foldopen=all            "设置光标到达时自动打开折叠

"-------------------------------------------------------------------------
" Ctrl + C 一键保存、编译
"map <c-c> :call CompileRun()<CR>
"imap <c-c> <ESC>:call CompileRun()<CR>
"vmap <c-c> <ESC>:call CompileRun()<CR>
" F5 一键保存、运行
map <F5> :call RunCode()<CR>
imap <F5> <ESC>:call RunCode()<CR>
vmap <F5> <ESC>:call RunCode()<CR>

"===========================打开NERDTRee==================================
map <F7> :NERDTree<CR>
"let NERDTreeWinPos=1       "窗口靠右
"C,C++的调试
map <F8> :call Debug()<CR>
"vim启动自动开启NERDTree
autocmd VimEnter * NERDTree
"启动后自动进入编辑区
wincmd w
autocmd VimEnter * wincmd w
"设置窗口尺寸"
let NERDTreeWinSize=25
"是否显示行号"
let NERDTreeShowLineNumbers=1
"是否显示书签"
let NERDTreeShowBookmarks=1 
"高亮NERDTrre窗口的当前行"
let NERDTreeHighlightCursorline=1

"Tab之间的切换
map <F9> gt
map <F10> :!cls&&javac %&&java %:r <CR>

" 运行可执行文件
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

"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype =='c'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
"Java程序 
elseif &filetype == 'java' 
exec "!javac %" 
exec "!jdb %<"
endif
endfunc
"结束定义Debug
"-------------------------------------------------------------------------

set encoding=utf-8
" 设置字体 以及中文支持
if has("win32")
    set guifont=Consolas:h12:cANSI
	set fileencoding=chinese
"------------------------------全屏插件-----------------------------------
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>   "非插入模式下F11全屏
	imap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>   "插入模式下F11全屏
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


" 状态栏显示目前所执行的指令
set showcmd
set go=	                    "无菜单栏，工具栏
set laststatus=2            "开启状态栏信息

"==========================添加作者信息===================================
"AuthorInfoDetect   自动添加作者、时间等信息，本质是NERD_commenter && authorinfo的结合
let g:vimrc_author='Liuchao'
let g:vimrc_email='chao0207@live.com'
let g:vimrc_homepage='http://blog.sina.com.cn/liuchao0207'
nmap <F4> :AuthorInfoDetect<cr>

"===========================java设置======================================
setlocal omnifunc=javacomplete#Complete
let JavaBrowser_Ctags_Cmd='ctags'
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1
autocmd Filetype java set omnifunc=javacomplete#Complete "这一句是自动补全
autocmd Filetype java set completefunc=javacomplete#CompleteParamsInfo "这一句是参数提示
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

autocmd Filetype java inoremap <buffer> . .<C-X><C-O><C-P><Down>
autocmd Filetype java inoremap <expr> <CR> pumvisible()?"\<C-Y>":"<CR>"  "如果回车不管用，添加该句

"========================进行Tlist的设置==================================
"TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1        "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0   "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_WinWidth=25       "设置宽度
let Tlist_File_Fold_Auto_Close=1    "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0     "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Open=1

"=============================jquery配色==================================
au BufRead,BufNewFile *.js set syntax=jquery
let b:javascript_fold=1                 "打开javascript折叠
let javascript_enable_domhtmlcss=1      "打开javascript对dom、html和css的支持

"============================html缩进设置=================================
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "html,body,head,tbody"

"=============================Ctags设置===================================
set tags=tags 
set autochdir
