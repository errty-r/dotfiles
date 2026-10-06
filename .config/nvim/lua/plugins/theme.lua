return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			transparent_mode = true,
		},
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		opts = {
			style = "cool",
			transparent = true,
		},
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			theme = "dragon",
		},
	},
	{
		"ribru17/bamboo.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			style = "vulgaris", -- варианты: 'vulgaris', 'multiplex'
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent = true,
			flavour = "latte", -- latte, frappe, macchiato, mocha
		},
	},
	{
		"craftzdog/solarized-osaka.nvim",
		priority = 1000,
		opts = {
			transparent = true, -- Optional: matches terminal background
		},
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		opts = {
			options = {
				transparent = true, -- Включаем прозрачность
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			},
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			italic_comments = true,
			hide_fillchars = true,
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "onedark",
		},
	},
}
