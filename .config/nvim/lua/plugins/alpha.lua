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

      --- Creates a speech bubble that is perfectly sized and aligned
      -- above the provided ASCII art.
      -- @param art_table An array of strings representing the ASCII art.
      -- @param text The string to display in the speech bubble.
      -- @return An array of strings for the final combined graphic.
      local function create_speech_bubble(art_table, text)
        -- Step 1: Find the widest part of the animal art
        local art_width = 0
        for _, line in ipairs(art_table) do
          if #line > art_width then
            art_width = #line
          end
        end

        -- Step 2: Ensure the bubble is wide enough for the text or the art
        local text_width = #text + 2 -- text plus one space padding on each side
        local bubble_content_width = math.max(art_width, text_width)

        -- Step 3: Create the bubble components
        local bubble_top = ' .' .. string.rep('-', bubble_content_width) .. '.'

        -- Center the text inside the bubble space
        local text_padding_total = bubble_content_width - #text
        local text_padding_left = math.floor(text_padding_total / 2)
        local text_padding_right = math.ceil(text_padding_total / 2)
        local bubble_mid = '( ' .. string.rep(' ', text_padding_left) .. text .. string.rep(' ', text_padding_right) .. '  )'

        local bubble_bot = " '" .. string.rep('-', bubble_content_width) .. "'"
        local speech_line = '   \\'

        -- Step 4: Combine everything into the final graphic
        local final_art = {
          bubble_top,
          bubble_mid,
          bubble_bot,
          speech_line,
        }
        for _, line in ipairs(art_table) do
          -- Center each line of the animal art under the bubble
          local art_padding_total = bubble_content_width - #line
          local art_padding_left = math.floor(art_padding_total / 2)
          local final_line = string.rep(' ', art_padding_left + 1) .. line
          table.insert(final_art, final_line)
        end

        return final_art
      end

      -- Get precise location using the 'corelocationcli' tool
      local location_handle = io.popen 'corelocationcli -format "%.4f,%.4f"'
      local location_string = location_handle:read '*a' or ''
      location_handle:close()

      -- Extract latitude and longitude
      local lat, lon = location_string:match '([%-%d%.]+),([%-%d%.]+)'

      local location_query
      if lat and lon then
        -- Use precise coordinates if available
        location_query = lat .. ',' .. lon
      else
        -- Fallback to Bratislava if location services fail or are denied
        location_query = 'Bratislava'
      end

      -- Fetch the weather using the determined location
      local curl_command = string.format("curl -s 'wttr.in/%s?format=%%C+%%t'", location_query)
      local weather_handle = io.popen(curl_command)
      local forecast = weather_handle:read '*a' or 'Weather unavailable'
      weather_handle:close()

      forecast = forecast:gsub('^%s*', ''):gsub('%s*$', '')

      return create_speech_bubble(animal_art.CAT, forecast)
    end

    local function footer()
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

    -- Dashboard configuration
    dashboard.section.header.val = header()
    dashboard.section.buttons.val = {
      dashboard.button('r', '📅 Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('e', '🔍 Explore files', ':Ex<CR>'),
      dashboard.button('f', '🔍 Find file', find_files),
      dashboard.button('s', '🔍 Grep word', live_grep),
      -- dashboard.button('l', '💤 Lazy', ':Lazy<CR>'),
      dashboard.button('l', '🌱 LazyGit', ':LazyGit<CR>'),
      dashboard.button('q', '⏻  Quit', ':qa<CR>'),
    }
    dashboard.section.footer.val = footer()

    dashboard.config.layout = {
      { type = 'padding', val = 4 },
      dashboard.section.header,
      { type = 'padding', val = 4 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
      dashboard.section.footer,
    }

    -- Finally, we set up alpha with the dashboard theme.
    alpha.setup(dashboard.opts)
  end,
}
