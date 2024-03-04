local utils = require("utils")

vim.api.nvim_create_user_command("TestFileAsync", function()
	local winnr = vim.fn.win_getid()
	local bufnr = vim.api.nvim_win_get_buf(winnr)

	local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
	if not makeprg then
		return
	end

	local filepath = vim.fn.expand("%")
	local cmd = vim.fn.expandcmd(makeprg .. " " .. filepath)
	local efm = vim.api.nvim_buf_get_option(bufnr, "errorformat")

	vim.g.last_async_path = filepath
	vim.g.last_async_cmd = cmd
	vim.g.last_async_efm = efm

	utils.async_run({ command = cmd, efm = efm })
end, {})

vim.api.nvim_create_user_command("TestNearestAsync", function()
	local winnr = vim.fn.win_getid()
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local linenr, _ = unpack(vim.api.nvim_win_get_cursor(winnr))

	local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
	if not makeprg then
		return
	end

	local filepath = vim.fn.expand("%")
	local filepath_with_line = filepath .. ":" .. linenr
	local cmd = vim.fn.expandcmd(makeprg .. " " .. filepath_with_line)
	local efm = vim.api.nvim_buf_get_option(bufnr, "errorformat")

	vim.g.last_async_path = filepath
	vim.g.last_async_cmd = cmd
	vim.g.last_async_efm = efm

	utils.async_run({ command = cmd, efm = efm })
end, {})

vim.api.nvim_create_user_command("TestLastAsync", function()
	if not vim.g.last_async_cmd and not vim.g.last_async_efm then
		vim.notify("Nothing to run yet!", "error")
		return
	end

	utils.async_run({ command = vim.g.last_async_cmd, efm = vim.g.last_async_efm })
end, {})

vim.api.nvim_create_user_command("TestVisitCustom", function()
	if not vim.g.last_async_path then
		vim.notify("Nothing to open")
		return
	end
	vim.cmd("e " .. vim.g.last_async_path)
end, {})

vim.api.nvim_create_user_command("Format", function()
	if vim.lsp.buf.format then
		vim.lsp.buf.format({ async = true })
	elseif vim.lsp.buf.formatting then
		vim.lsp.buf.formatting()
	end
end, { desc = "Format current buffer with LSP" })

vim.api.nvim_create_user_command("ChangeBufferName", function()
	local new_name = ""
	vim.ui.input({ prompt = "Prompt: " }, function(input)
		new_name = input
	end)
	vim.cmd("keepalt file " .. new_name)
end, { desc = "Change Buffer Name" })
