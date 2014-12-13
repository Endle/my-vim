"https://github.com/tpope/vim-pathogen
execute pathogen#infect()

"个人偏好，有需求的话，可以考虑把配色方案放到另一个文件中处理
colorscheme desert

set number
set ruler
"默认高亮匹配所有的字符串
set hlsearch

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
syntax enable

"显示括号配对情况
set showmatch

"让打开文件时光标自动到上次退出该文件时的光标所在位置
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

"http://easwy.com/blog/archives/advanced-vim-skills-syntax-on-colorscheme/
colorscheme desert

"不兼容 vi
set nocp
"backspace
set backspace=indent,eol,start

"=== vim bundle (managed by git-submodule) ===
"tagbar
"https://github.com/majutsushi/tagbar
nmap <F3> :TagbarToggle<CR>
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_left=1

"vim-signify
let g:signify_vcs_list = [ 'git', 'hg' ]

"indentLine
"设置成深红色
let g:indentLine_color_term = 1

"=== end of vim bundle ===

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
    elseif &filetype == 'haskell'
        exec "!ghc --make %"
        exec "! ./%<"
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

"http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

"http://www.linuxzen.com/tui-jian-ji-kuan-zui-jin-fa-xian-fei-chang-ku-de-vimcha-jian.html
map <leader>il :IndentLinesToggle<CR>

"http://www.reddit.com/r/vim/comments/12k0fi/highlight_spaces_at_the_end_of_lines_when_outside/
highlight default link EndOfLineSpace ErrorMsg
match EndOfLineSpace / \+$/
autocmd InsertEnter * hi link EndOfLineSpace Normal
autocmd InsertLeave * hi link EndOfLineSpace ErrorMsg

"High Light Tabs
let g:HighLightTabsInCodeStatus=0
function HighLightTabsInCode()
    if g:HighLightTabsInCodeStatus == 0
        highlight default link TabInCode ErrorMsg
        match TabInCode /\t/
        let g:HighLightTabsInCodeStatus=1
    else
        highlight default link TabInCode ErrorMsg
        match TabInCode /THIS_WILL_NEVer_bE_sHoWN/
        let g:HighLightTabsInCodeStatus=0
    endif
endfunction
nmap <leader>ta : call HighLightTabsInCode()<CR>

"http://wiki.winehq.org/VimTips#tip02
vmap ,c "zdi{<C-R>=substitute(substitute(@z, '\(.\)', "'\\1',", "g"), "'\\(['\\\\]\\)'", "'\\\\\\1'", "g")<CR><ESC>a'\0'}<ESC>

"http://stackoverflow.com/a/17723513
nmap ta :match Error /\t/<CR>

"Hovercraft
function BuildHovercraft()
    exec "w"
    exec "!hovercraft -t default % result"
endfunction
nmap <leader>hc : call BuildHovercraft()<CR>
