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

    -- These are the buttons that you can press to perform actions.
    -- Each button has a key, an icon, a description, and a command to execute.
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
      dashboard.button('g', 'grep  Find word', ':Telescope live_grep <CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('l', '鈴  Lazy', ':Lazy<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    local function header()
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
      }
      return headers[math.random(#headers)]
    end

    local function footer()
      local quotes = {
        'Rakovina by ce pobila.',
        'I use Neovim btw.',
        'Moje heslo na FaceBook: JanVlad123',
        'Vedel si o tom ?',
        'Wen TOP rapper.',
        'Vcera mi zhorel doom.',
      }
      return quotes[math.random(#quotes)]
    end

    -- You can create your own ASCII art here: https://patorjk.com/software/taag/
    dashboard.section.header.val = header()

    dashboard.section.footer.val = footer()

    -- This table defines the layout of the dashboard.
    -- It specifies the order and spacing of the sections.
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
