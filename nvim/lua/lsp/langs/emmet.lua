local lspconfig = require('lspconfig')

local config = require 'lsp.config'
local on_attach = config.on_attach
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    flags = lsp_flags,
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'svelte', 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
})
