local cmd = vim.cmd

-- colors
-- overwrite colors to let tmux dim vim
cmd([[
function! MyHighlights() abort
	highlight Normal ctermbg=NONE guibg=NONE
	highlight EndOfBuffer ctermbg=NONE guibg=NONE
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END
]])
vim.o.syntax = 'on'
cmd("let g:oceanic_next_terminal_bold = 1")
cmd("let g:oceanic_next_terminal_italic = 1")
cmd('colorscheme oceanicnext')
vim.o.termguicolors = true
vim.o.background = 'dark'

-- line numbers
-- vim.wo.relativenumber = true
vim.wo.number = true

-- search
vim.o.inccommand = 'nosplit'
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = true

-- indentation
vim.bo.autoindent = true
vim.o.autoindent = true
vim.bo.expandtab = true
vim.o.expandtab = true
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2
vim.bo.tabstop = 2
vim.o.tabstop = 2

-- other settings
vim.o.clipboard = 'unnamedplus'
vim.wo.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 300
vim.o.showmode = false
vim.o.wildmenu = true
vim.o.showcmd = true
-- vim.o.foldlevel = 99
vim.o.laststatus = 2
vim.o.scrolloff = 3
vim.o.wrap = true
vim.o.mouse = 'a'
vim.g.mapleader = ' '
vim.o.fileencoding = "utf-8"
vim.o.autoread = true
vim.o.autowrite = true
vim.o.autoread = true
vim.o.ruler = true
vim.o.cursorline = true
vim.o.title = true
vim.o.hidden = true
vim.wo.list = true
vim.o.lcs = [[tab:  ,trail:-,extends:>,precedes:<,nbsp:+]]
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.spelllang     = "en"             -- spell check (english and spanish)
cmd('set noswapfile')
cmd('runtime macros/matchit.vim')

-- quicksearch
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_buftype_blacklist = {'terminal', 'nofile'}
vim.g.qs_lazy_highlight = 1

-- vim-test
cmd [[
let test#custom_runners = {'javascript': ['Ember']}
let g:test#strategy = "vtr"
let g:test#enabled_runners = ["ruby#rspec", "javascript#ember"]
let g:test#ruby#rspec#executable = "docker-compose exec -e RAILS_ENV=test api bundle exec rspec"
]]

-- set stl+=%{ConflictedVersion()}
