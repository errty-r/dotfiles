return {
	{
		"khoido2003/roslyn-filewatch.nvim",
		dependencies = { "seblyng/roslyn.nvim" },
		config = function()
			require("roslyn_filewatch").setup({
				-- Утилита сама начнет транслировать изменения в папках obj/ и .csproj напрямую в Roslyn
				enabled = true,
			})
		end,
	},
}
