return {
	{
		"https://github.com/rose-pine/neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				dark_variant = "moon",
				disable_italics = true,
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				highlight_groups = {
					LineNr = { fg = "highlight_high" },
					CursorLineNr = { fg = "text" },
					StatusLine = { fg = "love", bg = "#f5e9e3" },
					DiagnosticVirtualTextError = { bg = "#f5e9e3" },
					DiagnosticVirtualTextWarn = { bg = "#f6ebdd" },
					DiagnosticVirtualTextInfo = { bg = "#eaeae5" },
					DiagnosticVirtualTextHint = { bg = "#efe8e6" },
					Visual = { bg = "#e3e7e2" },
					WinSeparator = { fg = "highlight_med" },
					IblScope = { fg = "highlight_med" },
					IblIndent = { fg = "highlight_low" },
					TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
					TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
					TelescopeTitle = { fg = "base", bg = "love" },
					TelescopePromptTitle = { fg = "base", bg = "pine" },
					TelescopePreviewTitle = { fg = "base", bg = "iris" },
					TelescopePromptNormal = { fg = "text", bg = "surface" },
					TelescopePromptBorder = { fg = "surface", bg = "surface" },
					LuaLineDiffAdd = { fg = "#56949f", bg = "#faf4ed" },
					LuaLineDiffChange = { fg = "#d7827e", bg = "#faf4ed" },
					GitSignsAdd = { fg = "#bacfc4" },
					GitSignsChange = { fg = "#e6d2c1" },
					GitSignsDelete = { fg = "#dbb6b4" },
					EndOfBuffer = { fg = "highlight_med" },
				},
			})
			-- vim.cmd([[colorscheme rose-pine-dawn]])
		end,
	}
}
