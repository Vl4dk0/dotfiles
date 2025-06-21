-- <space> is <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd Font
vim.g.have_nerd_font = true

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Enable mouse
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
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

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7

-- support CRLF files
vim.opt.fileformats = 'unix,dos,mac'

-- Set the timeout length for mapped sequences
vim.o.timeoutlen = 400

-- Set the timeout length for key sequences
vim.o.ttimeoutlen = 10

-- Show virtual text
vim.diagnostic.config { virtual_text = true }

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Close the current buffer
-- vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle position=left<CR>', { noremap = true, silent = true })
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
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require '.lazy'

vim.keymap.set({ 'n', 'v' }, '<leader>nd', ':Noice dismiss<CR>', { noremap = true, silent = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- move lines up and down
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })

-- alt + hl in to indent and unindent
vim.keymap.set('n', '<A-h>', ':<<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-l>', ':><CR>', { silent = true, noremap = true })
vim.keymap.set('v', '<A-h>', ':<<CR>gv', { silent = true, noremap = true })
vim.keymap.set('v', '<A-l>', ':><CR>gv', { silent = true, noremap = true })

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

-- toggle line wrap with <leader>wr
vim.keymap.set('n', '<leader>wr', function()
  vim.wo.wrap = not vim.wo.wrap
end, { noremap = true, silent = true })

-- remap weird w, b and e movement to W, B and E which are more predictable
vim.keymap.set({ 'v', 'n' }, 'w', 'W', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'n' }, 'b', 'B', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'n' }, 'e', 'E', { noremap = true, silent = true })

-- Make the background transparent
-- vim.cmd [[
-- "highlight Normal guibg=none
-- "highlight NonText guibg=none
-- "highlight NormalNC guibg=none
-- "highlight LineNr guibg=none
-- "highlight SignColumn guibg=none
-- "highlight EndOfBuffer guibg=none
-- "highlight VertSplit guibg=none
-- "highlight StatusLine guibg=none
-- "highlight TabLineFill guibg=none
-- "highlight CursorLine guibg=none
-- ]]

-- Remap delete commands to use the black hole register
vim.keymap.set({ 'v', 'n' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'dd', '"_dd', { noremap = true })
vim.keymap.set({ 'v', 'n' }, 'D', '"_D', { noremap = true })

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

-- Clear right-click menu
vim.cmd [[
  aunmenu PopUp
]]

-- set the color scheme
vim.cmd [[
  colorscheme habamax
]]

-- Move up 4 lines on shift + k
vim.keymap.set({ 'n', 'v' }, 'K', '5k', { noremap = true, silent = true })

-- Move down 4 lines on shift + j
vim.keymap.set({ 'n', 'v' }, 'J', '5j', { noremap = true, silent = true })

-- disable <C-p> in insert mode
vim.keymap.set('i', '<C-p>', '<Esc>', { noremap = true, silent = true })

-- tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = '[t]ab [n]ew', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = '[t]ab [c]lose', noremap = true, silent = true })

vim.keymap.set('n', '<leader>tt', ':tabnext<CR>', { desc = '[t]ab nex[t]', noremap = true, silent = true })

-- source current lua file
vim.keymap.set('n', '<leader>x', ':source %<CR>', { desc = '([x]) source current lua file', noremap = true, silent = true })
