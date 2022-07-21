-- https://github.com/nanotee/nvim-lua-guide
require 'sets'
require 'maps'
require 'commands'
require 'plugins.toggleterm'
require 'plugins.treesitter'
require 'plugins.nvim-tree'
require 'plugins.telescope'
require 'plugins.cokeline'
require 'plugins.presence'
require 'plugins.gitsigns'
require 'plugins.diffview'
require 'plugins.surround'
require 'plugins.comment'
require 'plugins.lualine'
require 'plugins.hop'
require 'lsp.init'

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'shaunsingh/nord.nvim'
    use 'nvim-treesitter/nvim-treesitter'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v1.*' }

    use 'kylechui/nvim-surround'
    use 'phaazon/hop.nvim'

    use 'LnL7/vim-nix'
    use 'elkowar/yuck.vim'

    use 'gpanders/editorconfig.nvim'

    use 'weilbith/nvim-code-action-menu'
    use 'jose-elias-alvarez/null-ls.nvim'

    use { 'saecki/crates.nvim', tag = 'v0.2.1' }

    use 'lewis6991/hover.nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'b0o/schemastore.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'neovim/nvim-lspconfig'
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'ray-x/lsp_signature.nvim'
    use 'terrortylor/nvim-comment'

    use 'noib3/nvim-cokeline'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'

    use 'nvim-lua/plenary.nvim'
    use 'sindrets/diffview.nvim'
    use 'lewis6991/gitsigns.nvim'

    use 'andweeb/presence.nvim'
end)
