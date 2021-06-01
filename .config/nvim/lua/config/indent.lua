-- Disable indentline by default
-- vim.g.indentLine_enabled = false

-- Toggle indent lines
vim.api.nvim_set_keymap('n', '<leader>i', ':IndentBlanklineToggle<CR>', {noremap = true, silent = true})

-- Set indent character
-- vim.g.indentLine_char = "│"

-- Use treesitter
vim.g.indent_blankline_use_treesitter = true

vim.g.indent_blankline_show_current_context = true
-- Set indent color
-- vim.cmd('highlight IndentBlanklineChar guifg=#17191c gui=nocombine')

vim.g.indent_blankline_filetype_exclude = {'help','dashboard','dashpreview','NvimTree','coc-explorer','startify','vista','sagahover'}

vim.cmd('highlight IndentBlanklineGreen guifg=#9ece6a gui=nocombine')
vim.cmd('highlight IndentBlanklineYellow guifg=#d79921 gui=nocombine')
vim.cmd('highlight IndentBlanklineBlue guifg=#458588 gui=nocombine')
vim.cmd('highlight IndentBlanklinePurple guifg=#b16286 gui=nocombine')
vim.cmd('highlight IndentBlanklineBrightBlue guibg=#0088ff gui=nocombine')
vim.cmd('highlight IndentBlanklineBrightGreen guifg=#ffffff guibg=#a6e22e gui=nocombine')
vim.cmd('highlight IndentBlanklineWhite guifg=#ffffff gui=nocombine')
-- vim.cmd('highlight IndentBlanklineBege guifg=#fef4da gui=nocombine')

vim.g.indent_blankline_context_highlight_list = {'IndentBlanklinePurple'}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', 'while', 'for', 'with', 'func_literal', 'block'}
