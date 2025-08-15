return { -- DATABASE
  {
    'tpope/vim-dadbod',
    dependencies = {
      'kristijanhusak/vim-dadbod-ui',
    },
    config = function()
      local project_root = vim.fn.getcwd()

      -- Define your database connections
      -- It will automatically look for a .env file in the project root
      -- and load the variables from there.
      vim.g.dbs = {
        overheid = {
          driver = 'postgres',
          host = 'localhost',
          port = 5433,
          user = 'overheid',
          password = 'overheid',
          database = 'overheid',
        },
      }

      -- Keymaps for dadbod-ui
      -- vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<cr>', { desc = 'Toggle DB UI' })
    end,
  },
}
