return { -- COPILOT CHAT AI CHATBOT
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
      model = 'claude-3.7-sonnet-thought',
      question_header = os.getenv 'USER' .. ' ',
      answer_header = 'jurko_petras ',
      chat_autocomplete = false,
      provider = 'copilot',
      copilot_agent = {
        enable = true,
      },
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
        -- width = 0.75, -- fractional width of parent, or absolute width in columns when > 1
        -- height = 0.75, -- fractional height of parent, or absolute height in rows when > 1
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
        SystemProgrammingChat = {
          prompt = [[
You are an AI assistant tasked with answering questions about systems programming based on the information provided in a large file. Your responses must be concise, accurate, and reference the specific lines in the file where the information was found. If the file does not contain the required information, clearly state that and provide a correct answer based on your knowledge. Follow these rules:

1. **Multiple Choice Questions:** Provide the correct answers and reference the lines in the file where the information was found. If the file lacks the information, state this and provide the correct answers based on your knowledge.

2. **Explanation Questions:** Provide three short, correct options for the explanation (one line each) and reference the lines in the file where the information was found. If the file lacks the information, state this and provide three correct options based on your knowledge.

3. **Code Analysis Questions:** Analyze the code snippet and provide a concise answer, referencing the lines in the file where the information was found. If the file lacks the information, state this and provide a correct answer based on your knowledge.

4. **Prioritization:** Always prioritize the information in the file. If the file contains relevant information, base your answer solely on it. If not, provide a correct answer based on your knowledge.

**Format for Responses:**
- **Answer:** [Your answer]
- **Reference:** [Line numbers or sections in the file]
- **If file lacks information:** "The file does not contain relevant information. Based on my knowledge: [Correct answer]"

**Example Question:**  
"Which of the following are valid system calls in Linux? (Select all that apply)"  
**Example Response:**  
- **Answer:** `read`, `write`, `fork`  
- **Reference:** Lines 45-50  
- **If file lacks information:** "The file does not contain relevant information. Based on my knowledge: `read`, `write`, `fork`"
          ]],
          system_prompt = [[
You are an AI assistant specialized in answering questions about systems programming based on a large file provided by the user. Your primary goal is to provide concise, accurate answers while referencing specific lines or sections in the file where the information was found. If the file does not contain the required information, you must clearly state this and provide a correct answer based on your knowledge. Follow these rules:

1. **Prioritize File Information:** Always prioritize the information in the file. If relevant information is found, base your answer solely on it and reference the specific lines or sections.

2. **Fallback to Knowledge:** If the file lacks relevant information, explicitly state this and provide a correct answer based on your knowledge.

3. **Answer Format:**  
   - **Answer:** Provide a concise response to the question.  
   - **Reference:** Include the line numbers or sections in the file where the information was found.  
   - **If file lacks information:** Clearly state: "The file does not contain relevant information. Based on my knowledge: [Correct answer]"

4. **Multiple Choice Questions:** Provide all correct answers and reference the lines in the file. If the file lacks information, provide correct answers based on your knowledge.

5. **Explanation Questions:** Provide three short, correct options (one line each) for the explanation and reference the lines in the file. If the file lacks information, provide three correct options based on your knowledge.

6. **Code Analysis Questions:** Analyze the code snippet and provide a concise answer, referencing the lines in the file. If the file lacks information, provide a correct answer based on your knowledge.

7. **Conciseness:** Keep all answers short and to the point. Avoid unnecessary explanations unless explicitly requested.

8. **Clarity:** Ensure your responses are clear and formatted for easy understanding.
          ]],
          mapping = '<leader>pcb',
          description = 'Expert system programming responses based on file material',
        },
      },
    },
    keys = {
      { '<Left>', ':CopilotChat<CR>', desc = 'CopilotChatStart', mode = { 'n', 'v' } },
      { '<leader>cc', ':CopilotChat<CR>', desc = 'CopilotChatStart', mode = { 'n', 'v' } },
      { '<leader>cs', ':CopilotChatStop<CR>', desc = 'CopilotChatStop', mode = { 'n', 'v' } },
      { '<leader>cr', ':CopilotChatReset<CR>', desc = 'CopilotChatReset', mode = { 'n', 'v' } },
      { '<Up>', ':CopilotChatToggle<CR>', desc = 'CopilotChat', mode = { 'n', 'v' } },
      { '<leader>ct', ':CopilotChatToggle<CR>', desc = 'CopilotChat', mode = { 'n', 'v' } },

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

      -- Chat with DeepSeek-R1 model, good for detailed responses
      {
        '<leader>ccd',
        function()
          local input = vim.fn.input 'Ask DeepSeek: '
          local var = 'DeepSeek-R1'
          require('CopilotChat').ask('> $' .. var .. '\n\n' .. input, {
            agent = var,
          })
        end,
        desc = 'CopilotChat - DeepSeek',
        mode = { 'n', 'v' },
      },

      -- Chat with gpt-4o model, good for fast responses
      {
        '<leader>ccg',
        function()
          local input = vim.fn.input 'Ask GPT-4o: '
          local var = 'gpt-4o'
          require('CopilotChat').ask('> $' .. var .. '\n\n' .. input, {
            model = var,
          })
        end,
        desc = 'CopilotChat - GPT-4o',
        mode = { 'n', 'v' },
      },
    },
  },
}
