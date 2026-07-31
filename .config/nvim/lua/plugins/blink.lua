return {
	"saghen/blink.cmp",

	opts = {
		appearance = {
			nerd_font_variant = "mono",
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},

		keymap = {
			preset = "default",

			["<Tab>"] = {
				"select_next",
				"fallback",
			},

			["<S-Tab>"] = {
				"select_prev",
				"fallback",
			},

			["<CR>"] = {
				"accept",
				"fallback",
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},

		completion = {
			ghost_text = {
				enabled = true,
			},

			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,

				window = {
					border = "rounded",
					winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
			},

			menu = {
				border = "rounded",

				winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",

				draw = {
					treesitter = { "lsp" },
				},
			},
		},

		signature = {
			enabled = true,

			window = {
				border = "rounded",
				winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpSignatureCursorLine,Search:None",
			},
		},
	},
}
