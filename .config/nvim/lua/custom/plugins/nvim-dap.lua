return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-lua/plenary.nvim', -- Môže byť potrebné pre niektoré pluginy
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Function to compile and debug the current C++ source file
      function CompileAndDebug()
        -- Get the path to the current file
        local source_file = vim.fn.input('Path to source file: ', vim.fn.expand '%:p', 'file')

        -- If the user cancels the input, stop the function
        if source_file == '' then
          print 'No source file specified.'
          return
        end

        -- Define the output file path (change 'debug.exe' to your preferred name)
        local output_file = vim.fn.fnamemodify(source_file, ':r') .. '.out'

        -- Compile the source file with debugging information
        local compile_cmd = string.format('g++ -g %s -o %s', source_file, output_file)
        local compile_result = os.execute(compile_cmd)

        -- Check if compilation was successful
        if compile_result == 0 then
          dap.run {
            type = 'lldb',
            request = 'launch',
            name = 'Launch',
            program = output_file,
            cwd = vim.fn.getcwd(),
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
          }
        else
          print 'Compilation failed. Please check the source code for errors.'
        end
      end

      -- Nastavenie DAP UI
      dapui.setup()

      -- Otvorenie a zatvorenie DAP UI pri inicializácii a ukončení debugovania
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Nastavenie pre Go pomocou nvim-dap-go
      require('dap-go').setup()

      -- Nastavenie pre C++
      dap.adapters.lldb = {
        type = 'executable',
        command = '/home/linuxbrew/.linuxbrew/opt/llvm/bin/lldb-dap',
        name = 'lldb',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Cesta k spustiteľnému súboru: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp -- Pre C zdieľa konfiguráciu s C++

      -- Klávesové skratky pre ovládanie
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        'n',
        '<F5>',
        "<Cmd>lua if vim.bo.filetype == 'cpp' then CompileAndDebug() else require'dap'.continue() end<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap('n', '<F1>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<F2>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<F3>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<Leader>bb', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<Leader>lp', "<Cmd>lua require'dap'.repl.open()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<Leader>dl', "<Cmd>lua require'dap'.run_last()<CR>", opts)
    end,
  },
}
