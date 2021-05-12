local saga = require 'lspsaga'

saga.init_lsp_saga({ rename_prompt_prefix = '',
error_sign = 'E',
warn_sign = 'W',
hint_sign = 'H',
infor_sign = 'I',
code_action_prompt = {
  enable = true,
  sign = true,
  sign_priority = 20,
  virtual_text = false,
},
})

-- code finder
vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", {noremap = true, silent = true})
-- docs
vim.api.nvim_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>", {noremap = true, silent = true})
-- code actions
vim.api.nvim_set_keymap('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>ca', "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", {noremap = true, silent = true})
-- signature help
-- vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", {noremap = true, silent = true})
-- rename
-- vim.api.nvim_set_keymap('n', '<space>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", {noremap = true, silent = true})
-- preview definition
vim.api.nvim_set_keymap('n', '<leader>gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", {noremap = true, silent = true})
-- diagnostics
-- vim.api.nvim_set_keymap('n', '<leader>d', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '[d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ']d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {noremap = true, silent = true})

