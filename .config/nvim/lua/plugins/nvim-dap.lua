return { -- DEBUGGING, DEBUGGER
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- hints to use fkeys

      local enable_hint = true
      vim.keymap.set('n', '<leader>ddh', function()
        enable_hint = false
      end, { desc = '[d]ap [d]isable [h]ints' })

      vim.keymap.set('n', '<leader>deh', function()
        enable_hint = true
      end, { desc = '[d]ap [e]nable [h]ints' })

      -- motions controls

      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, { desc = 'Toggle breakpoint' })

      vim.keymap.set('n', '<leader>dc', function()
        dap.continue()
        if enable_hint then
          print 'You can use F5'
        end
      end, { desc = '[d]ap [c]ontinue' })

      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = '[d]ap open [R]EPL' })

      vim.keymap.set('n', '<leader>di', function()
        dap.step_into()
        if enable_hint then
          print 'You can use F2'
        end
      end, { desc = '[d]ap step [i]nto' })

      vim.keymap.set('n', '<leader>dv', function()
        dap.step_over()
        if enable_hint then
          print 'You can use F3'
        end
      end, { desc = '[d]ap step o[v]er' })

      vim.keymap.set('n', '<leader>do', function()
        dap.step_out()
        if enable_hint then
          print 'You can use F4'
        end
      end, { desc = '[d]ap step o[u]t' })

      vim.keymap.set('n', '<leader>dl', function()
        dap.run_last()
      end, { desc = '[d]ap run [l]ast' })

      vim.keymap.set('n', '<leader>dd', function()
        dap.disconnect()
      end, { desc = '[d]ap [d]isconnect' })

      vim.keymap.set('n', '<leader>dcb', function()
        dap.clear_breakpoints()
      end, { desc = '[d]ap [c]lear [b]reakpoints' })

      vim.keymap.set('n', '<leader>dcl', function()
        local input = vim.fn.input 'Condition: '
        if input ~= '' then
          vim.cmd(string.format("lua require('dap').set_breakpoint('%s')", input))
        end
      end, { desc = '[d]ap set [c]onditiona[l] breakpoint' })

      -- fkeys controls

      vim.keymap.set('n', '<F2>', function()
        dap.step_into()
      end, { desc = 'Step into' })

      vim.keymap.set('n', '<F3>', function()
        dap.step_over()
      end, { desc = 'Step over' })

      vim.keymap.set('n', '<F4>', function()
        dap.step_out()
      end, { desc = 'Step out' })

      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, { desc = 'Continue' })

      -- dap ui controls

      local dapui = require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- dap configurations

      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch .NET Core',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/<ProjectName>.dll', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup()
      local dap = require 'dap'
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = function()
            return 'python'
          end,
          cwd = '${workspaceFolder}',
        },
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()

      vim.keymap.set('n', '<leader>dt', function()
        require('dapui').toggle()
      end, { desc = 'Toggle UI' })
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      ---@diagnostic disable-next-line: missing-parameter
      require('nvim-dap-virtual-text').setup()
    end,
  },
}
