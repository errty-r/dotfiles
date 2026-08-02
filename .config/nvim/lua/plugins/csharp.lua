return {
	{
		"seblyng/roslyn.nvim",
		config = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.cs",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})

			vim.api.nvim_create_autocmd({
				"BufEnter",
				"CursorHold",
				"InsertLeave",
			}, {
				pattern = "*.cs",
				callback = function()
					pcall(vim.lsp.codelens.update)
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*.csproj",
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspRestart roslyn")
					end, 1000)
				end,
			})
		end,
	},
}
