return { -- SMOOTH SCROLL
  -- 'declancm/cinnamon.nvim',
  -- version = '*',
  -- opts = {
  --   keymaps = {
  --     basic = true,
  --     extra = true,
  --   },
  --
  --   options = {
  --     mode = { 'window' },
  --   },
  -- },
  -- config = function()
  --   local cinnamon = require 'cinnamon'
  --
  --   cinnamon.setup()
  --
  --   -- J, K
  --   vim.keymap.set({ 'n', 'v' }, 'J', function()
  --     cinnamon.scroll '5j'
  --   end)
  --   vim.keymap.set({ 'n', 'v' }, 'K', function()
  --     cinnamon.scroll '5k'
  --   end)
  --
  --   -- Centered scrolling:
  --   vim.keymap.set('n', '<C-U>', function()
  --     cinnamon.scroll '<C-U>zz'
  --   end)
  --   vim.keymap.set('n', '<C-D>', function()
  --     cinnamon.scroll '<C-D>zz'
  --   end)
  --
  --   -- LSP:
  --   vim.keymap.set('n', 'gd', function()
  --     cinnamon.scroll(vim.lsp.buf.definition)
  --   end)
  --   vim.keymap.set('n', 'gD', function()
  --     cinnamon.scroll(vim.lsp.buf.declaration)
  --   end)
  -- end,
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.6, -- 0.45     [0, 1]
      stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
      trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
      damping = 0.95, -- 0.85     [0, 1]
      damping_insert_mode = 0.95, -- 0.9      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
    },
  },
}
