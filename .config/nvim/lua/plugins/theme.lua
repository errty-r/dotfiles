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
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			theme = "wave",
			overrides = function(colors)
				local theme = colors.theme
				theme.ui.bg = "NONE"
				theme.ui.bg_gutter = "NONE"
				theme.ui.bg_m1 = "NONE"
				theme.ui.bg_m2 = "NONE"
				theme.ui.bg_m3 = "NONE"
				theme.ui.bg_p1 = "NONE"
				theme.ui.bg_p2 = "NONE"
				theme.ui.bg_p3 = "NONE"
				theme.ui.float.bg = "NONE"
				theme.ui.float.bg_border = "NONE"

				return {
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					FloatTitle = { bg = "NONE" },
					NormalNC = { bg = "NONE" },

					LineNr = { bg = "NONE" },
					CursorLineNr = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
					FoldColumn = { bg = "NONE" },

					-- Фикс для Noice Cmdline (внутри Kanagawa)
					NoiceCmdline = { bg = "NONE" },
					NoiceCmdlinePopup = { bg = "NONE" },
					NoiceCmdlinePopupBorder = { bg = "NONE" },
					NoiceCmdlinePrompt = { bg = "NONE" },

					-- Телескоп
					TelescopeNormal = { bg = "NONE" },
					TelescopeBorder = { bg = "NONE" },
					TelescopePromptNormal = { bg = "NONE" },
					TelescopePromptBorder = { bg = "NONE" },
				}
			end,
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
			colorscheme = "kanagawa",
		},
	},
}
