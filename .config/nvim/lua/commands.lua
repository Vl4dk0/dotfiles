vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

function Set_python_host_prog()
  local venv = vim.env.VIRTUAL_ENV

  print(venv)

  if venv then
    vim.g.python3_host_prog = venv .. '/bin/python3'
    print('Python host program set to ' .. vim.g.python3_host_prog)
  else
    print 'No virtual environment detected'
  end
end
