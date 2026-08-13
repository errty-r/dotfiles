vim.filetype.add({
	extension = {
		csproj = "xml",
		props = "xml",
		targets = "xml",
		env = "sh",
		conf = "sh",
	},
	filename = {
		[".env"] = "sh",
	},
})

return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
				python = { "ruff" },
				xml = { "yq" },
				yaml = { "prettier" },
				yml = { "prettier" },
				sh = { "shfmt" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "4" },
				},
				shfmt = {
					args = { "-i", "4", "-ci", "-sr" },
				},
				yq = {
					args = { "eval", "-p", "xml", "-o", "xml", "--indent", "4" },
				},
			},
		},
	},
}
