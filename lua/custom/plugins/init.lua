-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{"https://github.com/stevearc/dressing.nvim"},
	-- Git related plugins
	{ "tpope/vim-fugitive",         cmd = { "Git", "Gdiff", "G" } }, -- Git commands in nvim
	{ "sindrets/diffview.nvim",     dependencies = { "nvim-lua/plenary.nvim" } },
	-- Test related plugins
	{ 'nvim-tree/nvim-web-devicons' },
	{'ahmedkhalf/project.nvim', config = function ()
		require'project_nvim'.setup()
	end}
}
