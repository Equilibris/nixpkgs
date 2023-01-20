local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities
-- local lsp_path = vim.env.NIL_PATH or 'target/debug/nil'

require('lspconfig').rnix.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}

require('lspconfig').statix.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
