local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').tsserver.setup {
	on_attach = config.create_on_attach_effect(function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end),
	capabilities = capabilities,
	settings = {},
}
