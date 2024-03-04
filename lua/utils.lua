local M = {}

-- Open find_files if there is not a git repo
function M.project_files()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
	if not ok then
		require("telescope.builtin").find_files({})
	end
end

return M
