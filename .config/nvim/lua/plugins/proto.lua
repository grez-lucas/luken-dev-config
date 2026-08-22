-- Protobuf support, for buf-based backends (see buken-app/backend).
--
-- The LSP, the linter and the formatter are all the `buf` CLI itself, so
-- there is nothing for Mason to install; `buf` has to be on PATH.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "proto" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- `cmd`, `filetypes` and `root_markers` come from lspconfig's
        -- bundled lsp/buf_ls.lua; it shells out to `buf lsp serve`.
        buf_ls = {},
      },
    },
    init = function()
      -- buf's own config files are not detected as a filetype, so buf_ls
      -- never attaches to them without this.
      vim.filetype.add({
        filename = {
          ["buf.yaml"] = "buf-config",
          ["buf.gen.yaml"] = "buf-config",
          ["buf.lock"] = "buf-config",
          ["buf.work.yaml"] = "buf-config",
        },
      })
      -- Highlight them as YAML; there is no buf-config parser.
      vim.treesitter.language.register("yaml", "buf-config")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
