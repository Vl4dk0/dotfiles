return { {
  'sheerun/vim-polyglot',
  lazy = true,
  init = function()
    vim.g.polyglot_disabled = { 'sleuth' }
  end,
} }
