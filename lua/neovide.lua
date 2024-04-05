if vim.g.neovide ~= nil then
	vim.g.neovide_scroll_animation_length = 0

	vim.g.neovide_floating_shadow = false
	-- vim.g.neovide_floating_z_height = 5
	-- vim.g.neovide_light_angle_degrees = 45
	-- vim.g.neovide_light_radius = 60

	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_transparency = 1.0
	vim.g.neovide_no_idle = true -- Default false
	-- vim.g.neovide_fullscreen = false
	vim.g.neovide_input_use_logo = true -- Default false
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.opt.linespace = 3

	-- Cursor
	vim.g.neovide_cursor_animation_length = 0.04 -- Default 0.06
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_cursor_animate_in_insert_mode = true
	-- vim.opt.guicursor = "i:ver30-Cursor-blinkwait300-blinkon300-blinkoff300"

	vim.g.neovide_padding_top = 10
	-- vim.g.neovide_padding_bottom = 20
	-- vim.g.neovide_padding_right = 0
	-- vim.g.neovide_padding_left = 0
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true }) -- Paste normal mode
end
