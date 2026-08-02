return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},

				underline = true,
				severity_sort = true,

				update_in_insert = true,

				float = {
					border = "rounded",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					pcall(vim.lsp.inlay_hint.enable, true, {
						bufnr = args.buf,
					})
				end,
			})
		end,
	},
}
