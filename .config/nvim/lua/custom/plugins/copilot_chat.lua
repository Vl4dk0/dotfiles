return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken',
    opts = {
      model = 'o3-mini',
      question_header = os.getenv 'USER' .. ' ',
      answer_header = 'Jurko Petras ',
      chat_autocomplete = false,
      window = {
        layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.75, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.75, -- fractional height of parent, or absolute height in rows when > 1
        col = 30,
        row = 1,
      },
      mappings = {
        complete = {
          insert = '<Tab>',
          normal = '<Tab>',
        },
      },
    },
    keys = {
      { '<leader>c', ':CopilotChat<CR>', desc = 'CopilotChat', mode = { 'n', 'v' } },
      { '<leader>cs', ':CopilotChatStop<CR>', desc = 'CopilotChat Stop', mode = { 'n', 'v' } },
      { '<leader>ct', ':CopilotChatToggle<CR>', desc = 'CopilotChat Toggle', mode = { 'n', 'v' } },

      -- Ask the Perplexity agent a quick question
      {
        '<leader>ccs',
        function()
          local input = vim.fn.input 'Perplexity: '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              agent = 'perplexityai',
              selection = false,
            })
          end
        end,
        desc = 'CopilotChat - Perplexity Search',
        mode = { 'n', 'v' },
      },
    },
  },
}
