return {
	"pernambucano/executor.nvim",
	dev = true,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require"executor".setup{}
	end,
}
