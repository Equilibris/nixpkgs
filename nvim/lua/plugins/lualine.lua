local signature = function()
	return require('lsp_signature').status_line(50)
end

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'catppuccin',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_d = { signature },
		lualine_x = {},
		lualine_y = { 'encoding', 'filetype' },
		lualine_z = { 'progress', 'location' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_y = { 'location' },
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}
