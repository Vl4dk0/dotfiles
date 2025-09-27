return { -- AUTOCOMPLETION INTERFACE
  { 'L3MON4D3/LuaSnip', keys = {} },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',

    config = function()
      require('blink.cmp').setup {
        snippets = { preset = 'luasnip' },
        signature = { enabled = true },
        keymap = {
          preset = 'default',
          ['<C-k>'] = false,
        },

        appearance = {
          nerd_font_variant = 'mono',
        },

        completion = {
          accept = { auto_brackets = { enabled = true } },

          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },

          menu = {
            draw = {
              columns = {
                { 'kind_icon' },
                { 'label', 'label_description' },
              },
            },
          },

          documentation = { auto_show = true },
        },

        sources = {
          default = { 'lsp', 'path', 'buffer', 'omni', 'snippets' },
        },

        fuzzy = { implementation = 'prefer_rust' },
      }

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
