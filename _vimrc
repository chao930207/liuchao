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
"                   --vim��һЩ�������ã�������ʾ�кţ�������ɫ���������
"                       �����ı��룬�޲˵����������ȵ�
"                   --���Tlist�б����Ctags�����ʹ�ã�������������ã�
"                       ������vim���������������ڿ�ȣ���ݼ��ȵ�
"                   --���NERDTree��������������ã�������vim������������
"                       ��ڿ�ȣ���ݼ��ȵ�
"                   --���ȫ��gvimfullscreen�����ӳ���F11
"                   --���jquery��html��ػ�������
"                   --����Զ����������ϢAuthorInfo��������NERD_commen
"                       -ter��ʹ��
"                   --���java�Զ���ʾjavacomplete�����java�����Զ���ʾ��
"                       Ctrl+n,p��ʾ��'.'��ʾ�ȵ�
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

"========================�жϵ�ǰϵͳ������===============================
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:vimrc_iswindows=1
else
    let g:vimrc_iswindows=0
endif
autocmd BufEnter * lcd %:p:h

"set fenc=utf-8
syntax enable
syntax on					"�Զ��﷨����
colorscheme Tomorrow-Night-Eighties "desert Tomorrow-Night-Eighties ��ɫ
set number					"��ʾ�к�
set history=1000
au GUIEnter * simalt ~x     "����ʱ���

filetype on 
filetype indent on          "��Բ�ͬ���ļ����Ͳ��ò�ͬ��������ʽ
filetype plugin on          "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on   "�����Զ���

" ����
set autoindent              "�ѵ�ǰ�еĶ��뷽ʽӦ�õ���һ��
set smartindent             "���ܵ�ѡ����뷽ʽ
set tabstop=4				"�趨 tab ����Ϊ 4
set shiftwidth=4            "�����е��ܶ��������ó�4���ո�
set showmatch               "������ʾ
set cursorline              "ͻ����ʾ��ǰ��
set cuc                     "��״ͻ����ʾ
set expandtab               "�ո����tab
"set guioptions-=T          "���ع�����
"set guioptions-=m          "���ز˵���
set ruler					"��״̬�����
set nohls                   "�ر�ƥ��ĸ�����ʾ
set incsearch				"������������ʱ����ʾ�������
set nowrapscan              "���ҵ�ĩβֹͣ����
set autochdir               "�Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set magic                   "����ħ��
set nobackup                "ȡ���Զ�����

"set nofoldenable           "��ʼ�۵�
"set foldclose=all          "���ù���ƿ�ʱ�Զ��ر��۵�
"set foldlevel=100          "����vimʱ��Ҫ�Զ��۵�����
set foldmethod=indent       "�����۵���ʽ
set foldcolumn=0            "�����۵�����Ŀ��
setlocal foldlevel=99       "�����۵�����Ϊ
set foldopen=all            "���ù�굽��ʱ�Զ����۵�

"-------------------------------------------------------------------------
" Ctrl + C һ�����桢����
"map <c-c> :call CompileRun()<CR>
"imap <c-c> <ESC>:call CompileRun()<CR>
"vmap <c-c> <ESC>:call CompileRun()<CR>
" F5 һ�����桢����
map <F5> :call RunCode()<CR>
imap <F5> <ESC>:call RunCode()<CR>
vmap <F5> <ESC>:call RunCode()<CR>

"===========================��NERDTRee==================================
map <F7> :NERDTree<CR>
"let NERDTreeWinPos=1       "���ڿ���
"C,C++�ĵ���
map <F8> :call Debug()<CR>
"vim�����Զ�����NERDTree
autocmd VimEnter * NERDTree
"�������Զ�����༭��
wincmd w
autocmd VimEnter * wincmd w
"���ô��ڳߴ�"
let NERDTreeWinSize=25
"�Ƿ���ʾ�к�"
let NERDTreeShowLineNumbers=1
"�Ƿ���ʾ��ǩ"
let NERDTreeShowBookmarks=1 
"����NERDTrre���ڵĵ�ǰ��"
let NERDTreeHighlightCursorline=1

"Tab֮����л�
map <F9> gt
map <F10> :!cls&&javac %&&java %:r <CR>

" ���п�ִ���ļ�
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

"����Debug�������������Գ���
func Debug()
exec "w"
"C����
if &filetype =='c'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
"Java���� 
elseif &filetype == 'java' 
exec "!javac %" 
exec "!jdb %<"
endif
endfunc
"��������Debug
"-------------------------------------------------------------------------

set encoding=utf-8
" �������� �Լ�����֧��
if has("win32")
    set guifont=Consolas:h12:cANSI
	set fileencoding=chinese
"------------------------------ȫ�����-----------------------------------
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>   "�ǲ���ģʽ��F11ȫ��
	imap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>   "����ģʽ��F11ȫ��
	let g:vimrc_iswindows=1
	let g:iswindows=1
	let $VIMFILES = $VIM
else
	let $VIMFILES = $HOME/.vim
	
endif
autocmd BufEnter * lcd %:p:h

"����˵�����   
source $VIMRUNTIME/delmenu.vim   
source $VIMRUNTIME/menu.vim  
"���consle�������  
language messages zh_CN.utf-8


" ״̬����ʾĿǰ��ִ�е�ָ��
set showcmd
set go=	                    "�޲˵�����������
set laststatus=2            "����״̬����Ϣ

"==========================���������Ϣ===================================
"AuthorInfoDetect   �Զ�������ߡ�ʱ�����Ϣ��������NERD_commenter && authorinfo�Ľ��
let g:vimrc_author='Liuchao'
let g:vimrc_email='chao0207@live.com'
let g:vimrc_homepage='http://blog.sina.com.cn/liuchao0207'
nmap <F4> :AuthorInfoDetect<cr>

"===========================java����======================================
setlocal omnifunc=javacomplete#Complete
let JavaBrowser_Ctags_Cmd='ctags'
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1
autocmd Filetype java set omnifunc=javacomplete#Complete "��һ�����Զ���ȫ
autocmd Filetype java set completefunc=javacomplete#CompleteParamsInfo "��һ���ǲ�����ʾ
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

autocmd Filetype java inoremap <buffer> . .<C-X><C-O><C-P><Down>
autocmd Filetype java inoremap <expr> <CR> pumvisible()?"\<C-Y>":"<CR>"  "����س������ã���Ӹþ�

"========================����Tlist������==================================
"TlistUpdate���Ը���tags
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags' "��Ϊ���Ƿ��ڻ�����������Կ���ֱ��ִ��
let Tlist_Use_Right_Window=1        "�ô�����ʾ���ұߣ�0�Ļ�������ʾ�����
let Tlist_Show_One_File=0   "��taglist����ͬʱչʾ����ļ��ĺ����б������ֻ��1��������Ϊ1
let Tlist_WinWidth=25       "���ÿ��
let Tlist_File_Fold_Auto_Close=1    "�ǵ�ǰ�ļ��������б��۵�����
let Tlist_Exit_OnlyWindow=1 "��taglist�����һ���ָ��ʱ���Զ��Ƴ�vim
let Tlist_Process_File_Always=0     "�Ƿ�һֱ����tags.1:����;0:����������һֱʵʱ����tags����Ϊû�б�Ҫ
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Open=1

"=============================jquery��ɫ==================================
au BufRead,BufNewFile *.js set syntax=jquery
let b:javascript_fold=1                 "��javascript�۵�
let javascript_enable_domhtmlcss=1      "��javascript��dom��html��css��֧��

"============================html��������=================================
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "html,body,head,tbody"

"=============================Ctags����===================================
set tags=tags 
set autochdir
