if vim.g.neovide ~= nil then
	vim.g.gui_font_default_size = 15
	vim.g.gui_font_size = vim.g.gui_font_default_size
	vim.g.gui_font_face = "IBM Plex Mono"
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_scroll_animation_length = 0.1

	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_size + delta
		RefreshGuiFont()
	end

	ResetGuiFont = function()
		vim.g.gui_font_size = vim.g.gui_font_default_size
		RefreshGuiFont()
	end

	-- Call function on startup to set default font size
	ResetGuiFont()

	-- Resize font
	local opts = { noremap = true, silent = true }
	vim.keymap.set({ "n", "i" }, "<M-k>", function()
		ResizeGuiFont(1)
	end, opts)
	vim.keymap.set({ "n", "i" }, "<M-j>", function()
		ResizeGuiFont(-1)
	end, opts)

	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_transparency = 1.0
	vim.g.neovide_no_idle = true -- Default false
	vim.g.neovide_fullscreen = false
	vim.g.neovide_input_use_logo = true -- Default false
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.opt.linespace = 2

	-- Cursor
	vim.g.neovide_cursor_animation_length = 0.04 -- Default 0.06
	vim.g.neovide_cursor_antialiasing = true

	vim.g.neovide_remember_window_size = true
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.o.guicursor = "i:ver30-Cursor-blinkwait300-blinkon300-blinkoff300"

	-- vim.g.neovide_padding_top = 20
	-- vim.g.neovide_padding_bottom = -8
	-- vim.g.neovide_padding_right = 0
	-- vim.g.neovide_padding_left = 0
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true }) -- Paste normal mode
end
