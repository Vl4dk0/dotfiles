return { -- AUTOCOMPLETION INTERFACE
  'saghen/blink.cmp',

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
      -- use_nvim_cmp_as_default = true,
    },

    signature = {
      enabled = true,
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
            { 'source_name', gap = 1 },
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind' },
          },
        },
      },

      documentation = { auto_show = false },
    },

    sources = {
      default = { 'lsp', 'path', 'buffer', 'omni' },
    },

    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
  keymap = {
    ['<C-k>'] = false,
  },
}
