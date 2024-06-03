-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
local opts = {
  install = {
    missing = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
      },
    },
  },
  dev = {
    path = "~/.config/nvim/lua/dev"
  }
}
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	{ import = "custom.plugins" },
}, opts)

-- vim: ts=2 sts=2 sw=2 et
