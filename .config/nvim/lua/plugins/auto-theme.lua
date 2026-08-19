return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1500, -- проверка системной темы каждые 1500 мс (1.5 секунда)
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme gruvbox")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme gruvbox")
			end,
		},
	},
}

-- return {
-- 	{
-- 		"f-person/auto-dark-mode.nvim",
-- 		opts = {
-- 			update_interval = 1500, -- проверка системной темы каждые 1500 мс (1.5 секунда)
-- 			set_dark_mode = function()
-- 				vim.api.nvim_set_option_value("background", "dark", {})
-- 				vim.cmd("colorscheme onedark")
-- 			end,
-- 			set_light_mode = function()
-- 				vim.api.nvim_set_option_value("background", "light", {})
-- 				vim.cmd("colorscheme onedark")
-- 			end,
-- 		},
-- 	},
-- }
