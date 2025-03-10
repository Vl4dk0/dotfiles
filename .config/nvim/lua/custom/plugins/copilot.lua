return {
  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.g.copilot_filetypes = {
        yaml = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
      }

      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-d>', 'copilot#Dismiss()', { expr = true, silent = true })

      vim.api.nvim_set_keymap('n', '<leader>ce', ':Copilot enable<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true })
    end,
  },
}
-- {
--   'zbirenbaum/copilot.lua',
--   config = function()
--     require('copilot').setup {
--       panel = {
--         enabled = false,
--         auto_refresh = false,
--         keymap = {
--           accept = '<CR>',
--           open = '<C-p>',
--           refresh = '<C-r>',
--         },
--         layout = {
--           position = 'right', -- | top | left | right
--           ratio = 0.4,
--         },
--       },
--       suggestion = {
--         enabled = true,
--         auto_trigger = true,
--         hide_during_completion = false,
--         debounce = 75,
--         keymap = {
--           accept = '<C-j>',
--           accept_word = '<C-Right>',
--           dismiss = '<C-d>',
--         },
--       },
--       filetypes = {
--         markdown = true,
--         yaml = false,
--         help = false,
--         gitcommit = false,
--         gitrebase = false,
--         hgcommit = false,
--         svn = false,
--         cvs = false,
--         ['.'] = false,
--       },
--       copilot_node_command = 'node', -- Node.js version must be > 18.x
--       server_opts_overrides = {},
--     }
--
--     -- Key mappings to enable/disable Copilot
--     vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true })
--     vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { noremap = true, silent = true })
--   end,
-- },
