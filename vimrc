"https://github.com/tpope/vim-pathogen
execute pathogen#infect()

set number

"Refer:  http://linux-wiki.cn/wiki/zh-hans/Vim%E4%BB%A3%E7%A0%81%E7%BC%A9%E8%BF%9B%E8%AE%BE%E7%BD%AE
"编辑时一个TAB字符占4空格
set tabstop=4
"一级缩进4空格
set shiftwidth=4
"将输入的TAB自动展开成空格
set expandtab
"开启了et后使用退格（backspace）键，每次退格将删除4个空格 
set softtabstop=4

filetype plugin indent on

set autoindent
set smartindent

"显示括号配对情况
set showmatch

"让打开文件时光标自动到上次退出该文件时的光标所在位置
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

"http://easwy.com/blog/archives/advanced-vim-skills-syntax-on-colorscheme/
colorscheme desert

"tagbar
"https://github.com/majutsushi/tagbar
nmap <F3> :TagbarToggle<CR>
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_left=1

"Configure for cscope
set nocscopeverbose 
"set cscopequickfix=s-,c-,d-,i-,t-,e-
set cst
function LoadCscope(path)
    "防止无限递归
    if a:path == $HOME || a:path == '/'
        return
    endif
    if (executable("cscope") && has("cscope"))
        let l:outfile=a:path."/cscope.out"
        let l:outpath=a:path
        if filereadable(outfile)
            cs reset
            exe "cs add" outfile outpath
        else
            "递归
            let l:newpath=a:path."/.."
            let newpath=resolve(newpath)
            "echo newpath
            call LoadCscope(newpath) 
        endif
    endif
endfunction
call LoadCscope(getcwd())
