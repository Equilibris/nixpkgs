set rnu nu
set clipboard^=unnamed,unnamedplus
set scrolloff=10
set laststatus=3

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'rafamadriz/neon'
Plug 'akinsho/toggleterm.nvim', { 'tag' : 'v1.*' }
Plug 'LnL7/vim-nix'

call plug#end()

colorscheme neon

lua << EOF

require("toggleterm").setup {
  open_mapping = [[<C-t>]],
  direction = 'float'
}

EOF

