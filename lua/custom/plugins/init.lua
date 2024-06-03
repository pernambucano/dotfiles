return {
	{ "https://github.com/stevearc/dressing.nvim" },
	-- Git related plugins
	{ "tpope/vim-fugitive",                       cmd = { "Git", "Gdiff", "G" } }, -- Git commands in nvim
	{ "sindrets/diffview.nvim",                   dependencies = { "nvim-lua/plenary.nvim" } },
	-- Test related plugins
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'ahmedkhalf/project.nvim',
		config = function()
			require 'project_nvim'.setup()
		end
	},
	{ 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically
}
