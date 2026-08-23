-- Scope the Tailwind LSP to projects that actually use Tailwind.
--
-- lspconfig's shipped tailwindcss root_dir ends its marker list with `.git`, a
-- deliberate fallback for Tailwind v4 where a config file is optional. In a
-- monorepo that fallback matches everything: buken-app's mobile/ surface is
-- React Native with no Tailwind anywhere, and every .tsx in it would still get
-- the server, its class-name completions and its lint diagnostics.
--
-- So: same markers as upstream, minus `.git` and minus the Django/Phoenix/Rails
-- paths that will never appear in a React or React Native tree. A package.json
-- naming tailwindcss still counts, which is what covers a v4 project with no
-- tailwind.config.*.
local util = require("lspconfig.util")

local markers = {
  "tailwind.config.js",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "tailwind.config.ts",
  "postcss.config.js",
  "postcss.config.cjs",
  "postcss.config.mjs",
  "postcss.config.ts",
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local found = vim.fs.find(util.insert_package_json(vim.list_extend({}, markers), "tailwindcss", fname), {
              path = fname,
              upward = true,
            })[1]
            if found then
              on_dir(vim.fs.dirname(found))
            end
          end,
        },
      },
    },
  },
}
