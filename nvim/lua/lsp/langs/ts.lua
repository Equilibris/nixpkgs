local config = require 'lsp.config'
local lsp_flags = config.lsp_flags
local capabilities = config.capabilities

-- require('vtsls').config {
-- 	-- customize handlers for commands
-- 	-- handlers = {
-- 	--     source_definition = function(err, locations) end,
-- 	--     file_references = function(err, locations) end,
-- 	--     code_action = function(err, actions) end,
-- 	-- },
-- 	-- automatically trigger renaming of extracted symbol
-- 	refactor_auto_rename = true,
-- }

-- require('lspconfig.configs').vtsls = require('vtsls').lspconfig -- set default server config, optional but recommended

-- local cmd = require('vtsls').lspconfig.default_config.cmd

-- table.insert(cmd, '--tsserver-path')
-- table.insert(cmd, '~/.npm-global/lib/node_modules/typescript/lib')
-- vim.print(cmd)

require('lspconfig').tsserver.setup {
	cmd = {
		'typescript-language-server',
		'--stdio',
		'--tsserver-path',
		'~/.npm-global/lib/node_modules/typescript/lib',
	},
	on_attach = config.create_on_attach_effect(function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end),
	capabilities = capabilities,
	settings = {
		['vtsls.experimental.completion.enableServerSideFuzzyMatch'] = true,
		['vtsls.experimental.completion.entriesLimit'] = 10,
		['typescript.preferences.includePackageJsonAutoImports'] = 'off',
		['typescript.tsserver.useSyntaxServer'] = 'never',
		['typescript.tsserver.experimental.enableProjectDiagnostics'] = 'off',
		['typescript.tsserver.trace'] = 'verbose',
		['typescript.tsserver.maxTsServerMemory'] = '16GB',
	},
}
