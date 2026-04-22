return { -- ANALYZES AND HIGHLIGHTS SYNTAX
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    },
    config = function(_, opts)
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }

      require('nvim-treesitter').install(opts.ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lua', 'vim', 'vimdoc', 'query' },
        callback = function(args)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
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
