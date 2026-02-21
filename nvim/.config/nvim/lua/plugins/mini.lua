return { -- SURROUND
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup {
        custom_surroundings = nil,

        highlight_duration = 500,

        mappings = {
          add = 'S',
          delete = '',
          find = '',
          find_left = '',
          highlight = '',
          replace = '',
          update_n_lines = '',

          suffix_last = '',
          suffix_next = '',
        },

        n_lines = 20,

        respect_selection_type = true,

        search_method = 'cover',

        silent = false,
      }

      require('mini.pairs').setup {
        modes = {
          insert = false,
        },
      }
    end,
  },
}
