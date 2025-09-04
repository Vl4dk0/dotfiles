return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == '' then
        return ''
      end
      -- Return a string with an icon for better visibility
      return '🔴 REC ' .. reg
    end

    local habamax_dark = {
      normal = {
        a = { fg = '#000000', bg = '#87afd7', gui = 'bold' }, -- Mode (Normal)
        b = { fg = '#d7d7d7', bg = '#303030' }, -- Git, Diagnostics
        c = { fg = '#d7d7d7', bg = '#202020' }, -- Filename
      },
      insert = {
        a = { fg = '#000000', bg = '#afdf87', gui = 'bold' }, -- Mode (Insert)
      },
      visual = {
        a = { fg = '#000000', bg = '#d7afff', gui = 'bold' }, -- Mode (Visual)
      },
      replace = {
        a = { fg = '#000000', bg = '#ff8787', gui = 'bold' }, -- Mode (Replace)
      },
      command = {
        a = { fg = '#000000', bg = '#ffaf87', gui = 'bold' }, -- Mode (Command)
      },
      inactive = {
        a = { fg = '#d7d7d7', bg = '#1c1c1c', gui = 'bold' },
        b = { fg = '#d7d7d7', bg = '#1c1c1c' },
        c = { fg = '#8a8a8a', bg = '#1c1c1c' },
      },
    }

    require('lualine').setup {
      options = {
        theme = habamax_dark,
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { isRecording, 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype', 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
