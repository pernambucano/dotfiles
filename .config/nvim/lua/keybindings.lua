local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>gs', ':Git<CR>')

-- nnoremap <silent> [b :bprevious<CR>
-- nnoremap <silent> ]b :bnext<CR>
-- nnoremap <silent> [B :bfirst<CR>
-- nnoremap <silent> [B :blast<CR>

map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

map('n', '<leader>/', ':Commentary<CR>')
map('v', '<leader>/', ':Commentary<CR>')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')


map('n', '<leader>vr', ':sp $VIMRC<CR>')
map('n', '<leader>vo', ':so $VIMRC<CR>')
map('n', '<leader>vi', ':tabedit $VIMRC<CR>')

-- nnoremap <Left> :echoe "Use h"<CR>
-- nnoremap <Right> :echoe "Use l"<CR>
-- nnoremap <Up> :echoe "Use k"<CR>
-- nnoremap <Down> :echoe "Use j"<CR>

-- map  <leader><Space> :nohl<CR>
map('n', '<leader><leader>', ':nohl<CR>')

-- let g:user_emmet_leader_key='\<SPACE>'
-- " copies the current filename into clipboard 
-- nmap ,cs :let @*=expand("%")<CR>
-- " copies full filepath into clipboard
-- nmap ,cl :let @*=expand("%:p")<CR>
local default_opts = {noremap = true, silent = true}

map('n', 't<C-n>', ':TestNearest<CR>', default_opts)
map('n', 't<C-f>', ':TestFile<CR>', default_opts)
map('n', 't<C-t>', ':TestSuite<CR>', default_opts)
map('n', 't<C-l>', ':TestLast<CR>', default_opts)
map('n', 't<C-g>', ':TestVisit<CR>', default_opts)
