" ~/.vimrc by Jayli <lijing00333@163.com> http://jayli.github.com
" for 拔赤, 欢迎拷贝
"
" 使用vim默认配置，推荐这样做
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-surround'
Plugin 'Chiel92/vim-autoformat'
Plugin 'isRuslan/vim-es6'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'posva/vim-vue'
Plugin 'PsychoLlama/further.vim'
Bundle "Raimondi/delimitMate"
Plugin 'scrooloose/nerdtree'
Plugin 'chr4/nginx.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'ruanyl/vim-fixmyjs'
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jparise/vim-graphql'
Plugin 'w0rp/ale' " alternatively, pass a path where Vundle should install plugins
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'digitaltoad/vim-pug'
Bundle 'jistr/vim-nerdtree-tabs'
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

call plug#begin()
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()



"默认长度的空格
set backspace=indent,eol,start
" 读写.viminfo文件，不要额外存储
set viminfo='20,\"50 
set formatoptions=mtcql

au BufNewFile,BufRead * set foldlevel=99

"折叠配置
set fdm=manual

" 折叠样式
highlight Folded ctermbg=darkgray ctermfg=lightmagenta

if has ( "autocmd" )
	" 打开文件时，自动定位到上次光标位置
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal g'\"" |
	\ endif
endif  " has ("autocmd") 


" 编辑器界面配置
"

" 鼠标滚轮的事件
" just for gvim
if has("gui_running")
	"/color lucius
	au GUIEnter * cd ~
	" 列高亮，暂时关闭
	" set cursorcolumn
	map <MiddleMouse> <Nop>
	" 行高亮，gui模式下起作用
	set cursorline
	set guifont=Consolas:h13
else
	set showtabline=2
	"鼠标隐藏,鼠标右键无作用
	set mouse=v
endif

" 字体设置
if has("unix") && !has("mac")
	set guifont=Inconsolata\ Medium\ 11
	" gui下字体默认样式
	set guifont=Courier\ 10\ Pitch
	set guifontwide=WenQuanYi\ Micro\ Hei\ Mono\ Medium\ 10
endif
if has("mac")
	set guifont=Monaco:h13
endif

" 文件设置
filetype on
filetype plugin on
filetype indent on


" js文件格式化，Shift-b
map <S-b> :call g:Jsbeautify()<CR>

"编辑器样式hack
hi Comment      term=bold ctermfg=darkcyan
hi Constant     term=underline ctermfg=Red
hi Special      term=bold ctermfg=Magenta
hi Identifier   term=underline ctermfg=cyan
hi Statement    term=bold ctermfg=Brown
hi PreProc      term=bold ctermfg=DarkYellow
hi Type         term=bold ctermfg=DarkGreen
hi Ignore       ctermfg=white
hi Error        term=reverse ctermbg=Red ctermfg=White
hi Todo         term=standout ctermbg=Yellow ctermfg=Red
hi Search       term=standout ctermbg=Yellow ctermfg=Black
hi ErrorMsg     term=reverse ctermbg=Red ctermfg=White

"高亮搜索结果
set incsearch
set hlsearch

"显示行号
set nu

"状态栏
set laststatus=2
set statusline=%<[%n]\ %F\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}][%{&ff}][ASCII=\%03.3b]\ %-10.(%l,%c%V%)\ %P

"欢迎文字
" autocmd VimEnter * echo "Welcome back jayli :)"
autocmd VimLeave * echo "Byebye wuhuihao.."
autocmd VimEnter BufRead,BufNewFile *.vue NERDTree

"一个tab占4个空格
set ts=4
set sw=4

"自动缩进动作，粘贴自动缩进
set smartindent
"自动缩进长度
set cino=:0g0               

"长句在单词间折行
set wrap

"搜索忽略大小写
set ignorecase

"编辑源备份
set backupcopy=yes

"编辑模式自动缩进
set autoindent 
"记录历史
set history=150 
"标尺
set ruler
"显示不完整的命令
set showcmd
" Added to default to high security within Gentoo. Fixes bug #14088
set modelines=0

"文件编码
set fileencodings=ucs-bom,utf-8,GB18030,gbk
"gui字体，随意模式
set guifontset=*-r-*

"语法高亮
syntax enable
syntax on
set t_Co=256

"F功能键定义
"map <F2> <ESC>zA<CR>            
map <F3> <ESC>*
map <F4> :NERDTreeTabsOpen<CR>
map <F11> :bp<CR>              
map <F12> :bn<CR>               
map <F7> <ESC>:wa<CR>:make<CR>
noremap <F6> :Autoformat<CR>
noremap <F10> :Fixmyjs<CR>


" JSHint
map <F8> :JSHint<CR>

"tab操作多文件
map <C-t> :tabnew 
nmap wm :tabnew .<CR>
"nmap wm :NERDTreeToggle<CR>
map <Tab> :tabnext<CR> 
map <S-Tab> :tabprevious<CR>

"使用 Ctrl+C 或者 Y 复制到系统剪贴板
vnoremap <C-C> "+y
vnoremap Y "+y
set clipboard=unnamed

"快速左右移动光标
map <C-l> <ESC>10l
map <C-h> <ESC>10h

"tab尺寸
set shiftwidth=4
set tabstop=4   "tab

"tab自动补全
function! CleverTab()
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-N>"
endfunction
function! CleverShiftTab()
	return pumvisible()?"\<C-P>":"\<Tab>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
inoremap <S-Tab> <C-R>=CleverShiftTab()<CR>
inoremap <C-F> <C-X><C-F><C-P> 

inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
autocmd Filetype css inoremap <buffer>  :  :<C-X><C-O><C-P>
autocmd BufEnter *.vue  syntax sync fromstart

"退出模式，退出时保留残存窗口
set t_ti=
set t_te= 

" 颜色设置
set t_Co=256

"选择编辑器主题
"colorscheme blue
"colorscheme darkblue
"colorscheme default
"colorscheme base16-monokai
"colorscheme molokai
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme darkburn  "依赖.vim/colors/darkburn.vim
colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme monokai
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme torte
"colorscheme zellner
"colorscheme gemcolors 
"colorscheme distinguished
"colorscheme base16-default-dark
"colorscheme base16-eighties-dark
"colorscheme solarized

"hack for elflord 
"状态栏样式hack，针对evening,包括gui模式下的状态栏样式
hi StatusLine  cterm=bold ctermbg=236 ctermfg=white guifg=darkblue guibg=white
hi StatusLineNC	ctermbg=236 ctermfg=darkgray guifg=darkblue guibg=white
hi TabLineFill cterm=bold ctermbg=237 ctermfg=black guibg=black guifg=black
hi TabLineSel cterm=bold ctermbg=darkblue ctermfg=white guibg=blue guifg=white

"显示tab line
"set showtabline=2

"最大tab个数
set tabpagemax=40

"对所有文件设置关键字提示
set dictionary-=~/.vim/dict/dict.txt dictionary+=~/.vim/dict/dict.txt
set complete-=k complete +=k

:filetype plugin on 

" 将less识别为css
au BufRead,BufNewFile *.less set filetype=css
" 将scss识别为css
au BufRead,BufNewFile *.scss set filetype=css
" 将xtpl识别为html
au BufRead,BufNewFile *.xtpl set filetype=html

" zen coding 配置
let g:user_zen_expandabbr_key = '<C-k>' "设置为ctrl+k,展开

" 注释生成
let g:DoxygenToolkit_authorName="wuhuihao, wuhuihao@raycloud.com" 
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
let g:DoxygenToolkit_versionString=""
let g:DoxygenToolkit_compactOneLineDoc = "yes"

" 注释生成
function! InsertDox()
	"return "\:".getline('.')
	" 空行C-D生成文件注释
	if getline('.') =~ '^\s*$'
		return "\:DoxAuthor\<CR>"
	else 
	" 非空行C-D生成函数注释
		return "\:Dox\<CR>\<ESC>"
endfunction

" C-D生成注释
map <expr> <C-k> InsertDox()

if has("gui_running")
	colorscheme distinguished
endif
execute pathogen#infect()

"NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowBookmarks=1 "show bookmark at start up
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

  """"""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为,lk
nmap <silent> <leader>lkp :LookupFile<cr>
nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>

autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
set runtimepath^=~/.vim/bundle/ctrlp.vim
"ctrlp
"<Leader>p搜索当前目录下文件
"<Leader>b显示缓冲区文件，并可通过序号进行跳转
nmap <Leader>b :CtrlPBuffer<CR>
"设置搜索时忽略的文件
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|node_modules)|node_modules$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|gif|png|jpg)$',
    \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_bottom = 1
"修改QuickFix窗口显示的最大条目数
let g:ctrlp_max_height = 15
let g:ctrlp_match_window_reversed = 0
"设置MRU最大条目数为500
let g:ctrlp_mruf_max = 500
let g:ctrlp_follow_symlinks = 1
"默认不使用正则表达式，置1改为默认使用正则表达式，可以用<C-r>进行切换
let g:ctrlp_regexp = 0
"自定义搜索列表的提示符
let g:ctrlp_line_prefix = '♪ '
" auto-formatter
function! ESlintFormatter()
    let l:npm_bin = ''
    let l:eslint = 'eslint'
    if executable('npm')
        let l:npm_bin = split(system('npm bin'), '\n')[0]
    endif
    if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
        let l:eslint = l:npm_bin . '/eslint'
    endif
    let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; ' . l:eslint . ' --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
endfunction
autocmd BufReadPre *.vue let b:javascript_lib_use_vue = 1

"autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css.less.pug

vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" Register tag name associated the filetype
call jspretmpl#register_tag('gql', 'graphql')

autocmd FileType javascript JsPreTmpl
autocmd FileType javascript.jsx JsPreTmpl

let g:ale_linters = {
      \ 'html': ['eslint'],
      \ 'css': ['eslint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'vue': ['eslint']
      \ }
let g:ale_virtualenv_dir_names = []
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-e>""
let g:UltiSnipsJumpForwardTrigger="<c-x>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
""""""""""""""""""""" vim标签配置 begin """"""""""""""""""""""
" 显示标签页顺序，便于切换标签页，如需要切换到编号为3的标签页，按 3gt 即可
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let s .= i . ')'
            let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#' )
            let file = bufname(buflist[winnr - 1])
            let file = fnamemodify(file, ':p:t')
            if file == ''
                let file = '[NEW]'
            else
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(i))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(i)
                    " check and ++ tab's &modified count
                    if getbufvar( b, "&modified" )
                        let m += 1
                        break
                    endif
                endfor
                " add modified label + where n pages in tab are modified
                if m > 0
                    let file = '+ '.file
                endif
            endif
            let s .= ' '.file.' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
""""""""""""""""""""" vim标签配置 end """"""""""""""""""""""
