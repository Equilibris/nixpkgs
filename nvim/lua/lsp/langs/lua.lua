local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').sumneko_lua.setup {
	on_attach = on_attach,
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
