#my-vim
侧重 C++ 和 Python 的代码。有什么建议欢迎提出

#使用要求
vim version > 7.3 (for  Yggdroot / indentLine)

#使用方法
1. git clone git://gitcafe.com/endle/my-vim.git ~/.vim  
2. cd ~/.vim  
3. git submodule init && git submodule update --depth=1  
(Reference: <http://liluo.org/blog/2012/05/using-git-submodule-and-vim-pathogen-for-vim-configuraction-management/>)

#Manual
`<leader> + Space`: StripTrailingWhitespace  
`<leader> + il`: Enable/Disable Yggdroot/indentLine  
`<leader> + ta`: Enable/Disable HighLight for Tabs  
`<leader> + h`: Add HeaderGuard for C/C++ files  
`,c`: To convert a string to a character array  
`ta`: To highlight all TABs  
`<leader> + fp`: To show current file's path  
`<leader> + wm`: Run `make` in situ  
`Ctrl+J + Ctrl+H`: Run JSHint  
`Ctrl+L`: new title line  

##comments.vim
To comment  `<Ctrl-C>` in both normal and visual `<Shift-V>` range select mode  
To un-comment `<Ctrl-X`> in both normal and visual `<Shift-V`> range select mode  

##a.vim
`:A` switches to the header file corresponding to the current file being edited (or vise versa)  
`:AT` new tab and switches  
More usage on <http://www.vim.org/scripts/script.php?script_id=31>  

##ag.vim
`:Ag [options] {pattern} [{directory}]`

##Compile And Run
`<leader> + m`: Run `make` in current folder  

