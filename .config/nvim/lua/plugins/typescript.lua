-- tsgo is the TypeScript LSP, and it runs the project's own compiler.
--
-- buken-app pins typescript@7 (ADR-0008 puts the toolchain in the workspace),
-- and typescript@7 is the native port: it ships lib/tsc.js and no tsserver.js.
-- vtsls could not load it, fell back to its bundled TypeScript 5.9.3, and the
-- editor then type-checked with a different compiler than `npm run typecheck`.
-- A commit refused for an error nvim never showed is exactly the surprise this
-- project keeps deleting, so LazyVim's `lang.typescript.tsgo` extra is enabled
-- in lazyvim.json; it disables vtsls, so only one server ever attaches.
--
-- `mason = false` is the load-bearing half. lspconfig's tsgo is an alias for its
-- `tsc` config, whose root_dir searches node_modules/.bin/tsc, then $PATH tsc,
-- then the same two for tsgo, and takes the first that answers `--version` with
-- 7.0 or newer. The workspace binary therefore wins - the same one the gate runs
-- - and that only holds if Mason is kept out of it. Letting Mason install its
-- own tsgo would add a third TypeScript to the machine for no gain.
--
-- The accepted cost: a repo whose TypeScript predates 7.0 now gets no
-- TypeScript LSP at all, since vtsls is disabled and tsc refuses to attach
-- below 7.0. bukenCoaching_frontend (typescript 4.9.5) is such a repo: it
-- attaches eslint and tailwindcss only, and prints `tsc: no binary supporting
-- --lsp found` on every JS/TS buffer.
--
-- That is decided, not an oversight. Two fixes were considered and rejected:
-- keeping vtsls as a root_dir-gated fallback, which restores coverage at the
-- price of two TypeScript servers and a per-project rule about which one you
-- get, the very thing this change removes; and a Mason tsgo on $PATH, which
-- would serve old repos by type-checking TS 4.9 source under TS 7 rules and so
-- reintroduce editor-and-build disagreement in the other direction. Legacy
-- repos stay ESLint-only. Revisit if one of them becomes daily work again.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsgo = {
          mason = false,
          -- The vtsls extra bound four extra keys; only this one survives the
          -- swap. vtsls asked for `source.fixAll.ts`, tsgo advertises the
          -- unsuffixed `source.fixAll`. `<leader>cM` (add missing imports) is
          -- gone: tsgo offers no addMissingImports action under either name.
          -- `gD` (goto source definition), `gR` (file references) and
          -- `<leader>cV` (select TS version) are gone too, because tsgo answers
          -- with no executeCommandProvider at all and every one of those was a
          -- workspace/executeCommand. LazyVim's own `<leader>co` (organize
          -- imports) and `<leader>cA` (source action) do work against tsgo.
          keys = {
            { "<leader>cD", LazyVim.lsp.action["source.fixAll"], desc = "Fix all diagnostics" },
          },
        },
      },
    },
  },
}
