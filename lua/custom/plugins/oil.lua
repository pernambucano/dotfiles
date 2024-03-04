return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			keymaps = {
				["q"] = "actions.close",
			},
		})

		vim.keymap.set("n", "<C-n>", "<cmd>Oil<CR>", { desc = "Open file explorer" })
	end,
}
