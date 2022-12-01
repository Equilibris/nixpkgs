local config = require 'lsp.config'
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').texlab.setup {
	on_attach = config.create_on_attach_effect(function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'linebreak', true)
		vim.api.nvim_buf_set_option(bufnr, 'wrap', true)
	end),
	capabilities = capabilities,
	settings = {},
}
