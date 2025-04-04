return { -- AUTOFORMAT, FORMATTING, FORMATTERS
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          local filetype = vim.bo.filetype

          if filetype == 'htmldjango' then
            local file = vim.fn.expand '%:p'
            vim.cmd('!~/.venvs/nvim/bin/djhtml ' .. file)
          else
            require('conform').format { async = true, lsp_fallback = true }
          end
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true, python = true, haskell = true, kotlin = true, json = true, typescript = true, py = true }
        return {
          timeout_ms = 1500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        bash = { 'shfmt' },
        zsh = { 'beautysh' },
        sh = { 'shfmt' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'gofumpt', 'crlfmt', stop_after_first = true },
        java = { 'clang-format' },
        kotlin = { 'ktfmt' },
        toml = { 'prettierd', 'prettier', stop_after_first = true },
        -- haskell = { 'fourmolu' },
      },
    },
  },
}
