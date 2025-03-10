return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    lazy = false,
    dependencies = {
      { 'github/copilot.vim' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken',
    opts = {
      model = 'o3-mini',
      question_header = os.getenv 'USER' .. ' ',
      answer_header = 'jurko_petras ',
      chat_autocomplete = false,
      provider = 'copilot',
      copilot_agent = {
        enable = true,
      },
      window = {
        layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.75, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.75, -- fractional height of parent, or absolute height in rows when > 1
      },
      mappings = {
        complete = {
          insert = '<Tab>',
        },
      },
      prompts = {
        Gramatika = {
          prompt = '>$gpt-4o\n\nPrepis text so Slovenskou diakritikou, gramaticke chyby, ciarky a slovosled smies upravit, no slova alebo vyznam viet nemen.',
          system_prompt = 'You are thorough and precise when getting your task done. You will do exactly what user wants you to. You will be tasked to help with text, do not write line numbers',
          mapping = '<leader>csk',
          description = 'Will rewrite slovak text with correct grammar',
        },
        GrammarCheck = {
          prompt = '>$gpt-4o\n\nRewrite the text with correct English grammar, punctuation, and sentence structure. Do not change the meaning of the sentences.',
          system_prompt = 'You are thorough and precise when getting your task done. You will do exactly what user wants you to. You will be tasked to help with text, do not write line numbers',
          mapping = '<leader>cen',
          description = 'Will rewrite English text with correct grammar',
        },
      },
    },
    keys = {
      { '<leader>c', ':CopilotChat<CR>', desc = 'CopilotChat', mode = { 'n', 'v' } },
      { '<leader>cs', ':CopilotChatStop<CR>', desc = 'CopilotChatStop', mode = { 'n', 'v' } },
      { '<leader>cr', ':CopilotChatStop<CR>', desc = 'CopilotChatReset', mode = { 'n', 'v' } },
      { '<leader>ct', ':CopilotChatToggle<CR>', desc = 'CopilotChatToggle', mode = { 'n', 'v' } },
      { '<leader>cc', ':CopilotChatToggle<CR>', desc = 'CopilotChatToggle', mode = { 'n', 'v' } },

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

      -- Chat with DeepSeek R1 model
      {
        '<leader>ccd',
        function()
          local input = vim.fn.input 'Ask DeepSeek: '
          require('CopilotChat').ask('> $DeepSeek-R1\n\n' .. input, {
            agent = 'DeepSeek-R1',
          })
        end,
        desc = 'CopilotChat - DeepSeek',
        mode = { 'n', 'v' },
      },
    },
  },
}
