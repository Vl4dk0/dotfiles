return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = true,
  opts = {
    instructions_file = 'AGENTS.md',
    provider = 'copilot',
    providers = {
      copilot = {
        endpoint = 'https://api.githubcopilot.com',
        model = 'gemini-3-flash-preview', -- 0.33 rates
        proxy = nil,
        allow_insecure = false,
        timeout = 30000,
        extra_request_body = {
          temperature = 0.15,
          max_tokens = 32768,
        },
      },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-mini/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'stevearc/dressing.nvim', -- for input provider dressing
    'folke/snacks.nvim', -- for input provider snacks
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
