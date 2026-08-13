local function transparent_everything()
	vim.schedule(function()
		local groups = {
			-- Базовый интерфейс
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"FloatTitle",
			"SignColumn",
			"LineNr",
			"CursorLineNr",
			"EndOfBuffer",

			-- Панели и статусбары
			"StatusLine",
			"StatusLineNC",
			"WinSeparator",
			"VertSplit",

			-- Дерево файлов (Neo-tree / NvimTree)
			"NeoTreeNormal",
			"NeoTreeNormalNC",
			"NeoTreeWinSeparator",
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"NvimTreeWinSeparator",

			-- Телескоп (Telescope) — окна поиска
			"TelescopeNormal",
			"TelescopeBorder",
			"TelescopePromptBorder",
			"TelescopeResultsBorder",
			"TelescopePreviewBorder",

			-- Окна автодополнения (Blink / Cmp)
			"BlinkCmpMenu",
			"BlinkCmpMenuBorder",
			"BlinkCmpDoc",
			"BlinkCmpDocBorder",
			"BlinkCmpSignature",
			"BlinkCmpSignatureBorder",
			"Pmenu",
			"PmenuSel",
			"PmenuSbar",
			"PmenuThumb",

			-- Окна диагностики (ошибки, предупреждения LSP)
			"DiagnosticFloatingError",
			"DiagnosticFloatingWarn",
			"DiagnosticFloatingInfo",
			"DiagnosticFloatingHint",
			"DiagnosticSignError",
			"DiagnosticSignWarn",
			"DiagnosticSignInfo",
			"DiagnosticSignHint",

			-- Какие-либо другие плавающие окна (WhichKey, Noice и т.д.)
			"WhichKeyBorder",
			"NoiceFormat",
			"NoiceLspProgress",
		}

		for _, group in ipairs(groups) do
			if vim.fn.hlexists(group) == 1 then
				vim.cmd(string.format("hi %s guibg=NONE ctermbg=NONE", group))
			end
		end
	end)
end
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
	end,
})

-- применить сразу при запуске
vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
-- Применяем при старте Neovim и при каждой смене темы
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	pattern = "*",
	callback = transparent_everything,
})

-- Функция для поиска файла .sln или .csproj вверх по дереву папок
local function find_dotnet_solution()
	local current_dir = vim.fn.expand("%:p:h")
	-- Ищем сначала .sln, если нет — .csproj
	local sln = vim.fs.find(function(name, _)
		return name:match("%.sln$")
	end, { upward = true, path = current_dir, limit = 1 })[1]

	if sln then
		return sln
	end

	local csproj = vim.fs.find(function(name, _)
		return name:match("%.csproj$")
	end, { upward = true, path = current_dir, limit = 1 })[1]

	return csproj
end

-- =========================================================================
-- 1. Команда для ОДНОГО файла (<leader>cj)
-- =========================================================================
vim.api.nvim_create_user_command("DotnetCleanupFile", function()
	local current_file = vim.fn.expand("%:p")

	if current_file == "" or vim.bo.filetype ~= "cs" then
		vim.notify("Открыть должен быть именно C# файл!", vim.log.levels.WARN)
		return
	end

	vim.notify("JetBrains CleanupCode: очистка текущего файла...", vim.log.levels.INFO)

	-- Запуск утилиты асинхронно
	vim.fn.jobstart({ "jb", "cleanupcode", "--include=" .. current_file, current_file }, {
		stdout_buffered = true,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.cmd("checktime") -- Обновляем файл в редакторе
				vim.notify("JetBrains CleanupCode: файл успешно очищен!", vim.log.levels.INFO)
			else
				vim.notify("JetBrains CleanupCode: ошибка при очистке файла", vim.log.levels.ERROR)
			end
		end,
	})
end, {})

-- =========================================================================
-- 2. Команда для ВСЕГО проекта/решения (<leader>cJ)
-- =========================================================================
vim.api.nvim_create_user_command("DotnetCleanupProject", function()
	local target = find_dotnet_solution()

	if not target then
		vim.notify(
			"Не удалось найти файл .sln или .csproj для этого проекта!",
			vim.log.levels.ERROR
		)
		return
	end

	-- Получаем только имя файла для красивого уведомления
	local target_name = vim.fn.fnamemodify(target, ":t")
	vim.notify(
		"JetBrains CleanupCode: запуск очистки для " .. target_name .. "...",
		vim.log.levels.INFO
	)

	-- Запускаем для всего решения/проекта
	vim.fn.jobstart({ "jb", "cleanupcode", target }, {
		stdout_buffered = true,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.cmd("checktime") -- Обновляем все открытые файлы, если они изменились
				vim.notify(
					"JetBrains CleanupCode: проект " .. target_name .. " полностью очищен!",
					vim.log.levels.INFO
				)
			else
				vim.notify(
					"JetBrains CleanupCode: ошибка при очистке проекта",
					vim.log.levels.ERROR
				)
			end
		end,
	})
end, {})

-- =========================================================================
-- 3. Привязка горячих клавиш (Keymaps)
-- =========================================================================
vim.keymap.set("n", "<leader>cj", "<cmd>DotnetCleanupFile<cr>", { desc = "JetBrains Cleanup File" })
vim.keymap.set("n", "<leader>cJ", "<cmd>DotnetCleanupProject<cr>", { desc = "JetBrains Cleanup Entire Project" })
