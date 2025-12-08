-- <space> is <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Netrw
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 3
-- vim.g.netrw_keepdir = 1

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Nerd Font
vim.g.have_nerd_font = true

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- windows
vim.o.winborder = 'rounded'

-- Enable mouse
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

-- Disable line wrapping
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showbreak = '↪ '

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS the search pattern contains uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decreased update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 7

-- support CRLF files
vim.opt.fileformats = 'unix,dos,mac'

-- Set the timeout length for mapped sequences
vim.o.timeoutlen = 400

-- Set the timeout length for key sequences
vim.o.ttimeoutlen = 10

-- tabline
vim.o.showtabline = 2
vim.o.tabline = '%!v:lua.MyTabline()'

-- cmd
vim.o.showcmd = true
vim.o.cmdheight = 1

-- Show virtual text
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  underline = true,

  float = {
    border = 'rounded',
    source = true,
  },
}

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable swap files
vim.opt.swapfile = false

-- Clear right-click menu
vim.cmd [[
  aunmenu PopUp
]]
