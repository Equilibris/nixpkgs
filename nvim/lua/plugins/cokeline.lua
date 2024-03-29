local get_hex = require('cokeline/utils').get_hex
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

if false then
    require('cokeline').setup {
        -- Only show the bufferline when there are at least this many visible buffers.
        -- default: `1`.
        show_if_buffers_are_at_least = 1,

        -- buffers = {
        --   -- A function to filter out unwanted buffers. Takes a buffer table as a
        --   -- parameter (see the following section for more infos) and has to return
        --   -- either `true` or `false`.
        --   -- default: `false`.
        --   filter_valid = function(buffer) -> true | false,

        --   -- A looser version of `filter_valid`, use this function if you still
        --   -- want the `cokeline-{switch,focus}-{prev,next}` mappings to work for
        --   -- these buffers without displaying them in your bufferline.
        --   -- default: `false`.
        --   filter_visible = function(buffer) -> true | false,

        --   -- Which buffer to focus when a buffer is deleted, `prev` focuses the
        --   -- buffer to the left of the deleted one while `next` focuses the one the
        --   -- right. Turned off by default.
        --   -- default: `false`
        --   focus_on_delete = 'prev' | 'next',

        --   -- If set to `last` new buffers are added to the end of the bufferline,
        --   -- if `next` they are added next to the current buffer.
        --   -- default: 'last',
        --   new_buffers_position = 'last' | 'next',
        -- },

        mappings = {
            -- Controls what happens when the first (last) buffer is focused and you
            -- try to focus/switch the previous (next) buffer. If `true` the last
            -- (first) buffers gets focused/switched, if `false` nothing happens.
            -- default: `true`.
            cycle_prev_next = true,
        },

        -- rendering = {
        -- 	-- The maximum number of characters a rendered buffer is allowed to take
        -- 	-- up. The buffer will be truncated if its width is bigger than this
        -- 	-- value.
        -- 	-- default: `999`.
        -- 	max_buffer_width = 999,
        -- },

        -- The default highlight group values.
        -- The `fg` and `bg` keys are either colors in hexadecimal format or
        -- functions taking a `buffer` parameter and returning a color in
        -- hexadecimal format. Similarly, the `style` key is either a string
        -- containing a comma separated list of items in `:h attr-list` or a
        -- function returning one.
        default_hl = {
            -- default: `ColorColumn`'s background color for focused buffers,
            -- `Normal`'s foreground color for unfocused ones.
            -- fg = '#rrggbb' | function(buffer) -> '#rrggbb',

            -- default: `Normal`'s foreground color for focused buffers,
            -- `ColorColumn`'s background color for unfocused ones.
            -- default: `Normal`'s foreground color.
            -- bg = '#rrggbb' | function(buffer) -> '#rrggbb',

            -- default: `'NONE'`.
            -- style = 'attr1,attr2,...' | function(buffer) -> 'attr1,attr2,...',
            -- 	fg = function(buffer)
            -- 		return buffer.is_focused and get_hex('Normal', 'fg')
            -- 			or get_hex('Comment', 'fg')
            -- 	end,
            -- 	bg = get_hex('Normal', 'bg'),
        },

        -- A list of components to be rendered for each buffer. Check out the section
        -- below explaining what this value can be set to.
        -- default: see `/lua/cokeline/defaults.lua`
        components = {
            {
                text = function(buffer)
                    return (buffer.index ~= 1) and '' or ''
                end,
            },
            {
                text = '  ',
            },
            {
                text = function(buffer)
                    return (is_picking_focus() or is_picking_close())
                            and buffer.pick_letter .. ' '
                        or buffer.devicon.icon
                end,
                fg = function(buffer)
                    return (is_picking_focus() and yellow)
                        or (is_picking_close() and red)
                        or buffer.devicon.color
                end,
                style = function(_)
                    return (is_picking_focus() or is_picking_close())
                            and 'italic,bold'
                        or nil
                end,
            },
            {
                text = ' ',
            },
            {
                text = function(buffer)
                    return buffer.filename .. '  '
                end,
                style = function(buffer)
                    return buffer.is_focused and 'bold' or nil
                end,
            },
            {
                text = '',
                delete_buffer_on_left_click = true,
            },
            {
                text = '  ',
            },
        },

        -- Left sidebar to integrate nicely with file explorer plugins.
        -- This is a table containing a `filetype` key and a list of `components` to
        -- be rendered in the sidebar.
        -- The last component will be automatically space padded if necessary
        -- to ensure the sidebar and the window below it have the same width.
        sidebar = {
            filetype = 'NvimTree',
            components = {
                {
                    text = '  NvimTree',
                    fg = yellow,
                    bg = get_hex('NvimTreeNormal', 'bg'),
                    style = 'bold',
                },
            },
        },
    }
end
