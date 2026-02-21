-- Filetype detection for JSONC files
-- Automatically treats .jsonc files as JSON for syntax highlighting and LSP

vim.cmd([[autocmd BufRead,BufNewFile *.jsonc set filetype=json]])
