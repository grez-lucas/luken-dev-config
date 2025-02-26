vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})

-- windows
vim.keymap.set("n", "<C-w>-", ":split<enter>", {noremap=false})
vim.keymap.set("n", "<C-w>\\", ":vsplit<enter>", {noremap=false})
-- Try to search for a new file using telescope and open it vertically
-- vim.keymap.set("n", "<C-w>\\p", ":vne <enter><leader>pf", {noremap=false})



vim.keymap.set("n", "<leader><leader>", function ()
    vim.cmd("so")
end)


-- Yank including Last Character
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [["+Y]])

-- Delete Current Line
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Diagnostic keymaps
--  Take you to the first diagnosed error
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
