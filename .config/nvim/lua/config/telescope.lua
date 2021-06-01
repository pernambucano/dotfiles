local telescope = require("telescope")

telescope.setup {
 extensions = {
    fzf = {
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

telescope.load_extension('fzf')

vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>fc', "<cmd>lua require('telescope.builtin').git_branches()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fd', "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>", {noremap = true, silent = true})
