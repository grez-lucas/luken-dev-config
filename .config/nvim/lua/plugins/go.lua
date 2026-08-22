-- Go and buf workflow for the buken-app monorepo.
--
-- nvim is opened at the monorepo root, but the Go module lives in backend/.
-- Anything that resolves imports from the editor's cwd sees no go.mod and
-- reports the whole file as unresolvable.
local function module_root(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  local mod = vim.fs.find("go.mod", { path = name, upward = true })[1]
  return mod and vim.fs.dirname(mod) or nil
end

-- Run a Makefile target from the directory holding the Makefile.
local function make(target)
  return function()
    local buf = vim.api.nvim_buf_get_name(0)
    local mk = vim.fs.find("Makefile", { path = buf, upward = true })[1]
    if not mk then
      vim.notify("no Makefile above " .. buf, vim.log.levels.WARN)
      return
    end
    vim.cmd("botright split | resize 15 | terminal make -C " .. vim.fn.shellescape(vim.fs.dirname(mk)) .. " " .. target)
    vim.cmd("startinsert")
  end
end

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    init = function()
      -- golangci-lint loads the package graph relative to its cwd. Without
      -- this it runs at the monorepo root and every Go buffer gets bogus
      -- "could not import <dep>" typecheck diagnostics, even though gopls
      -- reports the same file clean. Fires ahead of LazyVim's debounced lint.
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("golangcilint_module_root", { clear = true }),
        pattern = "*.go",
        callback = function(ev)
          local root = module_root(ev.buf)
          if root then
            require("lint").linters.golangcilint.cwd = root
          end
        end,
      })
    end,
  },

  -- ADR-0002 puts the schema gate on pre-commit. These run the same targets
  -- without leaving the editor, so a proto edit can be checked before commit.
  -- Namespaced under <leader>m, not <leader>b: LazyVim owns <leader>b for
  -- buffers and <leader>bl is already "Delete Buffers to the Left".
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>m", group = "make/contract", icon = "󰈻 " },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    keys = {
      { "<leader>mc", make("contract"), desc = "make: contract (lint+breaking+check-gen)" },
      { "<leader>ml", make("lint"), desc = "make: buf lint" },
      { "<leader>mb", make("breaking"), desc = "make: buf breaking vs main" },
      { "<leader>mg", make("generate"), desc = "make: buf generate" },
    },
  },
}
