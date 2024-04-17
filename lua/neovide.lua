if not vim.g.neovide then
	return
end

-- Font
local font = {
	-- family = "SauceCodePro Nerd Font no",
	family = "JetBrains Mono,Symbols Nerd Font Mono",
	linespace = 2,
	size = 15,
	width = 0, -- letter spacing: neovide/neovide#1227
}

function font.sync(self)
	vim.o.guifont = string.format(
		"%s" .. ":h%s" .. ":w%s" .. "%s",
		font.family,
		font.size, -- :h (height)
		font.width, -- :w (width)
		"")
	vim.o.linespace = self.linespace or 0
end

font:sync()

function font.adjust_size(self, adjust)
	vim.validate { adjust = { adjust, 'number' } }
	self.size = self.size + adjust
	self:sync()
end

function font.set_size(self, size)
	vim.validate { size = { size, 'number' } }
	self.size = size
	self:sync()
end

-- Sensible default keymaps (Cmd+... keys)
local ALL_DES = { 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't' }

-- Cmd + V
vim.keymap.set({ 'i', 'c', 't' }, '<D-v>', '<Plug>(neovide-paste)', { remap = true })
vim.keymap.set({ 'i', 'c', 't' }, '<S-Insert>', '<Plug>(neovide-paste)', { remap = true })
vim.keymap.set({ 'i', 'c' }, '<Plug>(neovide-paste)', '<cmd>set paste<CR><C-r>+<cmd>set nopaste<CR>', { silent = true })
-- Cmd + {0, -, +}
vim.keymap.set(ALL_DES, '<D-=>', function() font:adjust_size(1) end)
vim.keymap.set(ALL_DES, '<D-->', function() font:adjust_size(-1) end)
vim.keymap.set(ALL_DES, '<D-0>', function() font:set_size(16) end)

-- Cmd + Tab
vim.keymap.set({ 'n', 'i', 't' }, '<D-t>', '<Cmd>norm <c-t><CR>', { remap = true })

vim.g.neovide_scroll_animation_length = 0

vim.g.neovide_floating_shadow = false

vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 1.0
vim.g.neovide_no_idle = true        -- Default false
vim.g.neovide_input_use_logo = true -- Default false
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_padding_top = 10
vim.opt.linespace = 3

-- Cursor
vim.g.neovide_cursor_animation_length = 0.04 -- Default 0.06
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_hide_mouse_when_typing = false
vim.g.neovide_cursor_animate_in_insert_mode = true
