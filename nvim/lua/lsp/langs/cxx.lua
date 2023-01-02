local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').clangd.setup {
	on_attach = config.create_on_attach_effect(function(client, bufnr) end),
	capabilities = capabilities,
	settings = {},
}
