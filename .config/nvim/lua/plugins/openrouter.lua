return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Настройка встроенного инлайн-автодополнения / рефакторинга
      inline = {
        adapter = "openrouter",
      },
      -- Настройка обычного чата по коду
      chat = {
        adapter = "openrouter",
      },
    },
    adapters = {
      openrouter = function()
        return require("codecompanion.adapters").extend("openai", {
          name = "openrouter",
          url = "https://openrouter.ai",
          env = {
            api_key = "OPENROUTER_API_KEY",
          },
          schema = {
            model = {
              -- Бесплатная умная модель, автоматически выбираемая из доступных
              default = "openrouter/free",
            },
          },
        })
      end,
    },
  },
}
