return { -- PARENTHESES AUTOCOMPLETE PAIRS
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true,
      ignored_next_char = '[%w%.]',
    }
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    local Rule = require 'nvim-autopairs.rule'
    local npairs = require 'nvim-autopairs'

    npairs.add_rule(Rule('$$', '$$', 'tex'))

    local cond = require 'nvim-autopairs.conds'

    npairs.add_rules {
      Rule('$', '$', { 'markdown', 'tex', 'latex', 'typst' })
        -- don't add a pair if the next character is $
        -- :with_pair(cond.not_after_regex '%$'),
        -- don't move right when repeat character
        :with_move(
          cond.done()
        ),
      Rule('\\lbrace ', ' \\rbrace', { 'markdown', 'tex', 'latex' }),
      Rule('\\Lbrace ', ' \\Rbrace', { 'markdown', 'tex', 'latex' }),

      Rule('function(', ') end', { 'lua' }),
    }
  end,
}
