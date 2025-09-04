local fun = require 'functions'

vim.keymap.set('n', '<leader>e', fun.open_explorer, { noremap = true, silent = true, desc = 'Open/Go to netrw explorer tab 1' })

-- Indent selected text by four spaces in visual mode
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Unindent selected text by four spaces in visual mode
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!!"<CR>')

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

-- Save buffer with <laeder>w
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = '[w]rite/save buffer' })

-- Quit nvim with <laeder>q
vim.keymap.set('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true, desc = '[q]uit' })

-- Save and quit nvim with <leader>x
vim.keymap.set('n', '<leader>x', ':wq!<CR>', { noremap = true, silent = true, desc = '[x] save and quit' })

-- center the screen after ctrl-d
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- center the screen after ctrl-u
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- toggle line wrap with <leader>rr
vim.keymap.set('n', '<leader>rr', function()
  vim.wo.wrap = not vim.wo.wrap
end, { noremap = true, silent = true, desc = 'Toggle line w[r]ap' })

-- remap weird w, b and e movement to W, B and E which are more predictable
-- vim.keymap.set({ 'v', 'n' }, 'w', 'W', { noremap = true, silent = true })
-- vim.keymap.set({ 'v', 'n' }, 'b', 'B', { noremap = true, silent = true })
-- vim.keymap.set({ 'v', 'n' }, 'e', 'E', { noremap = true, silent = true })

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
vim.keymap.set('v', 'p', '"_dp', { noremap = true })
vim.keymap.set('v', 'P', '"_dP', { noremap = true })

-- faster selecting word
vim.keymap.set('n', 'vv', 'viw', { noremap = true, silent = true })

-- I dont use the S command to rewrite a line
vim.keymap.set({ 'v', 'n' }, 'S', '', { noremap = true, silent = true })

-- overriden by cinnamon.lua
-- Move up 5 lines on shift + k
-- vim.keymap.set({ 'n', 'v' }, 'K', '5k', { noremap = true, silent = true })

-- Move down 5 lines on shift + j
-- vim.keymap.set({ 'n', 'v' }, 'J', '5j', { noremap = true, silent = true })

-- disable <C-p> in insert mode
vim.keymap.set('i', '<C-p>', '<Esc>', { noremap = true, silent = true })

-- tabs
vim.keymap.set('n', '<leader>tt', ':$tabnew<CR>', { desc = '[t]ab [n]ew', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = '[t]ab [c]lose', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { desc = '[t]ab [p]rev', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = '[t]ab [n]ext', noremap = true, silent = true })

vim.keymap.set('n', '<leader>t[', ':tabprev<CR>', { desc = '[t]ab [p]rev', noremap = true, silent = true })
vim.keymap.set('n', '<leader>t]', ':tabnext<CR>', { desc = '[t]ab [n]ext', noremap = true, silent = true })

-- press <leader>t<number> to go to that tab
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    fun.open_tab(i)
  end, { desc = '[' .. i .. '] Open tab ' .. i, noremap = true, silent = true })
end

-- Noice dismiss
vim.keymap.set({ 'n', 'v' }, '<leader>nd', ':Noice dismiss<CR>', { noremap = true, silent = true })
