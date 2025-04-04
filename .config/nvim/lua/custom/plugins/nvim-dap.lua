return { -- DEBUGGING ADAPTER PROTOCOL, USEFUL FOR SETTING UP DEBUGGING
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, { desc = 'Toggle breakpoint' })

      vim.keymap.set('n', '<leader>dc', function()
        dap.continue()
      end, { desc = '[d]ap [c]ontinue' })

      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = '[d]ap open [R]EPL' })

      vim.keymap.set('n', '<leader>di', function()
        dap.step_into()
      end, { desc = '[d]ap step [i]nto' })

      vim.keymap.set('n', '<leader>dv', function()
        dap.step_over()
      end, { desc = '[d]ap step o[v]er' })

      vim.keymap.set('n', '<leader>do', function()
        dap.step_out()
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

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim',
    },
    opts = {
      handlers = {
        codelldb = function(config)
          table.insert(config.configurations, {
            args = {},
            console = 'integratedTerminal',
            cwd = '${workspaceFolder}',
            name = 'LLDB: Launch prog3',
            program = function()
              local current_dir = vim.fn.expand '%:p:h'
              local cmake_lists = io.open(current_dir .. '/CMakeLists.txt')
              if cmake_lists then
                local content = cmake_lists:read '*all'
                cmake_lists:close()
                local project_name = content:match 'project%(([%w_%-]+)%)'
                return current_dir .. '/build/' .. project_name
              end
            end,
            request = 'launch',
            stopOnEntry = false,
            type = 'codelldb',
          })

          require('mason-nvim-dap').default_setup(config)
        end,
        ensure_installed = {
          'netcoredbg',
        },
      },
    },
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
      end,
    },
    {
      'leoluz/nvim-dap-go',
      config = function()
        require('dap-go').setup()
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
  },
}
