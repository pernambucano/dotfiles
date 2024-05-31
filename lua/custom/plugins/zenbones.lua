return {
  {
    "mcchrish/zenbones.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.g.zenbones_colorize_diagnostic_underline_text = true
      vim.g.zenbones_transparent_background = false
      vim.g.zenbones_lighten_noncurrent_window = true
      vim.g.zenbones_solid_float_border = false
      vim.g.zenbones_solid_vert_split = false

      vim.g.zenwritten_colorize_diagnostic_underline_text = true
      vim.g.zenwritten_transparent_background = false
      vim.g.zenwritten_lighten_noncurrent_window = true
      vim.g.zenwritten_solid_float_border = false
      vim.g.zenwritten_solid_vert_split = false

      -- vim.opt.background = "light"
      -- vim.cmd.colorscheme("zenbones")

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "zenbones",
        callback = function()
          vim.api.nvim_set_hl(0, 'NormalFloat', { link = "Normal" })
        end,
        desc = "Override Zenbones",
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
