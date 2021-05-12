local tsconf = require'nvim-treesitter.configs'
if not tsconf then
  vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
  return
end
tsconf.setup {
  --ensure_installed = "maintained", --> Installs ALL maintained packages, probably better than "all"
  ensure_installed = {'javascript', 'json', 'lua', 'ruby'},
  highlight = {
    enable = true,
    --disable = { "css" },  -- list of language that will be disabled
    custom_captures = {
      --Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  -- indent = {
  --   enable = false
  -- },
  -- refactor = {
  --   highlight_definitions = {
  --     enable = true
  --   }
  -- },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner"
  --     }
  --   }
  -- }
}
