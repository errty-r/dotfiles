vim.opt.tabstop = 4 -- Если файл пустой или новый, по дефолту будет 4
vim.opt.softtabstop = -1 -- Магическое значение! Заставляет softtabstop ВСЕГДА быть равным shiftwidth
vim.opt.shiftwidth = 4 -- Шаг отступа по умолчанию
vim.opt.expandtab = true -- Превращать табы в пробелы

vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.winblend = 0 -- Прозрачность для плавающих окон
vim.opt.pumblend = 0 -- Прозрачность для встроенного всплывающего меню (popup menu)

vim.opt.termguicolors = true

local fish_path = vim.fn.executable("fish") == 1 and "fish" or nil
if fish_path then
	vim.opt.shell = fish_path
end
