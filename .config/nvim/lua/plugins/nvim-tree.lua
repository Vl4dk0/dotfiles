return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile' },
  keys = {
    { '<leader>e', ':NvimTreeFindFileToggle<CR>', desc = 'Open NvimTree at File' },
  },
  opts = {
    on_attach = function(bufnr)
      local api = require 'nvim-tree.api'

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', '<CR>', api.node.open.tab_drop, opts 'Tab drop')
    end,
  },
}
