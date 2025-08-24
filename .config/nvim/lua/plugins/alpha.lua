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
          '-E',
          '__pycache__',
        },
      }
    end

    local function live_grep()
      local builtin = require 'telescope.builtin'
      builtin.live_grep { additional_args = { '--hidden' } }
    end

    local function header()
      -- A table holding our cute animal ASCII art
      local animal_art = {
        CAT = {
          '  /\\_/\\  ',
          ' ( o.o ) ',
          '  > ^ <  ',
        },
      }

      local function parse_quote(quote_text)
        local quote, author = '', ''
        local loading_quote = true

        for ch in quote_text:gmatch '.' do
          if ch == '(' then
            loading_quote = false
          elseif ch == ')' then
            break
          else
            if loading_quote then
              quote = quote .. ch
            else
              author = author .. ch
            end
          end
        end

        local function trim(s)
          return (s:gsub('^%s+', ''):gsub('%s+$', ''))
        end

        return trim(quote), trim(author)
      end

      local function create_speech_bubble(art_table, text)
        local art_width = 0
        for _, line in ipairs(art_table) do
          if #line > art_width then
            art_width = #line
          end
        end

        local quote_text, author = parse_quote(text)

        local text_width = #quote_text + 2
        local bubble_content_width = math.max(art_width, text_width)

        local bubble_top = ' .' .. string.rep('-', bubble_content_width) .. '.'

        local text_padding_total = bubble_content_width - #quote_text
        local text_padding_left = math.floor(text_padding_total / 2)
        local text_padding_right = math.ceil(text_padding_total / 2)
        local bubble_mid = '( ' .. string.rep(' ', text_padding_left) .. quote_text .. string.rep(' ', text_padding_right) .. ' )'

        local bubble_bot = " '" .. string.rep('-', bubble_content_width) .. "'"
        local speech_line = string.rep(' ', bubble_content_width / 2 - 3) .. '\\'
        local author_line = string.rep(' ', bubble_content_width / 2 - #author / 2) .. author

        local final_art = {
          bubble_top,
          bubble_mid,
          bubble_bot,
          speech_line,
        }
        for _, line in ipairs(art_table) do
          local art_padding_total = bubble_content_width - #line
          local art_padding_left = math.floor(art_padding_total / 2)
          local final_line = string.rep(' ', art_padding_left + 1) .. line
          table.insert(final_art, final_line)
        end

        table.insert(final_art, author_line)
        return final_art
      end

      local function quote()
        -- Fetch a random quote from the forismatic API (plain text format)
        local handle = io.popen "curl -s 'https://api.forismatic.com/api/1.0/?method=getQuote&format=text&lang=en'"
        local quote = handle:read '*a'
        handle:close()

        -- Clean up the quote text by removing trailing whitespace/newlines
        quote = quote:gsub('^%s*', ''):gsub('%s*$', '')

        -- If the API call fails or returns an empty string, provide a fallback
        if quote == '' then
          return 'Could not fetch quote. Check your internet connection.'
        end

        return quote
      end

      local text = quote()
      return create_speech_bubble(animal_art.CAT, text)
    end

    local function footer()
      -- Fetch a random quote from the forismatic API (plain text format)
      return ''
    end

    -- Dashboard configuration
    dashboard.section.header.val = header()
    dashboard.section.buttons.val = {
      dashboard.button('r', '📅 Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('e', '🔍 Explore files', ':Ex<CR>'),
      dashboard.button('f', '🔍 Find file', find_files),
      dashboard.button('s', '🔍 Find word', live_grep),
      -- dashboard.button('l', '💤 Lazy', ':Lazy<CR>'),
      dashboard.button('l', '🌱 LazyGit', ':LazyGit<CR>'),
      dashboard.button('q', '⏻  Quit', ':qa<CR>'),
    }
    dashboard.section.footer.val = footer()

    dashboard.config.layout = {
      { type = 'padding', val = 8 },
      dashboard.section.header,
      { type = 'padding', val = 8 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
      dashboard.section.footer,
    }

    -- Finally, we set up alpha with the dashboard theme.
    alpha.setup(dashboard.opts)
  end,
}
