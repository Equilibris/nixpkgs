vim.api.nvim_create_user_command('HMSwitch', '! home-manager switch', {})
vim.api.nvim_create_user_command('Problems', 'Telescope diagnostics', {})
vim.api.nvim_create_user_command('GC', 'GitCommit', {})
vim.api.nvim_create_user_command('GitCommit', 'Neogit commit', {})
vim.api.nvim_create_user_command('GAS', 'GitAddSelf', {})
vim.api.nvim_create_user_command('GitAddSelf', '! git add %', {})

local group = vim.api.nvim_create_augroup('WilliamS', {
	clear = true,
})

-- vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
-- 	command = 'silent luafile init.lua',
-- })

vim.api.nvim_create_autocmd(
	'BufWritePost',
	{ pattern = '*.lua', command = 'silent luafile %', group = group }
)
-- vim.api.nvim_create_autocmd(
-- 	'BufWritePost',
-- 	{ pattern = '*.tex', command = 'silent VimtexCompile', group = group }
-- )
-- vim.api.nvim_create_autocmd(
-- 	'BufWritePost',
-- 	{ pattern = 'home.nix', command = 'HMSwitch', group = group }
-- )

vim.api.nvim_create_autocmd(
	'BufWinLeave',
	{ pattern = '*', group = group, command = 'silent! mkview' }
)
vim.api.nvim_create_autocmd(
	'BufWinEnter',
	{ pattern = '*', group = group, command = 'silent! loadview' }
)
vim.api.nvim_create_autocmd(
	'BufWinEnter',
	{
		pattern = '*.norg',
		group = group,
		command = 'setlocal wrap linebreak textwidth=80',
	}
)

-- vim.api.nvim_create_autocmd(
-- 	'CursorHold',
-- 	{ command = "silent lua require('hover').hover()", group = group }
-- )

vim.cmd [[cabbrev wq execute "lua vim.lsp.buf.formatting_sync()" <bar> wq]]
vim.api.nvim_create_autocmd('BufWritePre', {
	-- command = 'silent lua vim.lsp.buf.formatting()',
	callback = function(c)
		vim.lsp.buf.format {
			filter = function(client)
				return client.name ~= 'texlab' and client.name ~= 'tsserver'
			end,
		}
	end,
	pattern = '*',
	group = group,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'LuasnipChoiceNodeEnter',
	callback = function()
		-- vim.ui.select()
	end,
	group = group,
})

vim.cmd [[
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction
]]
