return {
  'rcarriga/nvim-notify',
  event = 'BufWinEnter',
  config = function()
    require('notify').setup {
      background_colour = '#000000',
      fps = 60,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      level = 2,
      minimum_width = 50,
      render = 'minimal',
      stages = 'fade',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 3000,
      top_down = true,
    }
  end,
}
