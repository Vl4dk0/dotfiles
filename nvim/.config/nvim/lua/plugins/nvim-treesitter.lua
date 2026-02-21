return { -- ANALYZES AND HIGHLIGHTS SYNTAX
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      autotag = {
        enable = true,
      },

      sync_install = false,

      auto_install = true,

      indent = {
        enable = true,
      },

      highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',

            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['ii'] = '@conditional.inner',
            ['ai'] = '@conditional.outer',
            ['il'] = '@loop.inner',
            ['al'] = '@loop.outer',
            ['at'] = '@comment.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']]'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']['] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[['] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[['] = '@function.outer',

            ['[C'] = '@class.outer',
          },
          -- goto_next = {
          --   [']i'] = "@conditional.inner",
          -- },
          -- goto_previous = {
          --   ['[i'] = "@conditional.inner",
          -- }
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 5,
        trim_scope = 'inner',
        min_window_height = 0,
        patterns = {
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
          },
          tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
          },
          rust = {
            'impl_item',
          },
          markdown = {
            'section',
          },
          json = {
            'pair',
          },
          typescript = {
            'export_statement',
          },
        },
        exact_patterns = {},

        zindex = 20,
        mode = 'cursor',
        separator = nil,
      }
    end,
  },
}
