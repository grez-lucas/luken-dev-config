-- Test adapters for the two JavaScript surfaces of buken-app: Vitest in
-- console/, jest-expo in mobile/. Both live under one npm workspace (ADR-0008),
-- so neotest sees both from one nvim session and has to pick per file.
--
-- Both adapters already gate on a dependency, but each of them also accepts the
-- *cwd's* root package.json as evidence, so in a monorepo a devDependency
-- hoisted to the root would let one adapter claim the other's surface. The
-- predicates below narrow that to the workspace member the file actually
-- belongs to, which is the only package.json that says anything true about it.
--
-- neotest-jest's cwd is the same problem lua/plugins/go.lua solves for
-- golangci-lint: the adapter resolves its binary by walking up to the nearest
-- node_modules, which under npm hoisting is the repository root, and jest then
-- runs from there and never sees mobile/'s jest-expo preset. Its default cwd is
-- nil, so anchor it on the workspace member.

-- Nearest package.json above `path` - the workspace member directory.
local function package_dir(path)
  local pkg = path and vim.fs.find("package.json", { path = path, upward = true, type = "file" })[1]
  return pkg and vim.fs.dirname(pkg) or nil
end

-- Does the file's own workspace member declare any of `names`?
--
-- neotest calls is_test_file from a libuv callback, so this runs in a fast
-- event context: plain Lua io and vim.json only, no vim.fn.
local function member_declares(path, names)
  local dir = package_dir(path)
  if not dir then
    return false
  end
  local handle = io.open(dir .. "/package.json", "r")
  if not handle then
    return false
  end
  local contents = handle:read("*a")
  handle:close()
  local ok, pkg = pcall(vim.json.decode, contents)
  if not ok or type(pkg) ~= "table" then
    return false
  end
  for _, field in ipairs({ "dependencies", "devDependencies" }) do
    for _, name in ipairs(names) do
      if (pkg[field] or {})[name] then
        return true
      end
    end
  end
  return false
end

return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "marilari88/neotest-vitest", "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          -- ANDed with the adapter's own vitest check, so this only tightens.
          is_test_file = function(file_path)
            return member_declares(file_path, { "vitest" })
          end,
        },
        ["neotest-jest"] = {
          -- Replaces the adapter's check outright, so the filename half has to
          -- come back with it; reuse the adapter's own matcher rather than
          -- restating its list of test-file patterns.
          isTestFile = function(file_path)
            return require("neotest-jest.util").defaultTestFileMatcher(file_path)
              and member_declares(file_path, { "jest", "jest-expo" })
          end,
          cwd = package_dir,
        },
      },
    },
  },
}
