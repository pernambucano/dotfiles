set runtimepath-=~/.config/nvim
set runtimepath-=~/.config/nvim/after
set runtimepath-=~/.local/share/nvim/site
set runtimepath-=~/.local/share/nvim/site/after

set runtimepath+=~/.config/nvim-nightly/after
set runtimepath^=~/.config/nvim-nightly
set runtimepath+=~/.local/share/nvim-nightly/site/after
set runtimepath^=~/.local/share/nvim-nightly/site

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'preservim/nerdtree'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
" Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-runner'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
" Plug 'kana/vim-textobj-user'
" Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-conflicted'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'itchyny/lightline.vim'
" let g:dracula_italic = 0
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/forest-night'
" Plug 'arcticicestudio/nord-vim'
Plug 'mattn/emmet-vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'ryanoasis/vim-devicons'
Plug 'lifepillar/vim-solarized8'
Plug 'unblevable/quick-scope'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'edkolev/tmuxline.vim'
call plug#end()

lua require('basic_config')

syntax enable " enable syntax highlight
set termguicolors
set background=dark
colorscheme forest-night
set fileencoding=utf-8                  " The encoding written to file
set noshowmode
set showcmd " show incomplete commands
set completeopt=menu,menuone,noselect
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set ruler
set cursorline
" set cursorcolumn
set hlsearch
set incsearch
set splitbelow
set splitright
set noswapfile
set autowrite " automatically :write before running commands
set autoread
set autoindent
set linebreak " break lines on words
set scrolloff=3 "minimum lines above and below cursor
set title
set titlestring=%f%(\ [%M]%)
set hidden
set shortmess+=c

""""""""""""""""""""
" Code Management
""""""""""""""""""""
" set foldmethod=indent "" fold based on indentation
" set foldlevel=99
" set nofoldenable      "" don't open a file with folds, display the whole thing
set signcolumn=yes    "" always show the signcolumn


" set relativenumber
runtime macros/matchit.vim

filetype plugin indent on
set clipboard=unnamed

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd BufRead,BufNewFile *.html.erb set filetype=eruby.html
  " autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END


let test#strategy = "vtr"
let test#enabled_runners = ["ruby#rspec"]
let test#ruby#rspec#executable = 'docker-compose exec -e RAILS_ENV=test api bundle exec rspec'

set stl+=%{ConflictedVersion()}

nnoremap <Leader>gs :Gstatus<CR>
 
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> [B :blast<CR>

nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

nmap 0 ^

nmap <leader>vr :sp $MYVIMRC<CR>
nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vi :tabedit $MYVIMRC<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

map  <leader><Space> :nohl<CR>

" nmap k gk
" nmap j gj

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-t> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let g:user_emmet_leader_key='\<SPACE>'

" copies the current filename into clipboard 
nmap ,cs :let @*=expand("%")<CR> 
" copies full filepath into clipboard
nmap ,cl :let @*=expand("%:p")<CR> 

let g:lightline = {
      \ 'colorscheme': 'forest_night',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch'],
      \             [ 'filename'],
      \             ['gitversion']],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'gitversion' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'gitversion': 'ConflictedVersion',
      \ }
      \ }


""search for all files
"nmap <Leader>f :Files<CR> 
""search in open buffers
"nmap <Leader>b :Buffers<CR>
""search tags in current buffer
"nmap <Leader>t :BTags<CR> 
""search tags in whole project - look for gutentag
"nmap <Leader>T :Tags<CR> 
""search line in current buffer
"nmap <Leader>l :BLines<CR> 
""search for line in loaded buffers
"nmap <Leader>L :Lines<CR> 
""search in project
"nmap <Leader>r :Rg<Space> 
""search in buffer history
"nmap <Leader>h :History<CR>

"nmap <C-p> :GFiles<CR>

"let g:fzf_action = {
"    \ 'ctrl-t': 'tab split',
"    \ 'ctrl-i': 'split',
"    \ 'ctrl-v': 'vsplit'}

"" Enable per-command history.
"" CTRL-N and CTRL-P will be automatically bound to next-history and
"" previous-history instead of down and up. If you don't like the change,
"" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
"let g:fzf_history_dir = '~/.local/share/fzf-history'

"let g:fzf_tags_command = 'ctags -R'
"" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
"let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
"" let g:fzf_preview_window = ['right:50%', 'ctrl-/']

"let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
"let $FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore-vcs -g '!{node_modules,.git,tmp}'"


"" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }

""Get Files
"command! -bang -nargs=? -complete=dir Files
"    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


"" Get text in files with Rg
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"  \   fzf#vim#with_preview(), <bang>0)

"" Ripgrep advanced
"function! RipgrepFzf(query, fullscreen)
"  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
"  let initial_command = printf(command_fmt, shellescape(a:query))
"  let reload_command = printf(command_fmt, '{q}')
"  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
"endfunction

"command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"" Git grep
"command! -bang -nargs=* GGrep
"  \ call fzf#vim#grep(
"  \   'git grep --line-number '.shellescape(<q-args>), 0,
"  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0):

nnoremap <leader>gs :Gstatus<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable      " don't open a file with folds, display the whole thing

lua require('lsp_config')
lua require('treesitter_config')
lua require('quickscope_config')
lua require('saga_config')
lua require('telescope_config')

" hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" " Warnings in Yellow
" hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" " Info and Hints in White
" hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
" hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

" hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline


inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
