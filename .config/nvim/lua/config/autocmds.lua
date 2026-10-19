local function make_cmdline_transparent()
	local groups = {
		-- Noice cmdline
		"NoiceCmdline",
		"NoiceCmdlinePopup",
		"NoiceCmdlinePopupBorder",
		"NoiceCmdlinePopupTitle",
		"NoiceCmdlinePrompt",
		"NoiceCmdlineIcon",

		-- Разные режимы командной строки
		"NoiceCmdlineIconSearch",
		"NoiceCmdlineIconFilter",
		"NoiceCmdlineIconCmdline",
		"NoiceCmdlineIconLua",
		"NoiceCmdlineIconHelp",
		"NoiceCmdlineIconInput",
		"NoiceCmdlineIconCalculator",

		-- Базовые группы окон
		"NormalFloat",
		"FloatBorder",
		"FloatTitle",
		"Pmenu",
	}

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, {
			bg = "NONE",
		})
	end
end

local group = vim.api.nvim_create_augroup("TransparentCmdline", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = function()
		vim.schedule(make_cmdline_transparent)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.schedule(make_cmdline_transparent)
	end,
})

-- Повторно применяем после загрузки плагинов
vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "VeryLazy",
	callback = function()
		vim.schedule(make_cmdline_transparent)
	end,
})

local function fix_noice_transparency()
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"MsgArea",
		"NoiceCmdline",
		"NoiceCmdlinePopup",
		"NoiceCmdlinePopupBorder",
		"FloatBorder",

		-- Иконка > в командной строке Noice
		"NoiceCmdlineIcon",
		"NoiceCmdlineIconCmdline",

		-- Иконки других режимов cmdline
		"NoiceCmdlineIconSearch",
		"NoiceCmdlineIconFilter",
		"NoiceCmdlineIconLua",
		"NoiceCmdlineIconHelp",
		"NoiceCmdlineIconInput",
		"NoiceCmdlineIconCalculator",

		-- Группа, от которой может наследоваться фон
		"DiagnosticSignInfo",
	}

	for _, name in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, {
			name = name,
			link = false,
		})

		-- Сохраняем fg и остальные атрибуты, меняем только фон
		hl.bg = "NONE"
		hl.ctermbg = "NONE"

		vim.api.nvim_set_hl(0, name, hl)
	end
end

local group = vim.api.nvim_create_augroup("KanagawaNoiceTransparency", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = function()
		vim.schedule(fix_noice_transparency)
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "VeryLazy",
	callback = function()
		vim.schedule(fix_noice_transparency)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.schedule(fix_noice_transparency)
	end,
})

vim.schedule(fix_noice_transparency)
