vim.opt.conceallevel = 1

require('obsidian').setup {
	-- Each path should be the path to the vault root. If you use the Obsidian app,
	-- the vault root is the parent directory of the `.obsidian` folder.
	-- You can also provide configuration overrides for each workspace through the `overrides` field.
	workspaces = {
		{
			name = 'Main',
			path = '~/obsidian-vault',
		},
	},
	disable_frontmatter = true,
}
