return { -- GITHUB COPILOT AI AUTOCOMPLETE
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
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-d>', 'copilot#Dismiss()', { expr = true, silent = true })

      vim.api.nvim_set_keymap('n', '<leader>ce', ':Copilot enable<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true })
    end,
  },
}
