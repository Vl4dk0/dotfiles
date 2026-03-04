local M = {}

-- Exact path/directory exclusions
M.exact = {
  '.git',
  'node_modules',
  '.next',
  '.venv',
  'target',
  'raycast/extensions',
  '.gemini/antigravity',
  '.gemini/tmp',
}

-- Glob-style patterns — match any path segment anywhere in the tree
M.globs = {
  '*cache*', -- .ruff_cache, __pycache__, .pytest_cache, .mypy_cache, .parcel-cache, .cache …
  'dist',
  'build',
  '*.egg-info',
  '*.dist-info',
}

-- Returns fd -E flags for all exact and glob exclusions
-- e.g. { '-E', '.git', '-E', '*cache*', ... }
function M.fd_excludes()
  local args = {}
  for _, p in ipairs(M.exact) do
    table.insert(args, '-E')
    table.insert(args, p)
  end
  for _, p in ipairs(M.globs) do
    table.insert(args, '-E')
    table.insert(args, p)
  end
  return args
end

-- Returns rg --glob ! flags for all exact and glob exclusions
-- e.g. { '--glob', '!.git', '--glob', '!*cache*', ... }
function M.rg_excludes()
  local args = {}
  for _, p in ipairs(M.exact) do
    table.insert(args, '--glob')
    table.insert(args, '!' .. p)
  end
  for _, p in ipairs(M.globs) do
    table.insert(args, '--glob')
    table.insert(args, '!' .. p)
  end
  return args
end

-- Returns Lua patterns for telescope's file_ignore_patterns
-- Exact entries are escaped, globs like *cache* become .*cache.* in Lua regex
local function glob_to_lua_pattern(g)
  -- Escape magic chars first, then replace the glob wildcard back
  local escaped = (g:gsub('([%.%+%-%^%$%(%)%[%]%%])', '%%%1'))
  return (escaped:gsub('%*', '.*'))
end

function M.telescope_ignore()
  local patterns = {}
  for _, p in ipairs(M.exact) do
    -- Escape dots so e.g. ".git" doesn't match "Xgit"
    table.insert(patterns, (p:gsub('%.', '%%.')))
  end
  for _, p in ipairs(M.globs) do
    table.insert(patterns, (glob_to_lua_pattern(p)))
  end
  return patterns
end

return M
