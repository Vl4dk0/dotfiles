return { -- COPILOT CHAT AI CHATBOT
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    lazy = false,
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'gpt-5',
      headers = {
        user = os.getenv 'USER' .. ' ',
        assistant = 'jurko_petras: ',
        tool = '🔧 Tool: ',
      },
      separator = '━━',
      show_folds = false, -- Disable folding for cleaner look
      question_header = os.getenv 'USER' .. ' ',
      answer_header = 'jurko_petras ',
      providers = {},
      contexts = {
        buffer = {},
        buffers = {},
        file = {},
        files = {},
        git = {},
        url = {},
        register = {},
        quickfix = {},
        system = {},
      },
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      },
      mappings = {
        complete = {
          insert = '<Tab>',
        },
      },
    },
    keys = {
      -- { '<Right>', ':CopilotChat<CR>', desc = 'CopilotChatStart', mode = { 'n', 'v' } },
      -- { '<Up>', ':CopilotChatToggle<CR>', desc = 'CopilotChatToggle', mode = { 'n', 'v' } },

      -- Chat with perplexityai model, good for web search
      {
        '<leader>ccp',
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
