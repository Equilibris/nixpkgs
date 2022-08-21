local null_ls = require 'null-ls'

null_ls.setup {
	sources = {
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.proselint,
		-- null_ls.builtins.diagnostics.cspell,
		null_ls.builtins.hover.dictionary,

		null_ls.builtins.formatting.stylua,

		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.eslint,

		null_ls.builtins.code_actions.gitsigns,

		null_ls.builtins.code_actions.statix,

		null_ls.builtins.diagnostics.cspell,
	},
}
