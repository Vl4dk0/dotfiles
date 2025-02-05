return {
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
      end, { desc = 'Continue' })

      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = 'Open REPL' })

      vim.keymap.set('n', '<F1>', function()
        dap.step_into()
      end, { desc = 'Step into' })

      vim.keymap.set('n', '<F2>', function()
        dap.step_over()
      end, { desc = 'Step over' })

      vim.keymap.set('n', '<leader>do', function()
        dap.step_out()
      end, { desc = 'Step out' })

      vim.keymap.set('n', '<leader>dl', function()
        dap.run_last()
      end, { desc = 'Run last' })

      vim.keymap.set('n', '<leader>dt', function()
        dap.toggle()
      end, { desc = 'Toggle' })

      vim.keymap.set('n', '<leader>dd', function()
        dap.disconnect()
      end, { desc = 'Disconnect' })

      vim.keymap.set('n', '<leader>drb', function()
        dap.clear_breakpoints()
      end, { desc = 'Remove all breakpoints' })

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch .NET',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to DLL > ', vim.gn.getcwd() .. '/bin/Debug/net8.0/', 'file')
          end,
          cwd = '${workspaceFolder}',
          env = {
            ASPNETCORE_ENVIRONMENT = 'Development',
            ASPNETCORE_URLS = 'https://localhost:5001;http://localhost:5000',
          },
          stopAtEntry = false,
          justMyCode = true,
        },
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

        vim.keymap.set('n', '<leader>du', function()
          require('dapui').toggle()
        end, { desc = 'Toggle UI' })
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = { 'mfussenegger/nvim-dap' },
      config = function()
        require('nvim-dap-virtual-text').setup()
      end,
    },
  },
}
