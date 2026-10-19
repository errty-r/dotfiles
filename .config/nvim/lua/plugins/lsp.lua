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

				vtsls = {
					settings = {
						vtsls = {
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							completion = {
								completeFunctionCalls = true,
								preferTypeOnlyAutoImports = true,
							},

							format = {
								enable = false,
							},

							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = true },
							},

							tsserver = {
								maxTsServerMemory = 8192,
								globalPlugins = {},
								experimental = {
									enableProjectDiagnostics = false,
								},
							},
						},

						javascript = {
							format = { enable = false },
							inlayHints = { parameterNames = { enabled = "all" } },
						},
					},

					keys = {
						{
							"<leader>cM",
							function()
								vim.lsp.buf.execute_command({ command = "typescript.addMissingImports" })
							end,
							desc = "Add missing imports",
						},
						{
							"<leader>cu",
							function()
								vim.lsp.buf.execute_command({ command = "typescript.removeUnusedImports" })
							end,
							desc = "Remove unused imports",
						},
						{
							"<leader>co",
							function()
								vim.lsp.buf.execute_command({ command = "typescript.organizeImports" })
							end,
							desc = "Organize Imports",
						},
						{
							"<leader>cD",
							function()
								vim.lsp.buf.execute_command({ command = "typescript.fixAllDiagnostics" })
							end,
							desc = "Fix all diagnostics",
						},
					},
				},

				eslint = {
					root_dir = function(filename)
						local util = require("lspconfig.util")
						local has_oxlint = util.root_pattern(".oxlintrc.json", "oxlint.json")(filename)

						if has_oxlint then
							return nil
						end

						return util.root_pattern(
							"eslint.config.js",
							"eslint.config.mjs",
							".eslintrc.json",
							"package.json"
						)(filename)
					end,
					settings = {
						workingDirectories = { mode = "location" },
					},
				},

				oxlint = {
					root_dir = function(filename)
						local util = require("lspconfig.util")
						return util.root_pattern(".oxlintrc.json", "oxlint.json")(filename)
					end,
				},

				cssls = {},

				tailwindcss = {},
			},
		},
	},
}
