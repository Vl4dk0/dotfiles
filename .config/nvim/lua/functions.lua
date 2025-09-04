local fun = {}

-- if there is a file explorer open on first tab, go to first tab
-- if there is not file explorer open on first tab, prepend tab with a file explorer
local function open_explorer()
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs == 0 then
    vim.cmd 'Ex'
    return
  end

  local first_tab = tabs[1]
  local wins = vim.api.nvim_tabpage_list_wins(first_tab)
  local netrw_win = nil
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    -- use new API (0.10+) with fallback for older versions
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if ft == 'netrw' then
      netrw_win = win
      break
    end
  end
  if netrw_win then
    vim.cmd '1tabnext'
    -- focus the netrw window
    pcall(vim.api.nvim_set_current_win, netrw_win)
  else
    -- stay in explorer (first tab)
    vim.cmd 'tabnew'
    vim.cmd 'Ex'
    vim.cmd 'tabmove 0'
  end
end

fun.open_explorer = open_explorer

local function open_tab(tab_index)
  local tabs = vim.api.nvim_list_tabpages()
  if tab_index < 1 or tab_index > #tabs then
    vim.notify('Tab index out of range', vim.log.levels.WARN)
    return
  end
  vim.cmd(tab_index .. 'tabnext')
end

fun.open_tab = open_tab

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return fun
