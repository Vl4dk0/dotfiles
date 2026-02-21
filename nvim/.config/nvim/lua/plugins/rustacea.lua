return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  ft = { 'rust' },
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },

      dap = {
        autoload_config = true,
      },
    }

    vim.keymap.set('n', '<leader>rt', "<cmd>lua vim.cmd('RustLsp testables')<CR>", {
      desc = '[r]ust [t]estables',
    })
  end,
}
