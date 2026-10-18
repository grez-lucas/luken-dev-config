-- Rust editor affordances on top of LazyVim's `lang.rust` extra.
--
-- The extra hands LSP to rustaceanvim and expects `rust-analyzer` on $PATH; it
-- does not install one. `~/.cargo/bin/rust-analyzer` is a rustup proxy shim, so
-- it exists even when the component behind it does not, and the extra's guard
-- (`vim.fn.executable("rust-analyzer") == 0`) therefore passes while the spawned
-- binary dies with "Unknown binary 'rust-analyzer' in official toolchain". The
-- toolchain half of that is fixed outside nvim, and has to stay fixed:
--
--   rustup component add rust-analyzer   -- also pulls rust-src, which is what
--                                        -- makes goto-definition reach std
--
-- Nothing here re-checks that. If Rust buffers go quiet again, run the command
-- above before reading any of this file.
return {
  {
    "mrcjkb/rustaceanvim",
    -- Merged into the extra's `opts.server.default_settings` by lazy.nvim, so
    -- this file only names the keys it changes. `on_attach` is deliberately not
    -- set here: it is a function, which lazy.nvim overwrites rather than merges,
    -- and doing so would silently drop the extra's <leader>cR and <leader>dr.
    -- Keymaps go through the LspAttach autocmd below instead.
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            -- No `check` key here, deliberately. Clippy-on-save is already
            -- on: rustaceanvim's `load_rust_analyzer_settings` injects
            -- `check = { command = "clippy", extraArgs = { "--no-deps" } }`
            -- whenever `tools.enable_clippy` holds (it defaults to true) and
            -- `cargo-clippy` is on $PATH -- but only `if settings.check == nil`.
            -- Setting `check.command = "clippy"` here therefore buys nothing and
            -- costs `--no-deps`, silently widening every save to lint the
            -- dependency graph as well. Leave the key absent.
            inlayHints = {
              -- Both off by default upstream, and both are exactly the thing a
              -- reader cannot infer from the source. Closure return types make
              -- the inference visible where the syntax omits it, and elided
              -- lifetimes are the borrow checker's reasoning written out - the
              -- errors are much easier to read once the hints have shown what
              -- the compiler filled in.
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
            },
          },
        },
      },
    },
    init = function()
      -- rustaceanvim exposes these only as `:RustLsp <subcommand>`; LazyVim
      -- binds none of them. Buffer-local and gated on the client name, so
      -- <leader>co does not collide with the TypeScript extra's organize-imports
      -- on the same key in a TS buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("rustaceanvim_keys", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client or client.name ~= "rust-analyzer" then
            return
          end
          local function map(lhs, subcmd, desc)
            vim.keymap.set("n", lhs, function()
              vim.cmd.RustLsp(subcmd)
            end, { buffer = ev.buf, desc = desc })
          end
          -- `rustc --explain` for the error under the cursor, rendered in a
          -- float. The alternative is leaving the editor to read it.
          map("<leader>ce", { "explainError", "current" }, "Explain Error (rustc)")
          map("<leader>co", "openCargo", "Open Cargo.toml")
          map("<leader>cp", "parentModule", "Parent Module")
        end,
      })
    end,
  },
}
