-- Ensure nvm's node/npm are on PATH for Mason and other spawned tools, even when
-- nvim is launched from a GUI (which never sources ~/.zshenv). No-op if node is
-- already resolvable. Mirrors the default-version resolution in ~/.zshenv.
local function ensure_node_on_path()
  if vim.fn.executable("node") == 1 then
    return
  end
  local nvm_dir = (vim.env.NVM_DIR ~= nil and vim.env.NVM_DIR ~= "") and vim.env.NVM_DIR or (vim.env.HOME .. "/.nvm")
  local versions_dir = nvm_dir .. "/versions/node"
  if vim.fn.isdirectory(versions_dir) == 0 then
    return
  end

  local bin_dir
  -- Prefer nvm's 'default' alias when it names a concrete installed version.
  local default_lines = vim.fn.readfile(nvm_dir .. "/alias/default")
  local default = vim.fn.trim(default_lines[1] or "")
  if default ~= "" and vim.fn.isdirectory(versions_dir .. "/v" .. default) == 1 then
    bin_dir = versions_dir .. "/v" .. default .. "/bin"
  else
    -- Fallback: highest installed version.
    local versions = vim.fn.readdir(versions_dir)
    table.sort(versions, function(a, b)
      return vim.version.lt(a:gsub("^v", ""), b:gsub("^v", ""))
    end)
    local latest = versions[#versions]
    if latest then
      bin_dir = versions_dir .. "/" .. latest .. "/bin"
    end
  end

  if bin_dir and vim.fn.isdirectory(bin_dir) == 1 then
    vim.env.PATH = bin_dir .. ":" .. vim.env.PATH
  end
end

ensure_node_on_path()

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
