vim.api.nvim_create_augroup("_general", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "_general",
	pattern = "fugitive,git,fugitiveblame,help,man,lspinfo,startuptime,checkhealth",
	callback = function()
		vim.cmd("nnoremap <silent><buffer> q :close<cr>")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "_general",
	pattern = "DiffviewFileHistory,DiffviewFiles",
	callback = function()
		vim.cmd("nnoremap <silent><buffer> q :DiffviewClose<cr>")
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	group = "_general",
	callback = function()
		if vim.bo.filetype == "" then
			-- vim.cmd.startinsert()

			vim.cmd("setlocal listchars= nonumber norelativenumber")
			vim.cmd([[tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi']])

			local opts = { silent = false, buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
			vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
			vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
			vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
			vim.keymap.set("n", "<C-\\><C-q>", ":bd!<CR>", opts)
		end
	end,
})
