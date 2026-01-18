" ==============================================================================
"  使用说明:
"  1. 确保安装了 vim-plug:
"  2. 确保安装了 ctags: sudo apt install universal-ctags (Tagbar 插件依赖它)
"  3. 首次进入 Vim 后，请运行命令 :PlugInstall 安装所有插件
" ==============================================================================

" ==========================================
" 1. 插件管理区域 (Plugins)
" ==========================================
call plug#begin('~/.vim/plugged')
" [美化起始页]
Plug 'mhinz/vim-startify'

" [文件浏览] NERDTree
" 作用：在左侧显示文件目录树
Plug 'preservim/nerdtree'

" [模糊搜索] FZF
" 作用：全项目秒搜文件
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" [代码大纲] Tagbar
" 作用：在右侧列出当前文件的宏、结构体、函数列表
Plug 'majutsushi/tagbar'

" [高效编辑] Surround
" 作用：快速修改包裹符号 (括号、引号、标签)
" 场景：把 (a + b) 改成 [a + b]，只需按 cs([ 即可，不用删了重写
Plug 'tpope/vim-surround'

" [快速注释] Commentary
" 作用：快速注释/反注释代码
" 操作：光标选中几行后按 gc
Plug 'tpope/vim-commentary'

" [状态栏] Airline
" 作用：美化底部状态栏，显示当前模式、Git 分支、文件编码等
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" [配色主题] Gruvbox
Plug 'morhetz/gruvbox'

" [Git 集成] Fugitive (可选)
Plug 'tpope/vim-fugitive'

call plug#end()


" ==========================================
" 2. 基础设置 (Basic Settings)
" ==========================================
" --- 核心体验 ---
syntax on                   " 开启语法高亮，没这个代码就是黑白的
set nocompatible            " 关闭 vi 兼容模式，防止一些古老 bug

" --- 行号设置 (混合行号) ---
set number                  " 显示当前行的绝对行号
set relativenumber          " 显示其他行的相对行号


" --- 编辑体验 ---
set cursorline              " 高亮当前行，防止在大段代码中找不到光标
set wrap                    " 自动折行，防止代码太长超出屏幕
set showcmd                 " 在右下角显示未输完的命令 (如输入 d2 时会显示，防止手误)
set wildmenu                " 命令行补全增强 (按 Tab 键时会列出选项)
set scrolloff=5             " 【重要】光标移动到距离顶部/底部 5 行时就开始滚动

" --- 缩进设置 (C 语言标准) ---
set tabstop=4               " 设定 Tab 键宽度为 4 个空格
set shiftwidth=4            " 设定自动缩进或者是 >> 操作的宽度为 4
set expandtab               " 【重要】将 Tab 自动转化为空格 (防止在不同编辑器打开乱码)
set autoindent              " 换行时自动对齐上一行的缩进

" --- 搜索设置 ---
set hlsearch                " 搜索时高亮所有匹配项
set incsearch               " 边输入边搜索 (即时反馈)


" 每次打开文件时，自动清除上次遗留的高亮
exec "nohlsearch"


" ==========================================
" 3. 主题与界面 (Theme)
" ==========================================
set t_Co=256                " 开启 256 色支持，否则配色会很丑
set background=dark         " 告诉 Vim 背景是深色的，自动调整文字颜色
try
    colorscheme gruvbox     " 尝试加载 Gruvbox 主题
    let g:airline_theme='gruvbox' " 让状态栏也匹配这个主题
catch
    " 如果插件还没安装，这里什么都不做，防止报错
endtry


" ==========================================
" 4. 快捷键映射 (Key Mappings)
" ==========================================
" 【核心】将 Leader 键映射为空格 (Space)
let mapleader=" "

" --- 模式切换 ---
inoremap jj <Esc>

" --- 文件保存与退出 ---
" 空格 + w = 保存
nnoremap <Leader>w :w<CR>
" 空格 + q = 退出
nnoremap <Leader>q :q<CR>

" --- 插件快捷键 ---
" [FZF] Ctrl + p 打开文件搜索
nnoremap <C-p> :Files<CR>

" [NERDTree] 空格 + e 打开/关闭左侧文件树
nnoremap <Leader>e :NERDTreeToggle<CR>
" [NERDTree] 空格 + v 在文件树里定位当前文件
nnoremap <Leader>v :NERDTreeFind<CR>

" [Tagbar] F8 打开/关闭右侧代码大纲
nnoremap <F8> :TagbarToggle<CR>
" 也可以用 空格 + t
nnoremap <Leader>t :TagbarToggle<CR>

" --- 窗口管理 ---
" 使用 Ctrl + h/j/k/l 在分屏窗口之间跳转
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- 杂项 ---
" 空格 + 回车：取消搜索高亮
nnoremap <Leader><CR> :nohlsearch<CR>

" ==========================================
" 5. 符号修正 (Fix Symbols)
" ==========================================
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" 将行号符号改为 'Ln'
let g:airline_symbols.linenr = ' Ln:'

" 将列号符号改为 'Col'
let g:airline_symbols.colnr = ' Col:'

let g:airline_symbols.maxlinenr = ''

" ==========================================
" 6. 搜索优化
" ==========================================
" 让 FZF 默认使用 Rg (ripgrep)
"    --files: 只找文件
"    --hidden: 也搜隐藏文件 (如 .vimrc)
"    --follow: 允许搜软连接
"    --glob: 排除 .git 文件夹
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" 有些版本的 fzf.vim 插件不读上面的变量，需要专门设置这个
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'source': 'rg --files --hidden --follow --glob "!.git/*"'}, <bang>0)


" ==========================================
" 7. 一键代码格式化 (One-Key Formatting)
" ==========================================
" 定义一个函数，把清理工作打包
fun! CleanCode()
    " 1. 保存当前光标位置 (防止格式化后光标跳到文件头)
    let save_cursor = getpos(".")

    " 2. 清除行尾多余空格
    "    (silent! 是为了防止如果没有多余空格时报错)
    silent! %s/\s\+$//e

    " 3. 将 Tab 转换为空格 (根据 expandtab 设置)
    retab

    " 4. 全文自动对齐缩进 (核心功能)
    "    gg=G 的意思是：gg(跳到头) = (对齐) G(直到尾)
    normal! gg=G

    " 5. 恢复光标位置
    call setpos('.', save_cursor)

    " 6. 提示完成
    echo "代码已清洗 & 格式化！"
endfun

" 绑定快捷键：空格 + f (Format)
nnoremap <Leader>f :call CleanCode()<CR>
