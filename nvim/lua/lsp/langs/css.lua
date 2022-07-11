local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

-- require('lspconfig')['pyright'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
-- require('lspconfig')['tsserver'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
require('lspconfig').cssls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
