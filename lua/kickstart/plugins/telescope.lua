-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },

			-- Useful for getting pretty icons, but requires special font.
			--  If you already have a Nerd Font, or terminal set up with fallback fonts
			--  you can enable this
			-- { 'nvim-tree/nvim-web-devicons' }
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of help_tags options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			local telescope_actions = require("telescope.actions")
			local project_actions = require("telescope._extensions.project.actions")
			local custom_picker = {
				hidden = true,
				theme = "ivy",
				path_display = { "truncate" },
				prompt_prefix = "🔍",
			}

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_ivy(),
					},
					project = {
						base_dirs = {
							vim.fn.expand(vim.env.BASE_DIR_PROJECT),
						},
						hidden_files = true, -- default: false
						theme = "ivy",
						on_project_selected = function(prompt_bufnr)
							-- Do anything you want in here. For example:
							project_actions.change_working_directory(prompt_bufnr, false)
						end,
					},
				},

				pickers = {
					buffers = custom_picker,
					file_browser = custom_picker,
					git_files = custom_picker,
					grep_string = custom_picker,
					live_grep = custom_picker,
					oldfiles = custom_picker,
					find_files = custom_picker,
				},

				defaults = {
					preview = {
						hide_on_startup = true,
						treesitter = {
							enable = false, -- Disable treesitter to improve performance until it uses rust
						},
					},

					mappings = {
						i = {
							["<ESC>"] = telescope_actions.close,
							["<C-c>"] = telescope_actions.close,
							["<C-j>"] = telescope_actions.move_selection_next,
							["<C-k>"] = telescope_actions.move_selection_previous,
							["<C-q>"] = telescope_actions.send_to_qflist,
							["<C-enter>"] = telescope_actions.to_fuzzy_refine,
						},
						n = {
							["<ESC>"] = telescope_actions.close,
						},
					},
				},
			})

			-- Enable telescope extensions, if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension("project"))

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			-- vim.keymap.set("n", "<leader>s/", function()
			-- 	builtin.live_grep({
			-- 		grep_open_files = true,
			-- 		prompt_title = "Live Grep in Open Files",
			-- 	})
			-- end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>fd", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			vim.keymap.set("n", "<C-p>", "<cmd>lua require'utils'.project_files()<cr>", { desc = "Open files"})
			vim.keymap.set(
				"n",
				"<leader>fl",
				"<cmd>lua require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir() })<CR>", {desc = "Open files in current cwd"})
			vim.keymap.set("n", "<leader><leader>", ':lua require("telescope.builtin").buffers()<CR>')
			vim.keymap.set("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>')
			vim.keymap.set("n", "<leader>fb", ':lua require("telescope.builtin").git_branches()<CR>')
			vim.keymap.set("n", "<leader>fc", ':lua require("telescope.builtin").git_bcommits()<CR>')
			vim.keymap.set("n", "<leader>fs", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
			vim.keymap.set("n", "<leader>fw", ':lua require("telescope.builtin").grep_string()<CR>')
			vim.keymap.set("n", "<leader>ft", ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')
			vim.keymap.set("n", "<leader>fh", ':lua require("telescope.builtin").help_tags({ previewer = false })<CR>')
			vim.keymap.set("n", "<leader>fa", "<cmd>lua vim.lsp.buf.code_action()<cr>")
			vim.keymap.set("n", "<leader>fo", ':lua require("telescope.builtin").resume()<CR>', { desc = "Resume search" })
			vim.keymap.set(
				"n",
				"<leader>fp",
				':lua require"telescope".extensions.project.project{ display_type = "full" }<CR>'
			)
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
