-- ~/.config/nvim/lua/functions.lua

local fun = {}

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

--- Shows the alpha dashboard if the current buffer is empty and unnamed.
function fun.show_alpha_on_new_tab()
  local current_buf = vim.api.nvim_get_current_buf()
  local is_empty = vim.api.nvim_buf_line_count(current_buf) == 1 and vim.api.nvim_buf_get_lines(current_buf, 0, 1, false)[1] == ''
  local is_unnamed = vim.api.nvim_buf_get_name(current_buf) == ''
  local is_modifiable = vim.api.nvim_get_option_value('modifiable', { buf = current_buf })

  if is_empty and is_unnamed and is_modifiable then
    require('alpha').start(false, require('alpha').themes.dashboard.opts)
  end
end

--- In netrw, opens the file under the cursor.
-- If the file is already open in a buffer, jumps to it.
-- Otherwise, opens it in the current window.
function fun.netrw_open_or_goto_file()
  local filename = vim.fn.expand '<cfile>'
  local filepath = vim.fn.fnamemodify(vim.fn.expand '%:p:h' .. '/' .. filename, ':p')

  -- Check if the target is a directory
  if vim.fn.isdirectory(filepath) == 1 then
    vim.cmd('edit ' .. filepath)
    return
  end

  -- Search for an existing buffer with this file path
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name == filepath then
        local win_id = vim.fn.bufwinid(buf)
        if win_id ~= -1 then
          -- Buffer is visible, switch to its window and tab
          local tab_id = vim.api.nvim_win_get_tabpage(win_id)
          vim.api.nvim_set_current_tabpage(tab_id)
          vim.api.nvim_set_current_win(win_id)
          return
        end
      end
    end
  end

  -- If no buffer is found, open the file in the current window
  vim.cmd('edit ' .. filepath)
end

--- In netrw, opens the file under the cursor in a new tab without switching to it.
function fun.netrw_open_in_new_tab_no_switch()
  local filename = vim.fn.expand '<cfile>'
  local filepath = vim.fn.fnamemodify(vim.fn.expand '%:p:h' .. '/' .. filename, ':p')

  -- Do nothing if the target is a directory
  if vim.fn.isdirectory(filepath) == 1 then
    vim.notify('Cannot open directory in new tab', vim.log.levels.WARN)
    return
  end

  local current_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd('tabedit ' .. filepath)
  vim.api.nvim_set_current_tabpage(current_tab)
end

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

    if vim.api.nvim_get_option_value('modified', { buf = buf }) then
      tail = tail .. '*'
    end

    local label_index
    if ti == 1 and first_is_netrw then
      label_index = 'e'
    else
      label_index = tostring(first_is_netrw and (ti - 1) or ti)
    end

    table.insert(s, string.format('%s%%%dT %s %s %%T', hl, ti, label_index, tail))
    table.insert(s, '%#TabLineFill#')
  end

  table.insert(s, '%=%#TabLineFill#')
  return table.concat(s)
end

vim.o.showtabline = 2
vim.o.tabline = '%!v:lua.MyTabline()'

-- =============================================================================
-- AUTOCMD (new section)
-- =============================================================================
local augroup = vim.api.nvim_create_augroup('MyCustomAutocmds', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show alpha on new empty tabs
vim.api.nvim_create_autocmd('TabNewEntered', {
  desc = 'Show alpha dashboard on new empty tabs',
  group = augroup,
  callback = function()
    fun.show_alpha_on_new_tab()
  end,
})

-- Custom keymaps for netrw
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  desc = 'Custom keymaps for netrw',
  group = augroup,
  callback = function()
    -- Map 'o' to open or go to the file
    vim.keymap.set('n', 'o', fun.netrw_open_or_goto_file, { buffer = true, silent = true, noremap = true })
    -- Map '<CR>' to open in a new tab without switching focus
    vim.keymap.set('n', '<CR>', fun.netrw_open_in_new_tab_no_switch, { buffer = true, silent = true, noremap = true })
  end,
})
-- =============================================================================

-- remove the old TextYankPost autocommand as it's now in the augroup
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

return fun
