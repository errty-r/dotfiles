local groups = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"SignColumn",
	"LineNr",
	"CursorLineNr",
	"EndOfBuffer",

	"StatusLine",
	"StatusLineNC",
	"WinSeparator",
	"VertSplit",
	"WinBar",
	"WinBarNC",

	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeWinSeparator",

	"NvimTreeNormal",
	"NvimTreeNormalNC",
	"NvimTreeWinSeparator",

	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptBorder",
	"TelescopeResultsBorder",
	"TelescopePreviewBorder",

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

	"DiagnosticFloatingError",
	"DiagnosticFloatingWarn",
	"DiagnosticFloatingInfo",
	"DiagnosticFloatingHint",

	"DiagnosticSignError",
	"DiagnosticSignWarn",
	"DiagnosticSignInfo",
	"DiagnosticSignHint",

	"WhichKeyBorder",
	"NoiceFormat",
	"NoiceLspProgress",
}

local function transparent_everything()
	for _, group in ipairs(groups) do
		if vim.fn.hlexists(group) == 1 then
			vim.api.nvim_set_hl(0, group, {
				bg = "NONE",
				ctermbg = "NONE",
			})
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	callback = transparent_everything,
})
