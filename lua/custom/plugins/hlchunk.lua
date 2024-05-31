return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		-- local palette = require "zenbones.palette"
		local normal_colors = vim.api.nvim_get_hl_by_name("Normal", true)
		local normal_fg = string.format('#%06x', normal_colors.foreground)
		require("hlchunk").setup({
			chunk = {
				enable = true,
				notify = true,
				use_treesitter = true,
				-- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
				support_filetypes = { "*.ts", "*.js", "*.rb" },
				chars = {
					-- horizontal_line = "┄",
					-- vertical_line = "┆",
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				style = {
					{ fg = normal_fg },
					{ fg = "#00ff00" }, -- this fg is used to ighlight wrong chunk
				},
				textobject = "",
				max_file_size = 1024 * 1024,
				error_sign = true,
			},

			indent = {
				enable = false,
			},

			line_num = {
				enable = false,
			},

			blank = {
				enable = false,
			},

		})
	end
}
