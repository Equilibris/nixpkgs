local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	}
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	if packer_bootstrap then
		require('packer').sync()
	end
	use 'wbthomason/packer.nvim'

	use 'nvim-neorg/neorg'
	use 'epwalsh/obsidian.nvim'

	use 'folke/zen-mode.nvim'

	use 'ahmedkhalf/project.nvim'

	use { 'catppuccin/nvim', as = 'catppuccin' }
	use 'shaunsingh/nord.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'sirtaj/vim-openscad'

	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'folke/trouble.nvim'
	use 'akinsho/toggleterm.nvim'

	use 'kylechui/nvim-surround'
	use 'windwp/nvim-autopairs'
	use 'phaazon/hop.nvim'
	use 'abecodes/tabout.nvim'
	use 'declancm/cinnamon.nvim'

	use 'LnL7/vim-nix'
	use 'lervag/vimtex'
	use 'elkowar/yuck.vim'
	use 'rest-nvim/rest.nvim'

	use 'gpanders/editorconfig.nvim'

	use 'weilbith/nvim-code-action-menu'
	use 'jose-elias-alvarez/null-ls.nvim'

	use { 'saecki/crates.nvim', tag = 'v0.2.1' }

	use 'lewis6991/hover.nvim'
	use 'williamboman/mason.nvim'
	use 'yioneko/nvim-vtsls'
	use 'williamboman/mason-lspconfig.nvim'
	use 'b0o/schemastore.nvim'
	use 'simrat39/rust-tools.nvim'
	use 'Julian/lean.nvim'
	use 'kristijanhusak/vim-dadbod'
	use 'kristijanhusak/vim-dadbod-ui'
	use 'kristijanhusak/vim-dadbod-completion'
	use 'mfussenegger/nvim-jdtls'
	use 'neovim/nvim-lspconfig'
	use 'L3MON4D3/LuaSnip'
	use {
		'saadparwaiz1/cmp_luasnip',
		-- TODO: Auto install with choice cmp option
		-- installer = require('lsp.snip.self-merging-installer').installer,
		-- updater = require('lsp.snip.self-merging-installer').updater,
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'ray-x/lsp_signature.nvim'
	use 'terrortylor/nvim-comment'
	-- use {
	-- 	'tzachar/cmp-tabnine',
	-- 	run = './install.sh',
	-- 	requires = 'hrsh7th/nvim-cmp',
	-- }
	use 'ThePrimeagen/git-worktree.nvim'

	use 'noib3/nvim-cokeline'
	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'

	use 'sindrets/diffview.nvim'
	use 'lewis6991/gitsigns.nvim'
	use 'NeoGitOrg/neogit'
	use 'tpope/vim-fugitive'
	use 'rbong/vim-flog'

	use 'andweeb/presence.nvim'

	use 'stevearc/vim-arduino'
	use 'p00f/cphelper.nvim'

	use '~/Dev/MicroProjects/nx.nvim'
end)

-- https://github.com/nanotee/nvim-lua-guide
require 'sets'
require 'maps'
require 'commands'
require 'theming'

require 'plugins.telescope'

require 'plugins.toggleterm'
require 'plugins.treesitter'
require 'plugins.autopairs'
require 'plugins.nvim-tree'
require 'plugins.obsidian'
require 'plugins.cinnamon'
require 'plugins.trouble'
require 'plugins.worktree'
require 'plugins.cokeline'
require 'plugins.presence'
require 'plugins.surround'
require 'plugins.comment'
require 'plugins.lualine'
require 'plugins.project'
require 'plugins.vimtex'
require 'plugins.arduino'
require 'plugins.dadbod'
require 'plugins.tabout'
require 'plugins.neorg'
-- require 'plugins.git'
require 'plugins.hop'
require 'plugins.nx'
require 'plugins.cp'
require 'lsp.init'
