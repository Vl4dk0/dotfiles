---@diagnostic disable: param-type-mismatch
return {
  -- The plugin specification for alpha-nvim
  'goolord/alpha-nvim',

  -- alpha-nvim works best with an icon plugin
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    -- Import the alpha plugin
    local alpha = require 'alpha'
    -- Import the dashboard theme
    local dashboard = require 'alpha.themes.dashboard'

    -- Functions for the dashboard
    local function find_files()
      local builtin = require 'telescope.builtin'
      builtin.find_files {
        find_command = {
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
        },
      }
    end

    local function live_grep()
      local builtin = require 'telescope.builtin'
      builtin.live_grep { additional_args = { '--hidden' } }
    end

    local function header()
      math.randomseed(os.time())
      local headers = {
        {
          '███╗   ██╗██╗   ██╗██╗██╗   ██╗██╗',
          '████╗  ██║██║   ██║██║╚██╗ ██╔╝██║',
          '██╔██╗ ██║██║   ██║██║ ╚████╔╝ ██║',
          '██║╚██╗██║██║   ██║██║  ╚██╔╝  ╚═╝',
          '██║ ╚████║╚██████╔╝██║   ██║   ██╗',
          '╚═╝  ╚═══╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝',
        },
        {
          ' _   _ _                        ',
          '| \\ | (_)                      ',
          '|  \\| |_  __ _  __ _  ___ _ __ ',
          '| . ` | |/ _` |/ _` |/ _ \\ |__|',
          '| |\\  | | (_| | (_| |  __/ |   ',
          '\\_| \\_/_|\\__, |\\__, |\\___|_|   ',
          '          __/ | __/ |          ',
          '         |___/ |___/           ',
        },
        {
          '   _____ _                   ',
          '  / ____(_)                  ',
          ' | |     _  __ _  __ _ _ __  ',
          ' | |    | |/ _` |/ _` | |_ \\ ',
          ' | |____| | (_| | (_| | | | |',
          '  \\_____|_|\\__, |\\__,_|_| |_|',
          '            __/ |            ',
          '           |___/             ',
        },
        {
          '   _____           ',
          '  / ____|          ',
          ' | |  __  ___  ___ ',
          ' | | |_ |/ _ \\/ __|',
          ' | |__| |  __/ (__ ',
          '  \\_____|\\___|\\___|',
          '                   ',
        },
      }
      return headers[math.random(#headers)]
    end

    local function footer()
      math.randomseed(os.time())
      local quotes = {
        'Rakovina by ce pobila.',
        'I use Neovim btw.',
        'Moje heslo na FaceBook: JanVlad123',
        'Vedel si o tom ?',
        'Wen TOP rapper.',
        'Vcera mi zhorel doom.',
        'Najvacsia diera je prievidza',
      }
      return quotes[math.random(#quotes)]
    end

    -- Dashboard configuration
    dashboard.section.header.val = header()
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  Find file', find_files),
      dashboard.button('g', 'grep  Find word', live_grep),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('l', '鈴  Lazy', ':Lazy<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }
    dashboard.section.footer.val = footer()

    dashboard.config.layout = {
      { type = 'padding', val = 2 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 2 },
      dashboard.section.footer,
    }

    -- Finally, we set up alpha with the dashboard theme.
    alpha.setup(dashboard.opts)
  end,
}
