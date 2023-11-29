local config = require 'lsp.config'

require('lean').setup {
	lsp = { on_attach = config.on_attach },
	mappings = true,
}
