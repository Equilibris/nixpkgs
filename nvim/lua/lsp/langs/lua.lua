local config = require 'lsp.config'
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').sumneko_lua.setup {
	on_attach = config.create_on_attach_effect(function(client, bufnr)
		vim.opt.spell = false

		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		vim.api.nvim_buf_set_option(bufnr, 'tabstop', 2)
		vim.api.nvim_buf_set_option(bufnr, 'softtabstop', 2)
		vim.api.nvim_buf_set_option(bufnr, 'shiftwidth', 2)
		vim.api.nvim_buf_set_option(bufnr, 'expandtab', false)
		vim.api.nvim_buf_set_option(bufnr, 'smartindent', true)
	end),
	capabilities = capabilities,
	-- You will have to adjust your values according to your system
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim', 'use' },
			},
			runtime = {
				version = 'Lua 5.3',
				path = {
					'?.lua',
					'?/init.lua',
					vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
					vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua',
					vim.fn.expand '~/.config/nvim/lua',
					'/usr/share/5.3/?.lua',
					'/usr/share/lua/5.3/?/init.lua',
				},
			},
			workspace = {
				library = {
					[vim.fn.expand '$VIMRUNTIME/lua'] = true,
					[vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
					[vim.fn.expand '/usr/share/awesome/lib'] = true,
					--vim.fn.expand'~/.luarocks/share/lua/5.3',
					--'/usr/share/lua/5.3'
				},
			},
		},
	},
}
