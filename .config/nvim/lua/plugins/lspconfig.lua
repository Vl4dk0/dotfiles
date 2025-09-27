---@diagnostic disable: missing-fields
return { -- LSP CONFIGURATION
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },

    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config('lua_ls', { capabilities = capabilities })
      vim.lsp.config('emmet_ls', {
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'svelte', 'pug', 'typescriptreact', 'vue' },
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              ['bem.enabled'] = true,
            },
          },
        },
      })

      local servers = {
        clangd = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        ts_ls = {
          handlers = {
            ['textDocument/publishDiagnostics'] = function(_, result, ctx)
              if result.diagnostics == nil then
                return
              end

              -- ignore some ts_ls diagnostics
              local idx = 1
              while idx <= #result.diagnostics do
                local entry = result.diagnostics[idx]

                local formatter = require('format-ts-errors')[entry.code]
                entry.message = formatter and formatter(entry.message) or entry.message

                -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                if entry.code == 80001 then
                  -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                  table.remove(result.diagnostics, idx)
                else
                  idx = idx + 1
                end
              end

              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
            end,
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'shfmt',
        'yapf',
        'reorder-python-imports',
        'beautysh',
        'prettierd',
        'prettier',
        'clang-format',
        'typstyle',
        'tex-fmt',
        'bibtex-tidy',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
          end,
        },
      }
    end,
  },
}
