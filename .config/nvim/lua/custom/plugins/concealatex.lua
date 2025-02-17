return {
  {
    'Vl4dk0/ConceaLaTeX',
    ft = 'markdown', -- load only for markdown files
    config = function()
      require('ConceaLaTeX').setup()
    end,
  },
}
