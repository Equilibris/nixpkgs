vim.api.nvim_create_user_command('HMSwitch', '! home-manager switch', {})
vim.api.nvim_create_user_command('EwwBar', '! eww open bar', {})

local group = vim.api.nvim_create_augroup('WilliamS', {
	clear = true,
})

vim.api.nvim_create_autocmd(
	'BufWritePost',
	{ pattern = '*.lua', command = 'luafile %', group = group }
)
vim.api.nvim_create_autocmd(
	'BufWritePost',
	{ pattern = 'home.nix', command = 'HMSwitch', group = group }
)

vim.api.nvim_create_autocmd(
	'CursorHold',
	{ command = "lua require('hover').hover()", group = group }
)

vim.api.nvim_create_autocmd(
	'BufWritePre',
	{ command = 'lua vim.lsp.buf.formatting_sync()', group = group }
)
