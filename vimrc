set number

"让打开文件时光标自动到上次退出该文件时的光标所在位置
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

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
