-- Nord, with the comment contrast raised.
--
-- Upstream sets Comment/@comment to polar_night.light (#616E88) on #2E3440,
-- which measures 2.43:1 against WCAG's 4.5:1 floor for body text. #93A1BB is
-- 4.79:1. Italics are dropped for the same reason: thin oblique strokes are
-- the hardest thing to read at low contrast.
local comment_fg = "#93A1BB"

return {
  {
    "gbprod/nord.nvim",
    opts = {
      styles = {
        comments = {},
      },
    },
    init = function()
      -- Must be an autocmd, not a bare call: the colorscheme loads after the
      -- plugin spec is read and would otherwise clobber these.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nord",
        group = vim.api.nvim_create_augroup("nord_overrides", { clear = true }),
        callback = function()
          vim.api.nvim_set_hl(0, "Comment", { fg = comment_fg })
          vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
          vim.api.nvim_set_hl(0, "@comment.documentation", { link = "Comment" })
          vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "Comment" })
          vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#88C0D0" })
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
