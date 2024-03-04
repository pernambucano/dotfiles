local M = {}

-- Open find_files if there is not a git repo
function M.project_files()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
	if not ok then
		require("telescope.builtin").find_files({})
	end
end

-- Run command asyncronously
function M.async_run(process)
	if not process.command then
		return
	end

	local lines = { "" }

	local function cmd_to_execute()
		local cmd = vim.fn.expandcmd(process.command)
		-- progress_handle.message = "Working on " .. cmd
		-- print("Running Test")
		vim.g.running_result = "Running Test"
		return cmd
	end

	local function on_event(_, data, event)
		if event == "stdout" or event == "stderr" then
			if data then
				vim.list_extend(lines, data)
			end
		end

		if event == "exit" then
			-- progress_handle:finish()
			vim.fn.setqflist({}, " ", { title = cmd, lines = lines, efm = process.efm })

			if #lines == 0 then
				print("No output from cmd")
			else
				-- Put this inside a callback
				if #vim.fn.getqflist() == 0 then
					vim.g.running_result = "Success"
					-- vim.notify("Success!")
					-- vim.cmd([[
					-- 	echohl GreenBar
					-- 	echomsg "Success" repeat(" ", &columns - strlen("Success") - 2)
					-- 	echohl None
					-- ]])
				else
					-- vim.cmd([[
					-- 	echohl RedBar
					-- 	echomsg "Fail" repeat(" ", &columns - strlen("Fail") - 2)
					-- 	echohl None
					-- ]])
					vim.g.running_result = "Fail"
					vim.api.nvim_command("doautocmd QuickFixCmdPost")
				end
				vim.cmd.cw()
			end
		end
	end

	vim.fn.jobstart(cmd_to_execute(), {
		on_stderr = on_event,
		on_stdout = on_event,
		on_exit = on_event,
		stdout_buffered = true,
		stderr_buffered = true,
	})
end

return M
