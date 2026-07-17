return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000, -- проверка системной темы каждые 1000 мс (1 секунда)
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
