return { -- GITHUB COPILOT AI AUTOCOMPLETE
  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.g.copilot_filetypes = {
        yaml = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
      }

      local state_file = vim.fn.stdpath 'data' .. '/copilot_state'

      local function readstate()
        local file = io.open(state_file, 'r')
        local current_state = 'enabled'
        if file then
          current_state = file:read '*a'
          file:close()
        end

        return current_state
      end

      local function writestate(state)
        local out_file = io.open(state_file, 'w')
        if out_file then
          out_file:write(state)
          out_file:close()
        end
      end

      local function toggle_copilot()
        local current_state = readstate()

        if current_state == 'enabled' then
          vim.cmd 'Copilot disable'
          writestate 'disabled'
        else
          vim.cmd 'Copilot enable'
          writestate 'enabled'
        end
      end

      local function enable_copilot()
        vim.cmd 'Copilot enable'
        writestate 'enabled'
      end

      local function disable_copilot()
        vim.cmd 'Copilot disable'
        writestate 'disabled'
      end

      local file = io.open(state_file, 'r')
      if file then
        local state = file:read '*a'
        file:close()
        if state == 'disabled' then
          vim.g.copilot_enabled = false
        else
          vim.g.copilot_enabled = true
        end
      else
        vim.g.copilot_enabled = true
      end

      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-d>', 'copilot#Dismiss()', { expr = true, silent = true })

      -- toggle copilot
      vim.keymap.set('n', '<leader>ct', toggle_copilot, { noremap = true, silent = true, desc = 'Toggle Copilot' })
      vim.keymap.set('n', '<leader>ce', enable_copilot, { noremap = true, silent = true, desc = 'enable Copilot' })
      vim.keymap.set('n', '<leader>cd', disable_copilot, { noremap = true, silent = true, desc = 'disable Copilot' })
    end,
  },
}
