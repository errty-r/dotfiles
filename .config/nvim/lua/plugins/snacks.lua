return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			explorer = {
				hidden = true,
				ignored = true,
			}, -- оставляем дефолтным для LazyVim

			-- 1. Включаем встроенный визуальный стиль Telescope
			layout = {
				preset = "telescope",
			},
			-- 2. Настраиваем горячие клавиши внутри самого поисковика
			win = {
				input = {
					keys = {
						-- Прокрутка превью прямо из режима ввода (как в Telescope)
						["<C-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
						-- История поиска на Alt+j / Alt+k
						["<M-j>"] = { "history_back", mode = { "i", "n" } },
						["<M-k>"] = { "history_forward", mode = { "i", "n" } },
					},
				},
			},
		},
	},
}
