return {
	-- Отключаем дефолтную тему LazyVim (tokyonight), если хотите использовать gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},

	-- Настройка самой темы Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- Загружаем тему первой
		config = function()
			require("gruvbox").setup({
				transparent_mode = true, -- Включает прозрачность для базовых элементов
			})
		end,
	},
}

-- return {
-- 	-- отключаем дефолтную тему lazyvim (tokyonight), если хотите использовать gruvbox
-- 	{
-- 		"lazyvim/lazyvim",
-- 		opts = {
-- 			colorscheme = "onedark",
-- 		},
-- 	},
--
-- 	-- настройка самой темы gruvbox
-- 	{
-- 		"navarasu/onedark.nvim",
-- 		priority = 1000, -- загружаем тему первой
-- 		config = function()
-- 			require("onedark").setup({
-- 				style = "darker",
-- 				transparent = true, -- включает прозрачность для базовых элементов
-- 			})
-- 		end,
-- 	},
-- }
