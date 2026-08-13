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
