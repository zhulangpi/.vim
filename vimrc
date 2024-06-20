set nocompatible                                      "禁用 Vi 兼容模式

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

"" 1. 安装来自GitHub的插件; translates to https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'
"
"" 2. 安装来自任意git URL的插件
"Plug 'https://github.com/junegunn/seoul256.vim.git'
"
"" 3. 安装来自github的插件，且是release的tag版本; (通配符requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }
"
"" 4. 安装来自github的插件，指定branch
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"
"" 5. 安装来自github的插件，指定插件安装的目录
"Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
"
"" 6. 安装来自github的插件，指定插件安装的目录，并设置Post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"" 7. 安装来自github的插件，Post-update hook can be a lambda expression
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"
"" 8. 安装来自github的插件，且支持插件位于repo的指定目录
"Plug 'nsf/gocode', { 'rtp': 'vim' }
"
"" 9. 按需加载设置：在执行指定命令后才加载插件
"Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"
"" 10. 按需加载设置：在打开特定类型文件后才加载插件
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" 11. 手动管理的插件
"Plug '~/my-prototype-plugin'




" 行标记
Plug 'kshenoy/vim-signature'

" 符号高亮
Plug 'vim-scripts/cSyntaxAfter'
autocmd! FileType c,cpp,java,php call CSyntaxAfter()

" 高亮单词
Plug 'vim-scripts/Mark'

" 对齐线
Plug 'Yggdroot/indentLine'

" 文件目录结构树侧边栏
Plug 'preservim/nerdtree'
nmap <F2> :NERDTreeToggle<CR>

" 文件模糊搜索
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
nmap <c-p> :LeaderfFile<CR>

" 符号名索引侧边栏
Plug 'preservim/tagbar'
nmap <c-e> :TagbarToggle<CR>
let g:tagbar_left = 1

" 状态栏
Plug 'Lokaltog/vim-powerline'

" 多行注释
Plug 'preservim/nerdcommenter'

" 最近使用的文件
Plug 'yegappan/mru'
nmap <c-F> :MRUToggle<CR>

Plug 'zivyangll/git-blame.vim'
nnoremap <Leader>v :<C-u>call gitblame#echo()<CR>

Plug 'tpope/vim-fugitive'

" cscope 选项 preview, 有BUG
"Plug 'ronakg/quickr-preview.vim'
"let g:quickr_preview_on_cursor = 1
"let g:quickr_preview_exit_on_enter = 1

call plug#end()

noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" 查找光标当前单词，包括光标单词作为子串的单词。如，查找abc，结果包括abcde
nmap f g*
" 查找光标当前单词，精确匹配。如，查找abc，结果不包括abcde
" 单快捷键"*"
" *


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-
set cscopetag				" 使用 cscope 作为 tags 命令

if filereadable("cscope.out")
	cs add cscope.out
	nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
elseif filereadable("GTAGS")
	set cscopeprg=gtags-cscope	" 使用 gtags-cscope 代替 cscope
	cs add GTAGS
endif

if filereadable("GTAGS")&&filereadable("cscope.out")
	"如果 cscope和gtags文件都存在，跳转定义用gtags，因为更准；跳转引用用cscope，因为会显示引用处函数名
	nmap <leader>s  :cs kill 0<CR>:set cscopeprg=cscope<CR>:cs add cscope.out<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>g  :cs kill 0<CR>:set cscopeprg=gtags-cscope<CR>:cs add GTAGS<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <c-g> :cs kill 0<CR>:set cscopeprg=gtags-cscope<CR>:cs add GTAGS<CR>:cs find g 
else
	nmap <leader>s	:cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>g	:cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <c-g>	:cs find g 
endif

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8					"设置gvim内部编码
set fileencoding=utf-8					"设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1	"设置支持打开的文件的编码
 
" 文件格式，默认 ffs=dos,unix
set fileformat=unix					"设置新文件的<EOL>格式
set fileformats=unix,dos,mac				"给出文件的<EOL>格式类型

set mouse=v						" 启用鼠标
set t_Co=256						" 在终端启用256色
set backspace=2						" 设置退格键可用
set so=15						"翻页留5行
filetype on						"启用文件类型侦测
filetype plugin on					"针对不同的文件类型加载对应的插件
filetype plugin indent on				"启用缩进
set smartindent						"启用智能对齐方式
set smarttab						"指定按一次backspace就删除shiftwidth宽度的空格
set wrap						"自动换行
set list
set listchars=tab:>-,trail:-


set noexpandtab						"将Tab键转换为空格
set tabstop=8						"设置Tab键的宽度
set shiftwidth=8					"换行时自动缩进4个空格

nmap t8 :set noexpandtab<CR>:set tabstop=8<CR>:set shiftwidth=8<CR>
nmap t4 :set expandtab<CR>:set tabstop=4<CR>:set shiftwidth=4<CR>

nmap smv :set mouse=v<CR>
nmap sma :set mouse=a<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cls 清除行尾空格
nmap cls :%s/\s*$//g<CR>:noh<CR>

" 常规模式下输入 clm 清除行尾 ^M 符号
nmap clm :%s/\r$//g<CR>:noh<CR>

" 设置:w!为使用超级用户权限保存
cmap w!<CR> w !sudo tee > /dev/null %<CR>

set hlsearch						"高亮搜索
set incsearch						"在输入要搜索的文字时，实时匹配
set ignorecase						"搜索模式里忽略大小写
set smartcase						"如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number						"显示行号
set laststatus=2					"启用状态栏信息
set cmdheight=2						"设置命令行的高度为2，默认为1
set cursorline						"突出显示当前行
set cursorcolumn
set termguicolors					" 开启后，颜色会不太一样

"终端配色方案
set bg=dark
"colorscheme Tomorrow-Night-Eighties
colorscheme molokai
"colorscheme solarized
"colorscheme gruvbox
"hi Normal ctermbg=none
"highlight CursorLine cterm=none ctermbg=20
"highlight CursorColumn cterm=none ctermbg=6 ctermfg=6

" =============================================================================
"                          << 其它 >>
" =============================================================================

" 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键
"
" =============================================================================
"                          << hot keys >>
" =============================================================================
"" 删除tab线、对齐线，方便鼠标复制
nmap <Leader>b :IndentLinesToggle<CR>:set list!<CR>:set nu!<CR>

" w,e 移动到下一个字符的首和尾；dw 删除光标后的所有空格
" 光标位于空白处时，删除当前连续空白，并切换到insert模式，用于删除word间的空白
nmap <c-d> beldwi

nnoremap <C-w> <C-w>w
