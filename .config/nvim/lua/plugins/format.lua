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
		format_on_save = {
			timeout_ms = 0,
			lsp_format = "never",
		},
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
				python = { "ruff" },
				xml = { "yq" },

				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },

				json = { "prettier" },
				jsonc = { "prettier" },

				yaml = { "prettier" },

				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },

				yml = { "prettier" },
				sh = { "shfmt" },
			},
			formatters = {
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
