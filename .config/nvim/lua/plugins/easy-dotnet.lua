return {
	{
		"GustavEikaas/easy-dotnet.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim",
		},

		ft = {
			"cs",
			"razor",
		},

		config = function()
			require("easy-dotnet").setup({
				lsp = {
					enabled = false,
				},
			})
		end,
	},
}
