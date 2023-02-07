local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').julials.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
