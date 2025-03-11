return {
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
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, python = true, haskell = true }
        return {
          timeout_ms = 1500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        zsh = { 'beautysh' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'gofumpt', 'crlfmt', stop_after_first = true },
        java = { 'clang-format' },
        -- haskell = { 'fourmolu' },
      },
    },
  },
}
