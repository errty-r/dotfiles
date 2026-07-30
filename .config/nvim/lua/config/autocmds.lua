-------------------------------------------------------
-- C#
-------------------------------------------------------

vim.api.nvim_create_autocmd("BufWritePre", {

	pattern = "*.cs",

	callback = function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				only = {
					"source.organizeImports",
				},
			},
		})

		vim.lsp.buf.format()
	end,
})

vim.diagnostic.config({

	virtual_text = {
		spacing = 2,
		prefix = "●",
	},

	underline = true,

	severity_sort = true,

	float = {
		border = "rounded",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		pcall(function()
			vim.lsp.inlay_hint.enable(true, {
				bufnr = args.buf,
			})
		end)
	end,
})

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
