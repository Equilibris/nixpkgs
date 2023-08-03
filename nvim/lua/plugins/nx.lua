local nx = require 'nx'

nx.setup {
	nx_cmd_root = 'npx nx',
}

vim.api.nvim_create_user_command('Actions', 'Telescope nx actions', {})
vim.api.nvim_create_user_command('Gens', 'Telescope nx generators', {})
