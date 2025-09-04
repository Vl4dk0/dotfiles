local fun = {}
local has_devicons, devicons = pcall(require, 'nvim-web-devicons')

-- helper to find netrw window in first tab (returns window id or nil)
local function first_tab_netrw_win(tabs)
  tabs = tabs or vim.api.nvim_list_tabpages()
  if #tabs == 0 then
    return nil
  end
  local first_tab = tabs[1]
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(first_tab)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if ft == 'netrw' then
      return win
    end
  end
  return nil
end

-- if there is a file explorer open on first tab, go to first tab
-- if there is not file explorer open on first tab, prepend tab with a file explorer
local function open_explorer()
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs == 0 then
    vim.cmd 'Ex'
    return
  end

  local netrw = first_tab_netrw_win(tabs)
  if netrw then
    vim.cmd '1tabnext'
    pcall(vim.api.nvim_set_current_win, netrw)
  else
    vim.cmd 'tabnew'
    vim.cmd 'Ex'
    vim.cmd 'tabmove 0'
  end
end

fun.open_explorer = open_explorer

local function open_tab(tab_index)
  local tabs = vim.api.nvim_list_tabpages()

  if first_tab_netrw_win(tabs) then
    tab_index = tab_index + 1
  end

  if tab_index < 1 or tab_index > #tabs then
    vim.notify('Tab index out of range', vim.log.levels.WARN)
    return
  end
  vim.cmd(tab_index .. 'tabnext')
end

fun.open_tab = open_tab

-- Custom tabline:
-- netrw first tab shows " e "
-- other tabs numbered 1..N (skipping the netrw tab) matching <leader><number> mappings
-- only show filename (tail). When switching windows inside a tab the label updates.
function _G.MyTabline()
  local s = {}
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs == 0 then
    return ''
  end

  -- reuse existing helper: first_tab_netrw_win(tabs) returns window id or nil
  local first_is_netrw = first_tab_netrw_win(tabs) ~= nil

  for ti, tab in ipairs(tabs) do
    local current = (tab == vim.api.nvim_get_current_tabpage())
    local hl = current and '%#TabLineSel#' or '%#TabLine#'
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    local tail = name ~= '' and (name:match '[^/]+$' or name) or '[No Name]'

    local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
    local tail_display = modified and (tail .. '*') or tail

    -- devicon (requires nvim-web-devicons and a Nerd Font)
    local icon = ''
    if has_devicons and name ~= '' then
      local ext = tail:match '%.([^%.]+)$'
      icon = (devicons.get_icon(tail, ext, { default = true }) or '') .. ' '
    end

    -- gitsigns per-buffer status (added/changed/removed + branch for current tab)
    local gitseg = ''
    local gs = vim.b[buf].gitsigns_status_dict
    if gs then
      local parts = {}
      if (gs.added or 0) > 0 then
        parts[#parts + 1] = '+' .. gs.added
      end
      if (gs.changed or 0) > 0 then
        parts[#parts + 1] = '~' .. gs.changed
      end
      if (gs.removed or 0) > 0 then
        parts[#parts + 1] = '-' .. gs.removed
      end
      if #parts > 0 then
        gitseg = ' ' .. table.concat(parts)
      end
    end

    local label_index
    if ti == 1 and first_is_netrw then
      label_index = 'e'
    else
      label_index = tostring(first_is_netrw and (ti - 1) or ti)
    end

    table.insert(s, string.format('%s%%%dT %s %s%s%s %%T', hl, ti, label_index, icon, tail_display, gitseg))
    table.insert(s, '%#TabLineFill#')
  end

  table.insert(s, '%=%#TabLineFill#')
  return table.concat(s)
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return fun
