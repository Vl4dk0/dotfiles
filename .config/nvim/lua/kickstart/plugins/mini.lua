return { -- SURROUND + STATUSLINE
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup {
        custom_surroundings = nil,

        highlight_duration = 500,

        mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = '', -- Delete surrounding
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          highlight = '', -- Highlight surrounding
          replace = '', -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = '', -- Suffix to search with "prev" method
          suffix_next = '', -- Suffix to search with "next" method
        },

        n_lines = 20,

        respect_selection_type = true,

        search_method = 'cover',

        silent = false,
      }

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
