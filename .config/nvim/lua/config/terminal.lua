local scheme_file = vim.fn.expand("~/.local/state/caelestia/scheme.json")

local function load_caelestia_terminal_colors()
	local file = io.open(scheme_file, "r")
	if not file then
		return
	end

	local content = file:read("*a")
	file:close()

	local ok, scheme = pcall(vim.json.decode, content)
	if not ok or not scheme or not scheme.colours then
		return
	end

	for i = 0, 15 do
		local color = scheme.colours["term" .. i]
		if color then
			vim.g["terminal_color_" .. i] = "#" .. color
		end
	end
end

load_caelestia_terminal_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = load_caelestia_terminal_colors,
})
