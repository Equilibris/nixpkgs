require('neorg').setup {
	load = {
		['core.defaults'] = {}, -- Loads default behaviour
		['core.concealer'] = {
			config = {
				icon_preset = 'diamond',
			},
		}, -- Adds pretty icons to your documents
		-- ['core.ui.calendar'] = {},
		['core.completion'] = {
			config = {
				engine = 'nvim-cmp',
			},
		},
		['core.dirman'] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					notes = '~/Org',
				},
			},
		},
		['core.summary'] = {},
	},
}
