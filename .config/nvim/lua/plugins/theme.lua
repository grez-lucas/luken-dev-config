return {
  -- add gruvbox
  { "gbprod/nord.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#88C0D0" }),
  },
}
