return { -- SEARCH TOOL
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = 'NONE' })

      require('telescope').setup {
        defaults = {},
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'noice')

      local find_command = {
        'fd',
        '--type',
        'f',
        '--strip-cwd-prefix',
        '--hidden',
        '--no-ignore',
        '-E',
        '.git',
        '-E',
        'node_modules',
        '-E',
        '.next',
        '-E',
        '.venv',
        '-E',
        '__pycache__',
      }

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files {
          find_command = find_command,
        }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      local default_pickers = require 'telescope.pickers'
      local finders = require 'telescope.finders'
      local make_entry = require 'telescope.make_entry'
      local conf = require('telescope.config').values
      vim.keymap.set('n', '<leader>sg', function(opts)
        local finder = finders.new_async_job {
          command_generator = function(prompt)
            if not prompt or prompt == '' then
              return nil
            end

            local pieces = vim.split(prompt, '  ')
            local args = { 'rg' }

            if pieces[1] then
              table.insert(args, '-e')
              table.insert(args, pieces[1])
            end

            if pieces[2] then
              table.insert(args, '--glob')
              table.insert(args, pieces[2])
            end

            return vim.list_extend(args, {
              '--hidden',
              '--glob',
              '!\\.git',
              '--glob',
              '!node_modules',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
            })
          end,

          entry_maker = make_entry.gen_from_vimgrep(opts),
        }

        default_pickers
          .new({}, {
            debounce = 100,
            prompt_title = 'Multi Grep',
            finder = finder,
            previewer = conf.grep_previewer {},
            sorter = require('telescope.sorters').empty(),
          })
          :find()
      end, {
        desc = 'Grep string in all files (including hidden)',
      })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
