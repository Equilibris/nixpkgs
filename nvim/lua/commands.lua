vim.api.nvim_create_user_command('HMSwitch', '! home-manager switch', {})
vim.api.nvim_create_user_command('Problems', 'Telescope diagnostics', {})
vim.api.nvim_create_user_command('GC', 'GitCommit', {})
vim.api.nvim_create_user_command('GitCommit', 'Neogit commit', {})
vim.api.nvim_create_user_command('GAS', 'GitAddSelf', {})
vim.api.nvim_create_user_command('GitAddSelf', '! git add %', {})

local group = vim.api.nvim_create_augroup('WilliamS', {
	clear = true,
})

vim.api.nvim_create_autocmd(
	'BufWritePost',
	{ pattern = '*.lua', command = 'silent luafile %', group = group }
)
vim.api.nvim_create_autocmd(
	'BufWritePost',
	{ pattern = 'home.nix', command = 'HMSwitch', group = group }
)

vim.api.nvim_create_autocmd(
	'CursorHold',
	{ command = "silent lua require('hover').hover()", group = group }
)

vim.cmd [[cabbrev wq execute "lua vim.lsp.buf.formatting_sync()" <bar> wq]]
vim.api.nvim_create_autocmd(
	'BufWritePre',
	{ command = 'silent lua vim.lsp.buf.formatting()', group = group }
)

vim.api.nvim_create_autocmd('User', {
	pattern = 'LuasnipChoiceNodeEnter',
	callback = function()
		-- vim.ui.select()
	end,
	group = group,
})
