vim.api.nvim_create_user_command("HMSwitch", "! home-manager switch", {})

local group = vim.api.nvim_create_augroup("WilliamS", {
    clear = true,
});

vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "*.lua", command = "luafile %", group = group }
)
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "home.nix", command = "HMSwitch", group = group }
)

