#my-vim
不小心把原有的 vim 配置删掉了。。。那就从头开始吧

侧重 C++ 和 Python 的代码。有什么建议欢迎提出

#使用要求
vim version > 7.3 (for  Yggdroot / indentLine)

#使用方法
1. git clone git://gitcafe.com/endle/my-vim.git /path/to/repo  
2. ln -s /path/to/repo  ~/.vim  
3. git submodule init && git submodule update  
(Reference: <http://liluo.org/blog/2012/05/using-git-submodule-and-vim-pathogen-for-vim-configuraction-management/>)

#Manual
`<leader> + Space`: StripTrailingWhitespace  
`<leader> + il`: Enable/Disable Yggdroot/indentLine  
`<leader> + ta`: Enable/Disable HighLight for Tabs  
`,c`: To convert a string to a character array  

##comments.vim
To comment  `<Ctrl-C>` in both normal and visual `<Shift-V>` range select mode  
To un-comment `<Ctrl-X`> in both normal and visual `<Shift-V`> range select mode  

##a.vim
`:A` switches to the header file corresponding to the current file being edited (or vise versa)  
`:AT` new tab and switches  
More usage on <http://www.vim.org/scripts/script.php?script_id=31>  
