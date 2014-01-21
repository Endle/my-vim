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

"Config for  mhinz/vim-signify
"https://github.com/mhinz/vim-signify
let g:signify_vcs_list = ['git', 'hg', 'svn']

"编译运行
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -g % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -g % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python' "我添加的执行python的命令
        exec "!python3 %"
    elseif &filetype == 'ruby'
        exec "!ruby %"
    endif
endfunc
nmap <F5> :call CompileRun()<CR>
nmap <leader>r : call CompileRun()<CR>

"C,C++的调试
func! Rungdb()
    "检查一下文件类型
    if &filetype != 'c' && &filetype != 'cpp'
        return
    endif
    exec "w"
    if &filetype == 'c'
        exec "!gcc -g % -o %<"
    elseif &filetype == 'cpp'
        exec "!g++ -g % -o %<"
    endif
    exec "!gdb ./%<"
endfunc
nmap <F4> :call Rungdb()<CR>
nmap <leader>d : call Rungdb()<CR>


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
