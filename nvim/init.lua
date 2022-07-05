-- https://github.com/nanotee/nvim-lua-guide
require 'sets'
require 'maps'
require 'commands'
require 'plugins.toggleterm'
require 'plugins.nvim-tree'
require 'plugins.lualine'
require 'plugins.presence'
require 'plugins.gitsigns'
require 'plugins.diffview'
require 'lsp.init'

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
	use 'shaunsingh/nord.nvim'
	use 'nvim-treesitter/nvim-treesitter'

	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {'akinsho/toggleterm.nvim', tag = 'v1.*' }

	use 'LnL7/vim-nix'
	use 'neovim/nvim-lspconfig'

	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'

	use 'nvim-lua/plenary.nvim'
	use 'sindrets/diffview.nvim'
	use 'lewis6991/gitsigns.nvim'

	use 'andweeb/presence.nvim'
end)

