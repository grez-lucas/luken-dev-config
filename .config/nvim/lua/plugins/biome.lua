-- Biome is the JS/TS linter and formatter for buken-app (one binary for both).
-- The heavy lifting is LazyVim's `lang.typescript.biome` extra, enabled in
-- lazyvim.json: it declares the `biome` LSP server (so mason-lspconfig installs
-- and enables it) and appends conform's `biome-check` with `require_cwd = true`,
-- which is what keeps the formatter silent in projects that have no biome.json.
--
-- What the extra does not do is keep Biome and ESLint out of each other's way.
-- Lucas has repos on either tool (bukenCoaching_frontend is ESLint), and both
-- servers attach purely on finding their own config file upward, so a repo
-- carrying both configs would get two linters and two formatters on one buffer.
-- Biome wins there, because a repo that adopted Biome adopted it as the
-- replacement.
local biome_markers = { "biome.json", "biome.jsonc" }

-- lspconfig's shipped eslint root_dir, read straight from the runtime file.
-- Delegating to `vim.lsp.config.eslint.root_dir` would recurse: by the time the
-- override runs, that field *is* the override.
local shipped_root_dir = (function()
  local cache = {}
  return function(server)
    if not cache[server] then
      local file = assert(vim.api.nvim_get_runtime_file("lsp/" .. server .. ".lua", false)[1])
      cache[server] = assert(loadfile(file))().root_dir
    end
    return cache[server]
  end
end)()

return {
  -- mason-lspconfig would normally install `biome` off the back of the server
  -- declaration, but it did not fire here, so the install is declared where the
  -- tool is chosen rather than left implicit.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "biome" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = function(bufnr, on_dir)
            if vim.fs.root(bufnr, biome_markers) then
              return -- Biome project: never attach ESLint.
            end
            return shipped_root_dir("eslint")(bufnr, on_dir)
          end,
        },
      },
    },
  },
}
