" =====================================================================
"  .vimrc — 现代重构版（2025-11-28）
"  架构：vim-plug + coc.nvim（LSP 统一接管补全/诊断）
"  语言语法插件全部保留，补全引擎（jedi/racer/asyncomplete/vim-lsp
"  /phpactor 等）由 coc.nvim 替代。
"  备份：/tmp/vimrc-backup-20251128/
" =====================================================================

" -------------------------------------------------------------------
" 0. vim-plug 引导
" -------------------------------------------------------------------
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
  if !executable('curl')
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!curl -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

" -------------------------------------------------------------------
" 1. 基础设置
" -------------------------------------------------------------------
set nocompatible
filetype plugin indent on
syntax on

" 编码（保留 GBK/GB18030 兼容，处理中文服务器文件）
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set fileformats=unix,dos,mac

" 编辑体验
set backspace=indent,eol,start
set hidden
set autoread
set scrolloff=3
set ttyfast

" Tab / 缩进（语言特化会覆盖）
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" 搜索
set hlsearch
set incsearch
set ignorecase
set smartcase

" 显示
set number
set ruler
set laststatus=2
set wildmenu
set wildmode=list:longest,list:full
set title
set titleold="Terminal"
set titlestring=%F
set noerrorbells visualbell t_vb=

" modeline
set modeline
set modelines=10

" 鼠标 / 终端颜色
set mouse=a
set mousemodel=popup
set t_Co=256
if has('termguicolors')
  set termguicolors
endif

" 系统剪贴板
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" 不污染项目目录：交换/备份文件走 /tmp
set nobackup
set noswapfile
" set undofile

" coc.nvim 推荐项
set cmdheight=2
set updatetime=300
set signcolumn=yes

" leader
let mapleader=','

" 会话
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" -------------------------------------------------------------------
" 2. 插件管理（vim-plug）
" -------------------------------------------------------------------
call plug#begin(expand('~/.vim/plugged'))

" ---- 核心 / 编辑增强 ----
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'          " fugitive :GBrowse 依赖
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'unblevable/quick-scope'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" ---- UI ----
Plug 'ghifarit53/tokyonight-vim'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'

" ---- 会话 ----
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" ---- LSP / 补全 / 诊断（统一由 coc.nvim 接管）----
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ---- 运维 / 日常 ----
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'ledger/vim-ledger'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/vimux'
Plug 'wakatime/vim-wakatime'

" ---- 语言语法（全部保留；补全由 coc 接管）----
" c / cpp
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'
" elixir
Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}
Plug 'carlosgaldino/elixir-snippets', {'for': 'elixir'}
" elm
Plug 'elmcast/elm-vim', {'for': 'elm'}
" erlang
Plug 'jimenezrick/vimerl', {'for': 'erlang'}
" go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
" haskell
Plug 'dag/vim2hs', {'for': 'haskell'}
Plug 'pbrisbin/vim-syntax-shakespeare', {'for': 'haskell'}
" html / css
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'
" javascript
Plug 'jelera/vim-javascript-syntax'
" lisp
Plug 'vim-scripts/slimv.vim', {'for': ['scheme', 'clojure', 'lisp']}
" lua
Plug 'xolox/vim-lua-ftplugin', {'for': 'lua'}
Plug 'xolox/vim-lua-inspect', {'for': 'lua'}
" ocaml
Plug 'def-lkb/ocp-indent-vim', {'for': 'ocaml'}
" perl
Plug 'vim-perl/vim-perl', {'for': 'perl'}
" php
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
" python
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
" ruby
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-rake', {'for': 'ruby'}
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec', {'for': 'ruby'}
Plug 'ecomba/vim-ruby-refactoring', {'tag': 'main', 'for': 'ruby'}
" rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" scala
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
if has('python')
  Plug 'ktvoelker/sbt-vim', {'for': 'scala'}
endif
" svelte
Plug 'leafOfTree/vim-svelte-plugin', {'for': 'svelte'}
" typescript
Plug 'HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescriptreact']}
" vue
Plug 'leafOfTree/vim-vue-plugin', {'for': 'vue'}

call plug#end()

" -------------------------------------------------------------------
" 3. 主题 / UI 配置
" -------------------------------------------------------------------
" tokyonight（256 色终端可用）
try
  colorscheme tokyonight
catch
  colorscheme default
endtry

" 光标不闪烁
set gcr=a:blinkon0

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Tagbar
let g:tagbar_autofocus = 1

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
if !exists('g:airline_powerline_fonts')
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = '▶'
  let g:airline_left_alt_sep = '»'
  let g:airline_right_sep = '◀'
  let g:airline_right_alt_sep = '«'
  let g:airline#extensions#branch#prefix = '⤴'
  let g:airline#extensions#readonly#symbol = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
endif

" -------------------------------------------------------------------
" 4. fzf / 检索
" -------------------------------------------------------------------
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = 'right:60%'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" -------------------------------------------------------------------
" 5. coc.nvim 配置（LSP 补全 / 诊断 / 跳转）
" -------------------------------------------------------------------
" 首次启动自动安装的扩展（coc 按需装，也可 :CocInstall 单独装）
" 覆盖：JS/TS/Vue、JSON、HTML、CSS、Go(gopls)、Python(pyright)、Rust、
" PHP(intelephense)、VimL、YAML、bash、snippets(集成 ultisnips)
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-go',
  \ 'coc-python',
  \ 'coc-rust-analyzer',
  \ 'coc-phpls',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ ]

" TAB 补全 / snippet 跳转流程
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 跳转 / 重命名 / 诊断
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>fmt <Plug>(coc-format)
nmap <silent> <leader>df <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" -------------------------------------------------------------------
" 6. 通用键位
" -------------------------------------------------------------------
" 窗口切换
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" 分屏
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Buffer 导航 / 关闭
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

" 系统剪贴板（修复原 YY 带回车问题）
nnoremap YY "+yy
nnoremap XX "+x
nnoremap <leader>p "+gP
if has('macunix')
  vnoremap <C-c> y:call system('pbcopy', @")<CR><CR>
endif

" 搜索高亮清除 / 搜索居中
nnoremap <silent> <leader><space> :noh<cr>
nnoremap n nzzzv
nnoremap N Nzzzv

" Visual 缩进保持选择 / 移动行
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit --verbose<CR>
noremap <Leader>gsh :Git push<CR>
noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiffsplit<CR>
noremap <Leader>gr :GRemove<CR>
nnoremap <Leader>o :.GBrowse<CR>

" 标签页
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" 工作目录 / 编辑当前文件所在路径
nnoremap <leader>. :lcd %:p:h<CR>
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" 终端
nnoremap <silent> <leader>sh :terminal<CR>

" NERDTree / Tagbar
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F4> :TagbarToggle<CR>

" fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Rg<CR>
nmap <leader>y :History:<CR>
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" 会话
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" 命令别名（大小写容错）
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" -------------------------------------------------------------------
" 7. 通用命令 / 自动命令
" -------------------------------------------------------------------
" 去掉行尾空格
command! FixWhitespace :%s/\s\+$//e

" 记住光标位置
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" txt 折行
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" make / cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" -------------------------------------------------------------------
" 8. 语言特化
" -------------------------------------------------------------------
" c / cpp
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab

" elixir

" elm
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1

" erlang
let erlang_folding = 1
let erlang_show_errors = 1

" go（coc-go 接管补全/诊断；vim-go 保留语法与运行命令）
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup go
  au!
  au FileType go nmap <buffer> <leader>r  <Plug>(go-run)
  au FileType go nmap <buffer> <leader>t  <Plug>(go-test)
  au FileType go nmap <buffer> <Leader>gt <Plug>(go-coverage-toggle)
augroup END

" haskell
let g:haskell_conceal_wide = 1
let g:haskell_multiline_strings = 1

" html（2 空格）
autocmd FileType html setlocal ts=2 sw=2 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

" lua

" ocaml（本机无 opam，去掉原 merlin rtp 逻辑）

" perl

" php（补全用 coc-phpls；格式化用 php-cs-fixer）
autocmd FileType php nmap <buffer> <Leader>pc :PhpCsFixerFix<CR>

" python（补全/诊断用 coc-python）
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
let python_highlight_all = 1

" ruby
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
" RSpec（buffer 级，避免与 go 的 <leader>t 冲突）
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
" Ruby 重构（v:null）
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>
if has('nvim')
  runtime! macros/matchit.vim
else
  packadd! matchit
endif

" rust（coc-rust-analyzer 接管补全/跳转，rust.vim 保留语法）
let g:rustfmt_autosave = 1

" scala
let g:scala_sort_across_groups = 1

" svelte
let g:vim_svelte_plugin_load_full_syntax = 1

" typescript
let g:yats_host_keyword = 1

" vue
let g:vue_disable_pre_processors=1
let g:vim_vue_plugin_load_full_syntax = 1

" -------------------------------------------------------------------
" 9. 用户本地配置
" -------------------------------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
