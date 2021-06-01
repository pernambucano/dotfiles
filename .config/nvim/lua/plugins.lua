return require('packer').startup(function()
   -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- treesitter
  use {'nvim-treesitter/nvim-treesitter',
        config=[[require('config.treesitter')]],
        run=':TSUpdate'}

  -- telescope
  use {'nvim-telescope/telescope.nvim',
        config=[[require('config.telescope')]],
        requires={{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}

 -- nvim-lspconfig
  use {'neovim/nvim-lspconfig',
        config=[[require('config.lsp-config')]]}

 -- nvim-compe
  use {'hrsh7th/nvim-compe',
       config=[[require('config.nvim-compe')]],
       requires={'hrsh7th/vim-vsnip'}}

 -- lspsaga
   use { 'glepnir/lspsaga.nvim', config=[[require('config.saga')]] }

 -- nvim-tree
 use {'kyazdani42/nvim-tree.lua',
       config=[[require('config.nvim-tree')]]}

 -- lspkind
 use {'onsails/lspkind-nvim',
       config=[[require('config.lsp-kind')]]}

 -- lualine
 use {'hoob3rt/lualine.nvim',
       config=[[require('config.lualine')]]}

 --  indent-blankline
 use {'lukas-reineke/indent-blankline.nvim', config=[[require('config.indent')]], branch = 'lua' }

 -- vim test
 use {'vim-test/vim-test'}

 -- quick-scope
 use 'unblevable/quick-scope'

 -- hexokinase
 use {'rrethy/vim-hexokinase', run = 'make hexokinase' }

 -- nvim-web-devicons
 use { 'yamatsum/nvim-nonicons',
	 requires = {'kyazdani42/nvim-web-devicons'}}

 use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

 -- -- plugins I still need to fix config
 use 'tpope/vim-surround'
 use 'tpope/vim-commentary'
 -- -- use 'airblade/vim-rooter'
 use 'tpope/vim-fugitive'
 use 'christoomey/vim-tmux-runner'
 use 'christoomey/vim-tmux-navigator'
 use 'vim-ruby/vim-ruby'
 use 'tpope/vim-rails'
 use 'tpope/vim-endwise'
 use 'tpope/vim-ragtag'
 use 'tpope/vim-unimpaired'
 use 'christoomey/vim-conflicted'
 use 'joukevandermaas/vim-ember-hbs'
 use 'mattn/emmet-vim'
 use 'tpope/vim-abolish'
 -- use 'folke/todo-comments.nvim'
 -- use 'folke/trouble.nvim'
 use {'windwp/nvim-autopairs', config=[[require('config.autopairs')]]}

 --themes
 use 'GlennLeo/cobalt2'
 use 'Rigellute/rigel'
 use 'folke/tokyonight.nvim'
 use 'NLKNguyen/papercolor-theme'
 use 'sainnhe/everforest'
 use 'arcticicestudio/nord-vim'
 use 'ishan9299/nvim-solarized-lua'
 use 'mhartington/oceanic-next'
 use 'ahmedkhalf/lsp-rooter.nvim'
end)
