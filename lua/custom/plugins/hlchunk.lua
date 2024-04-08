return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		local palette = require "zenbones.palette"
		require("hlchunk").setup({
			chunk = {
				enable = true,
				notify = true,
				use_treesitter = true,
				-- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
				support_filetypes = { "*.ts", "*.js", "*.rb" },
				chars = {
					horizontal_line = "┄",
					vertical_line = "┆",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				style = {
					-- { fg = palette.light.blossom.hex},
					-- { fg = palette.light.wood.hex }, -- this fg is used to highlight wrong chunk
					{fg = "#8BC1AA"},
					{fg = "#CF694A"}
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
