-- This will be used for general NVIM options

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent= true

vim.opt.wrap = false

-- Set Highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- turn off swapfile
vim.opt.swapfile = false
