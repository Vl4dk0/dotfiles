-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Enable line wrapping
vim.opt.wrap = false
vim.opt.showbreak = '↪ '

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Mapped sequence wait time
vim.opt.timeoutlen = 2000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Set tab width to 4 spaces automatically for certain filetypes
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'cpp', 'c', 'go', 'java' },
  callback = function()
    vim.defer_fn(function()
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
    end, 1000) -- 1000 milliseconds
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'markdown' },
  callback = function()
    vim.defer_fn(function()
      vim.opt.wrap = true
    end, 1000) -- 1000 milliseconds
  end,
})

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Close the current buffer
vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })

-- Indent selected text by four spaces in visual mode
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Unindent selected text by four spaces in visual mode
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Automatically set filetype to htmldjango for files inside the templates/ folder
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.html' },
  callback = function()
    local file_path = vim.fn.expand '%:p' -- Get the full path of the file
    local is_in_templates_folder = string.match(file_path, '/templates/')

    if is_in_templates_folder then
      vim.bo.filetype = 'htmldjango'
    else
      vim.bo.filetype = 'html'
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.cs' },
  callback = function()
    vim.bo.filetype = 'cs'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.workbook' },
  callback = function()
    vim.bo.filetype = 'json'
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  'tpope/vim-sleuth',
  { import = 'kickstart.plugins' },
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>nd', ':Noice dismiss<CR>', { noremap = true, silent = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- move lines up and down
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })

-- alt + hl in visual mode to indent and unindent
vim.keymap.set('v', '<A-h>', '<gv', { silent = true, noremap = true })
vim.keymap.set('v', '<A-l>', '>gv', { silent = true, noremap = true })

-- move to the beginning and end of a line
vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true, noremap = true })

-- visual mode whole file
vim.keymap.set('n', '<leader>y', 'ggVG', { silent = true, noremap = true })

-- copy whole file
vim.keymap.set('n', '<leader>Y', 'ggVGy<C-o>', { silent = true, noremap = true })

-- Resize window with Ctrl + Left
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- Resize window with Ctrl + Right
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Resize window with Ctrl + Up (not working)
vim.keymap.set('n', '<A-Up>', ':resize +2<CR>', { noremap = true, silent = true })

-- Resize window with Ctrl + Down (not working)
vim.keymap.set('n', '<A-Down>', ':resize -2<CR>', { noremap = true, silent = true })

-- Save and exit buffer with <laeder>we
vim.keymap.set('n', '<leader>we', ':w<CR>:Ex<CR>', { noremap = true, silent = true })

-- Save buffer with <laeder>ww
vim.keymap.set('n', '<leader>ww', ':w<CR>', { noremap = true, silent = true })

-- Save and quit nvim with <laeder>wq
vim.keymap.set('n', '<leader>wq', ':wq!<CR>', { noremap = true, silent = true })

-- quit nvim with <laeder>qq
vim.keymap.set('n', '<leader>qq', ':q!<CR>', { noremap = true, silent = true })

-- center the screen after ctrl-d
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- center the screen after ctrl-u
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- support CRLF files
vim.opt.fileformats = 'unix,dos,mac'

-- Set the timeout length for mapped sequences
vim.o.timeoutlen = 400 -- (default is 1000ms)

-- Set the timeout length for key sequences
vim.o.ttimeoutlen = 10 -- (default is 50ms)

-- Disabling that annoying Shift + J shit thal collapses lines
vim.keymap.set({ 'v', 'n' }, 'J', 'j', { noremap = true, silent = true })

-- Disabling that annoying manual that lags my nvim in v-line mode
vim.keymap.set({ 'v', 'n' }, 'K', 'k', { noremap = true, silent = true })

-- remap weird w, b and e movement to W, B and E which are more predictable
vim.keymap.set({ 'v', 'n' }, 'w', 'W', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'n' }, 'b', 'B', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'n' }, 'e', 'E', { noremap = true, silent = true })

-- Make the background transparent
vim.cmd [[
  highlight Normal guibg=none
  "highlight NonText guibg=none
  highlight NormalNC guibg=none
  "highlight LineNr guibg=none
  "highlight SignColumn guibg=none
  "highlight EndOfBuffer guibg=none
  "highlight VertSplit guibg=none
  "highlight StatusLine guibg=none
  "highlight TabLineFill guibg=none
  highlight CursorLine guibg=none
]]

-- close buffer with <leader>bd
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })

-- Remap delete commands to use the black hole register
vim.keymap.set({ 'v', 'n' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'dd', '"_dd', { noremap = true })

-- Remap change commands to use the black hole register
vim.keymap.set({ 'v', 'n' }, 'c', '"_c', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'cc', '"_cc', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'C', '"_C', { noremap = true })

-- Remap substitute commands to use the black hole register
vim.keymap.set({ 'v', 'n' }, 's', '"_s', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'S', '"_s', { noremap = true })

-- Remap paste command in visual mode to use the black hole register
vim.keymap.set('v', 'p', '"_dP', { noremap = true })

local function set_python_host_prog()
  local venv = vim.env.VIRTUAL_ENV

  if venv then
    vim.g.python3_host_prog = venv .. '/bin/python'
    print('Python host program set to ' .. vim.g.python3_host_prog)
    -- else
    --   print 'No virtual environment detected'
  end
end

set_python_host_prog()

-- faster selecting word
vim.keymap.set('n', 'vv', 'viw', { noremap = true, silent = true })

-- I dont use the S command to rewrite a line
vim.keymap.set({ 'v', 'n' }, 'S', '', { noremap = true, silent = true })
