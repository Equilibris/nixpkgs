require 'lsp.langs.rust'
require 'lsp.langs.java'

local trivial_lsps = {
	lua_ls = {
		on_attach = function(client, bufnr)
			vim.opt.spell = false

			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			vim.api.nvim_buf_set_option(bufnr, 'tabstop', 2)
			vim.api.nvim_buf_set_option(bufnr, 'softtabstop', 2)
			vim.api.nvim_buf_set_option(bufnr, 'shiftwidth', 2)
			vim.api.nvim_buf_set_option(bufnr, 'expandtab', false)
			vim.api.nvim_buf_set_option(bufnr, 'smartindent', true)
		end,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim', 'use' },
				},
				runtime = {
					version = 'Lua 5.3',
					path = {
						'?.lua',
						'?/init.lua',
						vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
						vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua',
						vim.fn.expand '~/.config/nvim/lua',
						'/usr/share/5.3/?.lua',
						'/usr/share/lua/5.3/?/init.lua',
					},
				},
				workspace = {
					library = {
						[vim.fn.expand '$VIMRUNTIME/lua'] = true,
						[vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
						[vim.fn.expand '/usr/share/awesome/lib'] = true,
						--vim.fn.expand'~/.luarocks/share/lua/5.3',
						--'/usr/share/lua/5.3'
					},
				},
			},
		},
	},
	jsonls = {
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
	},
	texlab = {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
	},
	tsserver = {
		cmd = {
			'typescript-language-server',
			'--stdio',
			'--tsserver-path',
			'~/.npm-global/lib/node_modules/typescript/lib',
		},
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		settings = {
			['vtsls.experimental.completion.enableServerSideFuzzyMatch'] = true,
			['vtsls.experimental.completion.entriesLimit'] = 10,
			['typescript.preferences.includePackageJsonAutoImports'] = 'off',
			['typescript.tsserver.useSyntaxServer'] = 'never',
			['typescript.tsserver.experimental.enableProjectDiagnostics'] = 'off',
			['typescript.tsserver.trace'] = 'verbose',
			['typescript.tsserver.maxTsServerMemory'] = '16GB',
		},
	},
	emmet_ls = {
		filetypes = {
			'svelte',
			'html',
			'typescriptreact',
			'javascriptreact',
			'css',
			'sass',
			'scss',
			'less',
		},
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					['bem.enabled'] = true,
				},
			},
		},
	},
	clangd = {},
	cssls = {},
	rnix = {},
	statix = {},
	pyright = {},
	julials = {},
	sqlls = {},
	svelte = {},
	arduino_language_server = {},
}

local lspconfig = require 'lspconfig'
local config = require 'lsp.config'

for key, data in pairs(trivial_lsps) do
	local setup = {
		flags = config.lsp_flags,
		capabilities = config.capabilities,
		on_attach = config.on_attach,
	}

	if data.cmd ~= nil then
		setup.cmd = data.cmd
	end
	if data.settings ~= nil then
		setup.settings = data.settings
	end
	if data.init_options ~= nil then
		setup.filetypes = data.init_options
	end
	if data.filetypes ~= nil then
		setup.filetypes = data.filetypes
	end
	if data.on_attach ~= nil then
		setup.on_attach = config.create_on_attach_effect(data.on_attach)
	end

	lspconfig[key].setup(setup)
end
