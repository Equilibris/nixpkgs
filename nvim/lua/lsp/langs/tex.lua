local config = require 'lsp.config'
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').texlab.setup {
	on_attach = config.create_on_attach_effect(function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end),
	capabilities = capabilities,
	settings = {},
}
