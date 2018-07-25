" 设置默认进行大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase

set nocompatible              " be iMproved, required
filetype off                  " required

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Change mapleader
let mapleader=","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'isRuslan/vim-es6'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'

Plugin 'Chiel92/vim-autoformat'
Bundle 'ruanyl/vim-fixmyjs'
Plugin 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" ycm 配置

let g:ycm_server_python_interpreter = '/usr/bin/python3'


" 配色方案
set background=dark
colorscheme solarized

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
set incsearch

" 禁止折行
set nowrap

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

if has ( "autocmd" )
	" 打开文件时，自动定位到上次光标位置
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal g'\"" |
	\ endif
endif  " has ("autocmd")

" js文件格式化，Shift-b
map <S-b> :call g:Jsbeautify()<CR>


"F功能键定义
map <F8> :NERDTreeToggle<CR>
map <F11> :bp<CR>
map <F12> :bn<CR>
map <F7> <ESC>:wa<CR>:make<CR>
noremap <F6> :Autoformat<CR>
noremap <F10> :Fixmyjs<CR>
