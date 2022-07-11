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
require('lspconfig').rust_analyzer.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            ["inlayHints.typeHints.enable"] = true,
            ["assist.importGranularity"] = "module",
            ["assist.importPrefix"] = "module",
            ["cargo.loadOutDirsFromCheck"] = true,
            ["cargo.buildScripts.enable"] = true,
            ["procMacro.attributes.enable"] = true,
            ["procMacro.enable"] = true,
        }
    }
}
