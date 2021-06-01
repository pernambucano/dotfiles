local tsconf = require'nvim-treesitter.configs'

if not tsconf then
  vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
  return
end

-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()';
-- vim.wo.foldmethod = 'expr';

vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')


tsconf.setup {
  ensure_installed = "maintained", --> Installs ALL maintained packages, probably better than "all"
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }
}

