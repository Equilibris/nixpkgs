set rnu nu
set clipboard+=unnamedplus

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()

PlugInstall

TSUpdate
TSInstall rust
TSInstall nix


