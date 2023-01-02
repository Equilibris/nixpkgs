local nore = { noremap = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', {})
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {})

vim.api.nvim_set_keymap('n', '<C-B>', '<cmd>silent NvimTreeToggle<CR>', nore)
vim.api.nvim_set_keymap('i', '<C-B>', '<cmd>silent NvimTreeToggle<CR>', nore)

vim.api.nvim_set_keymap('i', '<C-N>', '<cmd>silent TroubleToggle<CR>', nore)
vim.api.nvim_set_keymap('n', '<C-N>', '<cmd>silent TroubleToggle<CR>', nore)

-- vim.api.nvim_set_keymap('n', '<C-B>', '<cmd>silent TroubleToggle<CR>', nore)
-- vim.api.nvim_set_keymap('i', '<C-B>', '<cmd>silent TroubleToggle<CR>', nore)

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', nore)

vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', nore)
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', nore)
-- vim.api.nvim_set_keymap('i', "<A-j>", "<Esc>:m .+1<CR>==gi", nore)
-- vim.api.nvim_set_keymap('i', "<A-k>", "<Esc>:m .-2<CR>==gi", nore)
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", nore)
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", nore)

local builtins = require 'telescope.builtin'
vim.keymap.set('n', '<C-p>', function()
	builtins.find_files {
		hidden = true,
		cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
	}
end, {})
vim.api.nvim_set_keymap(
	'n',
	'<C-F>',
	"<cmd>lua require('telescope.builtin').live_grep()<cr>",
	nore
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>bf',
	"<cmd>lua require('telescope.builtin').buffers()<cr>",
	nore
)
vim.api.nvim_set_keymap(
	'n',
	'<F1>',
	"<cmd>lua require('telescope.builtin').help_tags()<cr>",
	nore
)

vim.api.nvim_set_keymap('n', '<Leader>f', '<Plug>(cokeline-pick-focus)', nore)
vim.api.nvim_set_keymap('n', '<Leader>F', '<Plug>(cokeline-pick-close)', nore)

vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>CodeActionMenu<cr>', nore)
-- vim.api.nvim_set_keymap('i', '<C-c>', '<cmd>CodeActionMenu<cr>', nore)

vim.api.nvim_set_keymap('n', '<C-s>', '<cmd>vsplit<cr><C-w>l', nore)
vim.api.nvim_set_keymap('i', '<C-s>', '<cmd>w<cr>', nore)
vim.api.nvim_set_keymap('n', '<Leader><Space>', '<cmd>w<cr>', nore)
vim.api.nvim_set_keymap('n', 'Q', '<cmd>q<cr>', nore)
vim.api.nvim_set_keymap('n', '<C-Q>', '<cmd>q!<cr>', nore)

vim.api.nvim_set_keymap('n', '<A-F>', '<cmd>Format<cr>', nore)
vim.api.nvim_set_keymap('i', '<A-F>', '<cmd>Format<cr>', nore)

vim.api.nvim_set_keymap('n', '<Leader>z', 'zfaB', nore)

-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'f',
-- 	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
-- 	nore
-- )
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'F',
-- 	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
-- 	nore
-- )
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	't',
-- 	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
-- 	nore
-- )
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'T',
-- 	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
-- 	nore
-- )

vim.api.nvim_set_keymap('n', 'H', '<cmd>HopWord<cr>', nore)

local hover = require 'hover'

vim.keymap.set('n', 'K', hover.hover, { desc = 'hover.nvim' })
vim.keymap.set('n', 'gK', hover.hover_select, { desc = 'hover.nvim (select)' })
