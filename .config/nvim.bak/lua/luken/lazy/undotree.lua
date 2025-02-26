-- Shows a crazy tree of last undos, unlike other undos and re-do's
-- History is not linear!

return {
    "mbbill/undotree",

    config = function ()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
