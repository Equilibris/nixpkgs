require('git-worktree').setup {}
require('telescope').load_extension 'git_worktree'

vim.api.nvim_create_user_command(
	'WTSwitch',
	require('telescope').extensions.git_worktree.git_worktrees,
	{}
)
vim.api.nvim_create_user_command(
	'WTCrate',
	require('telescope').extensions.git_worktree.create_git_worktree,
	{}
)
