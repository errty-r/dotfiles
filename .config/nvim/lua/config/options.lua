vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- использовать настоящие табы

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
