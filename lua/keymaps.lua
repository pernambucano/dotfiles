-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Open file navigator
vim.keymap.set("n", "<C-n>", "<cmd>Oil<CR>")

-- default keymaps
vim.keymap.set("n", "Q", ":q!<CR>", { desc = "Close file" })
vim.keymap.set("n", "<leader>cf", ':let @*=expand("%")<CR>', { desc = "copy filename" })
vim.keymap.set("n", "<leader>cp", ':let @*=expand("%:p")<CR>', { desc = "copy filepath" })
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<C-c>", "<Esc>", { desc = "Cancel action" })
vim.keymap.set(
	"n",
	"c<Tab>",
	":let @/=expand('<cword>')<CR>cgn",
	{ desc = "Change current word and save it for later" }
)
vim.keymap.set("n", "<leader>[", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { desc = "Add one line up" })
vim.keymap.set("n", "<leader>]", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { desc = "Add one lne down" })
vim.keymap.set("n", "<BS>", "<C-^>", { desc = "Go to alternative file" })
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Go to next item on qlist" })
vim.keymap.set("n", "[q", ":cprevious<CR>", { desc = "Go to previous item on qlist" })
vim.keymap.set("n", "]Q", ":clast<CR>", { desc = "Go to last item on qlist" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { desc = "Go to first item on qlist" })
vim.keymap.set("v", "p", '"_dP', { desc = "Past with format" })
vim.keymap.set("n", "<leader>l", ":noh<CR>", { desc = "Clear searched highlight" })
vim.keymap.set("n", "n", "nzz", { desc = "Center file when searching forward" })
vim.keymap.set("n", "N", "Nzz", { desc = "Center file when searching backward" })
vim.keymap.set(
	"n",
	"<leader>cd",
	"<cmd>args `rg --files-with-matches debugger | rg --type ruby --files-with-matches byebug app/` | argdo :g/debugger/d | argdo :g/byebug/d | update<CR>",
	{ desc = "Remove debugger from ruby files" }
)

vim.keymap.set("n", "<leader>ff", ":Format<CR>", { desc = "Format file" })

vim.keymap.set("n", "zp", "zMzvzzzczO", { desc = "Close all folds but the this one" })

vim.keymap.set("n", "<leader>dj", "1gt", { desc = "Go to the first tab" })
vim.keymap.set("n", "<leader>dk", "2gt", { desc = "Go to the second tab" })
vim.keymap.set("n", "<leader>dl", "3gt", { desc = "Go to the third tab" })
vim.keymap.set("n", "<leader>d;", "4gt", { desc = "Go to the fourth tab" })

-- plugins keymaps

-- DAP
vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>")

-- Fugitive
vim.keymap.set("n", "<leader>g", ":tab Git<CR>")

-- Vim-Test
vim.keymap.set("n", "t<C-n>", ":TestNearest<CR>")
vim.keymap.set("n", "t<C-f>", ":TestFile<CR>")
vim.keymap.set("n", "t<C-l>", ":TestLast<CR>")
vim.keymap.set("n", "t<C-g>", ":TestVisit<CR>")
vim.keymap.set("n", "t<C-t>", ":TestParallel<CR>")

-- Harpoon
vim.keymap.set("n", "<leader>hh", ':lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set("n", "<leader>hp", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set("n", "<leader>ha", ':lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set("n", "<leader>hs", ':lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set("n", "<leader>hd", ':lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set("n", "<leader>hf", ':lua require("harpoon.ui").nav_file(4)<CR>')

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Terminal
vim.keymap.set({ "n" }, "<leader>tl", ":vsp | :term<CR>")
vim.keymap.set({ "n" }, "<leader>tj", ":sp | :term<CR>")
vim.keymap.set({ "n" }, "<leader>tt", ":tabnew | :term<CR>")

-- vim: ts=2 sts=2 sw=2 et
