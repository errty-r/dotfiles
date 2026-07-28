return {
  "saghen/blink.cmp",

  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      ghost_text = {
        enabled = true,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 150,
        -- Настройка прозрачности для окна документации
        window = {
          border = "rounded",
          winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },

      menu = {
        border = "rounded",
        -- Настройка прозрачности для главного меню подсказок
        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",

        draw = {
          treesitter = { "lsp" },
        },
      },
    },

    signature = {
      enabled = true,
      -- Настройка прозрачности для сигнатур функций
      window = {
        border = "rounded",
        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpSignatureCursorLine,Search:None",
      },
    },

    fuzzy = {
      implementation = "lua",
    },

    keymap = {
      preset = "default",

      ["<Tab>"] = {
        "select_next",
        "fallback",
      },

      ["<S-Tab>"] = {
        "select_prev",
        "fallback",
      },

      ["<CR>"] = {
        "accept",
        "fallback",
      },
    },
  },
}
