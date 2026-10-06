return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			explorer = {
				hidden = true,
				ignored = true,
			},

			layout = {
				preset = "telescope",
			},

			win = {
				input = {
					keys = {
						["<C-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-b>"] = { "preview_scroll_up", mode = { "i", "n" } },

						["<M-j>"] = { "history_back", mode = { "i", "n" } },
						["<M-k>"] = { "history_forward", mode = { "i", "n" } },
					},
				},
			},
		},
	},
}
