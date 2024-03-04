return {
	{
		"mcchrish/zenbones.nvim",
		lazy = false,
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		config = function()
			vim.opt.background = "light"
			vim.cmd.colorscheme("zenbones")
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
--
