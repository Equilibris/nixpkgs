vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

vim.g.vimtex_compiler_latexmk = {
	build_dir = '',
	callback = 1,
	build_dir = '',
	callback = 1,
	continuous = 1,
	executable = 'latexmk',
	hooks = {},
	options = {
		'--shell-escape',
		'-verbose',
		'-file-line-error',
		'-synctex=1',
		'-interaction=nonstopmode',
	},
}

vim.cmd [[
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
]]
