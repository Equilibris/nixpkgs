local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

require('lspconfig').jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
}
