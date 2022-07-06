local nore = { noremap = true }

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<C-o>', '<C-d>', nore)
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", {})
vim.api.nvim_set_keymap("i", "<C-H>", "<C-W>", {})

vim.api.nvim_set_keymap('n', '<C-B>', ':NvimTreeToggle<CR>', nore)
vim.api.nvim_set_keymap('i', '<C-B>', '<C-C>:NvimTreeToggle<CR>', nore)

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', nore)

vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', nore)
vim.api.nvim_set_keymap('n', "<A-k>", ":m .-2<CR>==", nore)
-- vim.api.nvim_set_keymap('i', "<A-j>", "<Esc>:m .+1<CR>==gi", nore)
-- vim.api.nvim_set_keymap('i', "<A-k>", "<Esc>:m .-2<CR>==gi", nore)
vim.api.nvim_set_keymap('v', "<A-j>", ":m '>+1<CR>gv=gv", nore)
vim.api.nvim_set_keymap('v', "<A-k>", ":m '<-2<CR>gv=gv", nore)

vim.api.nvim_set_keymap('n', "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", nore)
vim.api.nvim_set_keymap('n', "<C-F>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", nore)
vim.api.nvim_set_keymap('n', "<leader>bf", "<cmd>lua require('telescope.builtin').buffers()<cr>", nore)
vim.api.nvim_set_keymap('n', "<leader>hf", "<cmd>lua require('telescope.builtin').help_tags()<cr>", nore)

vim.api.nvim_set_keymap('n', "<Leader>f", "<Plug>(cokeline-pick-focus)", nore)
vim.api.nvim_set_keymap('n', "<Leader>F", "<Plug>(cokeline-pick-close)", nore)

vim.api.nvim_set_keymap('n', "<C-ø>", ":CodeActionMenu", nore)
vim.api.nvim_set_keymap('i', "<C-ø>", ":CodeActionMenu", nore)

vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>vsplit<cr>", nore)
vim.api.nvim_set_keymap("i", "<C-s>", "<cmd>vsplit<cr>", nore)

vim.api.nvim_set_keymap("n", "<A-F>", "<cmd>Format<cr>", nore)
vim.api.nvim_set_keymap("i", "<A-F>", "<cmd>Format<cr>", nore)
