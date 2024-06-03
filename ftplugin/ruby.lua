vim.api.nvim_create_autocmd({ 'BufAdd', 'BufCreate', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('RubyRemoveSomeIndentKeys', {}),
  pattern = '*.rb',
  callback = function()
    vim.opt_local.indentkeys:remove '.'
    vim.opt_local.indentkeys:remove '{'
    vim.opt_local.indentkeys:remove '}'
  end,
})

vim.cmd 'compiler minitest'
