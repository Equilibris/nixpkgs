vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = '/home/williams/.vim/undodir'

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.incsearch = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 10
vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.list = true

vim.opt.mouse = ''

-- vim.opt.listchars = "eol:¬,tab:->,trail:~,extends:>,precedes:<,space:⋅⋅"

vim.opt.updatetime = 1000

vim.cmd [[ colorscheme nord ]]
