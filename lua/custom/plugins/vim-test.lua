return {
	{
		'vim-test/vim-test',
		cmd = { "TestFile", "TestNearest", "TestLatest" },
		-- keys = {
		-- 	-- stylua: ignore start
		-- 	{ '<leader>tF', '<Cmd>TestFile --coverage <CR>', desc = 'Test: file (coverage)' },
		-- 	{ '<leader>tL', '<Cmd>TestLast --coverage <CR>', desc = 'Test: last (coverage)' },
		-- 	{ '<leader>tN', '<Cmd>TestNearest --coverage <CR>', desc = 'Test: nearest (coverage)' },
		-- 	{ '<leader>tS', '<Cmd>TestSuite --coverage <CR>', desc = 'Test: suite (coverage)' },
		-- 	{ '<leader>tf', '<Cmd>TestFile <CR>', desc = 'Test: file' },
		-- 	{ '<leader>tl', '<Cmd>TestLast <CR>', desc = 'Test: last' },
		-- 	{ '<leader>tn', '<Cmd>TestNearest <CR>', desc = 'Test: nearest' },
		-- 	{ '<leader>ts', '<Cmd>TestSuite <CR>', desc = 'Test: suite' },
		-- 	{ '<leader>tv', '<Cmd>TestVisit<CR>', desc = 'Test: visit' },
		-- 	{ '<leader>tc', '<Cmd>Coverage<CR>', desc = 'Test: coverage' },
		-- 	-- stylua: ignore end
		-- },
		config = function()
			-- vim.g['test#strategy'] = 'neovim'
			vim.g['test#neovim#start_normal'] = '1'
			-- vim.g['test#neovim#term_position'] = 'vert'
			vim.g['test#enabled_runners'] = {"ruby#rspec", "javascript#jest"}
			vim.g['test#ruby#rspec#executable'] = "docker-compose exec -i -w /usr/src/app api bin/rspec "
			vim.g['test#javascript#jest#runner'] = "jest"
			-- vim.g["test#javascript#jest#options"] = "--testRegex=\"(/tests/.*|(\\.|/)(test|spec|integration))\\.[jt]sx?$\""
			-- vim.g['test#javascript#jest#file_pattern']= ".*"
			vim.g['test#strategy'] = "neovim"
			vim.g['test#preserve_screen'] = 1
			vim.g['test#javascript#jest#executable'] = 'yarn node --experimental-vm-modules $(yarn bin jest)'
			vim.g['test#javascript#jest#file_pattern'] = '[**.jest.js | **.test.js]'
			vim.g['test#typescript#jest#file_pattern'] = '[**.jest.ts | **.test.ts]'

			vim.g['test#strategy'] = {
				nearest = 'basic'
			}
		end,
	},
	{
		'andythigpen/nvim-coverage',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function() require('coverage').setup() end,
	},
	{
		'tpope/vim-projectionist',
	},
}
