-- https://github.com/nanotee/nvim-lua-guide
require 'sets'
require 'maps'
require 'commands'
require 'plugins.toggleterm'
require 'plugins.nvim-tree'
require 'plugins.lualine'
require 'plugins.cokeline'
require 'plugins.presence'
require 'plugins.gitsigns'
require 'plugins.diffview'
require 'plugins.surround'
require 'plugins.telescope'
require 'plugins.hop'
require 'lsp.init'

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    use 'shaunsingh/nord.nvim'
    use 'nvim-treesitter/nvim-treesitter'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v1.*' }

    use 'kylechui/nvim-surround'
    use 'phaazon/hop.nvim'

    use 'LnL7/vim-nix'
    use 'elkowar/yuck.vim'

    use 'weilbith/nvim-code-action-menu'
    use "lukas-reineke/lsp-format.nvim"

    use "williamboman/nvim-lsp-installer"
    use 'neovim/nvim-lspconfig'
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'ray-x/lsp_signature.nvim'

    use 'noib3/nvim-cokeline'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'

    use 'nvim-lua/plenary.nvim'
    use 'sindrets/diffview.nvim'
    use 'lewis6991/gitsigns.nvim'

    use 'andweeb/presence.nvim'
end)
