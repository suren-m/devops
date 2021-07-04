" https://neovim.io/doc/user/nvim.html#nvim-from-vim

" use vim config for nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc