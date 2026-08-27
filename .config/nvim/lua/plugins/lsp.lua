return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = {
					spacing = 2,
					prefix = "",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "  ",
					},
				},
				underline = true,
				severity_sort = true,
				update_in_insert = true,
				float = {
					border = "rounded",
				},
			},
			underline = true,
			severity_sort = true,

			update_in_insert = true,

			float = {
				border = "rounded",
			},
			codelens = {
				enabled = false,
			},
			inlay_hints = {
				enabled = true,
			},
			servers = {
				["*"] = {
					keys = {
						-- Убираем LazyVim rename
						{ "<leader>cr", false },

						-- Ставим references
						{
							"<leader>cr",
							function()
								Snacks.picker.lsp_references()
							end,
							desc = "References",
							has = "references",
						},

						-- Rename оставляем на cR
						{
							"<leader>cR",
							vim.lsp.buf.rename,
							desc = "Rename",
							has = "rename",
						},
					},
				},

				-- Оставляем блокировку дубликата, чтобы он не мешал
				roslyn_ls = {
					settings = {
						["csharp|background_analysis"] = {
							dotnet_compiler_diagnostics_scope = "fullSolution",
							dotnet_analyzer_diagnostics_scope = "fullSolution",
						},

						["csharp|completion"] = {
							dotnet_show_completion_items_from_unimported_namespaces = true,
							dotnet_show_name_completion_suggestions = true,
							dotnet_provide_regex_completions = true,
						},

						["csharp|symbol_search"] = {
							dotnet_search_reference_assemblies = true,
						},

						["csharp|formatting"] = {
							dotnet_organize_imports_on_format = true,
						},

						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = false,
							dotnet_enable_tests_code_lens = false,
						},

						["csharp|inlay_hints"] = {
							csharp_enable_inlay_hints_for_implicit_object_creation = true,
							csharp_enable_inlay_hints_for_implicit_variable_types = true,
							csharp_enable_inlay_hints_for_lambda_parameter_types = true,
							csharp_enable_inlay_hints_for_types = true,
							dotnet_enable_inlay_hints_for_indexer_parameters = true,
							dotnet_enable_inlay_hints_for_literal_parameters = true,
							dotnet_enable_inlay_hints_for_object_creation_parameters = true,
							dotnet_enable_inlay_hints_for_other_parameters = true,
							dotnet_enable_inlay_hints_for_parameters = true,
						},

						["csharp"] = {
							dotnet_enable_document_formatting = true,
						},
					},
				},
			},
		},
	},
}
