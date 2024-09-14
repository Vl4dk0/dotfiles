return {
  -- Auto-close tags
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
    event = 'InsertEnter',
  },

  -- Auto-rename tags
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
    event = 'InsertEnter',
  },
}
