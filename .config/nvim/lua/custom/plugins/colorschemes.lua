return { -- COLORSCHEMES
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    -- vim.cmd.colorscheme 'tokyonight'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    'rose-pine/neovim',
    --   name = 'rose-pine',
    --   priority = 1000,
    --   config = function()
    --     vim.cmd 'colorscheme rose-pine'
    --   end,
  },
  {
    'tjdevries/colorbuddy.nvim',
    --   lazy = false,
    --   priority = 1001,
    --   config = function()
    --     vim.cmd.colorscheme 'gruvbuddy'
    --   end,
  },

  -- Or with configuration
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require('github-theme').setup {
      --   -- ...
      -- }

      vim.cmd 'colorscheme github_dark'
    end,
  },
}
