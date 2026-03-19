local jdtls = require('jdtls')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.local/share/eclipse/') .. project_name

local root = vim.fs.root(0, function(name)
  return name:match('%.iml$')
    or vim.tbl_contains({ '.git', 'gradlew', 'mvnw', 'pom.xml', 'build.gradle' }, name)
end)

local config = {
  cmd = {
    vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'),
    '-data', workspace_dir,
  },

  root_dir = root,

  capabilities = require('blink.cmp').get_lsp_capabilities(),

  settings = {
    java = {
      project = {
        sourcePaths = { 'src', 'src/main/java', 'src/test/java' },
        outputPath = 'bin',
      },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },

  on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Java: ' .. desc })
    end
    map('<leader>jo', jdtls.organize_imports, 'Organize Imports')
    map('<leader>jv', jdtls.extract_variable, 'Extract Variable')
    map('<leader>jc', jdtls.extract_constant, 'Extract Constant')
    vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end,
      { buffer = bufnr, desc = 'Java: Extract Method' })
  end,
}

jdtls.start_or_attach(config)
