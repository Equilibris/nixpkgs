local stage_file = function(fname)
	print(fname.absolute_path)
	vim.cmd('git stage ' .. fname.absolute_path)
end
local unstage_file = function(fname)
	print(fname)
end

require('nvim-tree').setup {
	sort_by = 'case_sensitive',
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
				{
					key = '<C-e>',
					action = 'edit_in_place',
				},
				{
					key = 'O',
					action = 'edit_no_picker',
				},
				{ key = { '<C-]>', '<2-RightMouse>' }, action = 'cd' },
				{ key = '<C-v>', action = 'vsplit' },
				{ key = '<C-x>', action = 'split' },
				{ key = '<C-t>', action = 'tabnew' },
				{
					key = '<',
					action = 'prev_sibling',
				},
				{
					key = '>',
					action = 'next_sibling',
				},
				{
					key = 'P',
					action = 'parent_node',
				},
				{
					key = '<BS>',
					action = 'close_node',
				},
				{ key = '<Tab>', action = 'preview' },
				{
					key = 'K',
					action = 'first_sibling',
				},
				{
					key = 'J',
					action = 'last_sibling',
				},
				{
					key = 'I',
					action = 'toggle_git_ignored',
				},
				{
					key = 'H',
					action = 'toggle_dotfiles',
				},
				{
					key = 'U',
					action = 'toggle_custom',
				},
				{ key = 'R', action = 'refresh' },
				{ key = 'a', action = 'create' },
				{ key = 'd', action = 'remove' },
				{ key = 'D', action = 'trash' },
				{ key = 'r', action = 'rename' },
				{
					key = '<C-r>',
					action = 'full_rename',
				},
				{ key = 'x', action = 'cut' },
				{ key = 'c', action = 'copy' },
				{ key = 'p', action = 'paste' },
				{
					key = 'y',
					action = 'copy_name',
				},
				{
					key = 'Y',
					action = 'copy_path',
				},
				{
					key = 'gy',
					action = 'copy_absolute_path',
				},
				{
					key = '[e',
					action = 'prev_diag_item',
				},
				{
					key = '[c',
					action = 'prev_git_item',
				},
				{
					key = ']e',
					action = 'next_diag_item',
				},
				{
					key = ']c',
					action = 'next_git_item',
				},
				{ key = '-', action = 'dir_up' },
				{
					key = '/',
					action = 'live_filter',
				},
				{
					key = 'F',
					action = 'clear_live_filter',
				},
				{ key = 'q', action = 'close' },
				{
					key = 'W',
					action = 'collapse_all',
				},
				{
					key = 'E',
					action = 'expand_all',
				},
				{
					key = '.',
					action = 'run_file_command',
				},
				{
					key = '<C-k>',
					action = 'toggle_file_info',
				},
				{
					key = 'g?',
					action = 'toggle_help',
				},
				{
					key = 's',
					action = 'noop',
					action_cb = stage_file,
				},
				{
					key = 'S',
					action = 'noop',
					action_cb = unstage_file,
				},
			},
		},
	},
	live_filter = {
		prefix = '[/]: ',
		always_show_folders = true,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
}
