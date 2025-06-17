return { -- AUTOFORMAT, FORMATTING, FORMATTERS
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
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
        java = { 'clang-format' },
        toml = { 'prettierd', 'prettier', stop_after_first = true },
        typst = { 'typstfmt', 'typstyle' },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        tex = { 'tex-fmt' },
        plaintex = { 'tex-fmt' },
        bib = { 'bibtex-tidy' },
      },
    },
  },
}
