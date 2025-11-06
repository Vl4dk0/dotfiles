-- lua/theme_cycler.lua
-- Theme cycler with persistence and keymaps.

local M = {}
local state_file = vim.fn.stdpath 'data' .. '/theme_state'

-- Themes (add more later if needed)
local themes = {
  ['habamax-muffled'] = function()
    vim.cmd [[
      colorscheme habamax

      highlight Normal  guibg=#282828
      highlight NonText guibg=#282828

      highlight TabLine      guifg=#b0b0b0 guibg=#1f1f1f gui=NONE
      highlight TabLineSel   guifg=#1f1f1f guibg=#87AFD7 gui=bold
      highlight TabLineFill  guifg=#555555 guibg=#202020 gui=NONE

      hi Normal      guibg=NONE ctermbg=NONE
      hi NormalNC    guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE

      highlight TelescopeSelection guibg=#303030 guifg=NONE
      highlight TelescopeSelectionCaret guibg=#303030 guifg=#87AFD7
      highlight PmenuSel guibg=#303030 guifg=NONE 

    ]]
  end,

  ['habamax-solid'] = function()
    vim.cmd [[
      colorscheme habamax

      highlight Normal  guibg=#282828
      highlight NonText guibg=#282828

      highlight TabLine      guifg=#b0b0b0 guibg=#1f1f1f gui=NONE
      highlight TabLineSel   guifg=#1f1f1f guibg=#87AFD7 gui=bold
      highlight TabLineFill  guifg=#555555 guibg=#202020 gui=NONE

      highlight TelescopeSelection guibg=#303030 guifg=NONE
      highlight TelescopeSelectionCaret guibg=#303030 guifg=#87AFD7
      highlight PmenuSel guibg=#303030 guifg=NONE 
    ]]
  end,
}

-- helpers
local function theme_names()
  local t = {}
  for k, _ in pairs(themes) do
    table.insert(t, k)
  end
  table.sort(t)
  return t
end

local function read_state()
  local f = io.open(state_file, 'r')
  if not f then
    return 1
  end
  local n = tonumber(f:read '*a')
  f:close()
  local names = theme_names()
  if not n or n < 1 or n > #names then
    return 1
  end
  return n
end

local function write_state(i)
  local f = io.open(state_file, 'w')
  if f then
    f:write(i)
    f:close()
  end
end

-- apply theme
local function apply_by_index(i)
  local names = theme_names()
  local name = names[i]
  local fn = themes[name]
  if not fn then
    return
  end

  fn()
  write_state(i)
  vim.notify('Colorscheme → ' .. name)
  pcall(function()
    require('lualine').setup(require('lualine').get_config())
  end)
end

-- cycle themes
local function cycle_next()
  local names = theme_names()
  local cur = read_state()
  local nxt = (cur % #names) + 1
  apply_by_index(nxt)
end

-- setup
function M.setup()
  vim.api.nvim_create_user_command('ThemeNext', function()
    cycle_next()
  end, {})
  vim.keymap.set('n', '<leader>cs', cycle_next, { noremap = true, silent = true, desc = 'Cycle Colorscheme' })

  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      apply_by_index(read_state())
    end,
  })
end

M.setup()
return M
