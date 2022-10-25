if true then
	local nx = require 'nx'

	nx.setup {}

	vim.api.nvim_create_user_command('Actions', 'Telescope nx actions', {})
	vim.api.nvim_create_user_command('Gens', 'Telescope nx generators', {})
end
