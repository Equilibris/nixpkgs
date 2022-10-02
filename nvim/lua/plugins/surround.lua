require('nvim-surround').setup {
	-- keymaps = { -- vim-surround style keymaps
	-- 	-- insert = 'ys',
	-- 	visual = 'S',
	-- 	delete = 'ds',
	-- 	change = 'cs',
	-- },
	-- surrounds = {
	-- 	pairs = {
	-- 		['('] = { '( ', ' )' },
	-- 		[')'] = { '(', ')' },
	-- 		['{'] = { '{ ', ' }' },
	-- 		['}'] = { '{', '}' },
	-- 		['<'] = { '< ', ' >' },
	-- 		['>'] = { '<', '>' },
	-- 		['['] = { '[ ', ' ]' },
	-- 		[']'] = { '[', ']' },
	-- 	},
	-- 	separators = {
	-- 		["'"] = { "'", "'" },
	-- 		['"'] = { '"', '"' },
	-- 		['`'] = { '`', '`' },
	-- 	},
	-- 	HTML = {
	-- 		['t'] = true, -- Use "t" for HTML-style mappings
	-- 	},
	-- 	aliases = {
	-- 		['a'] = '>', -- Single character aliases apply everywhere
	-- 		['b'] = ')',
	-- 		['B'] = '}',
	-- 		['r'] = ']',
	-- 		['q'] = { '"', "'", '`' }, -- Table aliases only apply for changes/deletions
	-- 	},
	-- },
}

-- Hack to remove insertmode mappings
vim.api.nvim_set_keymap('i', 'ys', 'ys', { noremap = true })
vim.api.nvim_del_keymap('i', 'ys')
