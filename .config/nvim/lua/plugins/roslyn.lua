return {
	"seblyng/roslyn.nvim",

	ft = { "cs", "razor" },

	opts = {
		broad_search = true,
		lock_target = false,
		silent = false,

		filewatching = "auto",

		config = {
			settings = {
				["csharp|completion"] = {
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
					dotnet_provide_regex_completions = true,
				},

				["csharp|background_analysis"] = {
					dotnet_compiler_diagnostics_scope = "fullSolution",
					dotnet_analyzer_diagnostics_scope = "fullSolution",
				},

				["csharp|symbol_search"] = {
					dotnet_search_reference_assemblies = true,
				},

				["csharp|formatting"] = {
					dotnet_organize_imports_on_format = true,
				},

				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
					dotnet_enable_tests_code_lens = true,
				},

				["csharp|inlay_hints"] = {
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_literal_values = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_lambda_parameter_types = true,
					dotnet_enable_inlay_hints_for_implicit_object_creation = true,
				},
			},
		},
	},
}
