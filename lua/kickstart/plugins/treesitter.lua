return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
    dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-endwise", -- add "end" in Ruby and other languages
    },
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"ruby",
					"javascript",
					"typescript",
					"glimmer",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				autopairs = { enable = true },
				endwise = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

			-- [[Setting up folding through treesitter]]
			local define_modules = require("nvim-treesitter").define_modules
			local query = require("nvim-treesitter.query")

			local foldmethod_backups = {}
			local foldexpr_backups = {}

			define_modules({
				folding = {
					enable = true,
					attach = function(bufnr)
						-- Fold settings are actually window based...
						foldmethod_backups[bufnr] = vim.wo.foldmethod
						foldexpr_backups[bufnr] = vim.wo.foldexpr
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
					end,
					detach = function(bufnr)
						vim.wo.foldmethod = foldmethod_backups[bufnr]
						vim.wo.foldexpr = foldexpr_backups[bufnr]
						foldmethod_backups[bufnr] = nil
						foldexpr_backups[bufnr] = nil
					end,
					is_supported = query.has_folds,
				},
			})
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
