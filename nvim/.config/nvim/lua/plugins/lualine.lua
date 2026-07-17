return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = {
          normal = {
            a = { bg = "NONE" },
            b = { bg = "NONE" },
            c = { bg = "NONE" },
          },
        },
        globalstatus = true,

        component_separators = {
          left = "│",
          right = "│",
        },

        section_separators = {
          left = "",
          right = "",
        },
      },
    },

    config = function(_, opts)
      require("lualine").setup(opts)

      local transparent = {
        bg = "NONE",
        ctermbg = "NONE",
      }

      -- полностью прозрачный lualine
      for _, group in ipairs({
        "lualine_a_normal",
        "lualine_b_normal",
        "lualine_c_normal",
        "lualine_x_normal",
        "lualine_y_normal",
        "lualine_z_normal",

        "lualine_a_insert",
        "lualine_b_insert",
        "lualine_c_insert",
        "lualine_x_insert",
        "lualine_y_insert",
        "lualine_z_insert",

        "lualine_a_visual",
        "lualine_b_visual",
        "lualine_c_visual",
        "lualine_x_visual",
        "lualine_y_visual",
        "lualine_z_visual",

        "lualine_a_command",
        "lualine_b_command",
        "lualine_c_command",
        "lualine_x_command",
        "lualine_y_command",
        "lualine_z_command",

        "lualine_a_replace",
        "lualine_b_replace",
        "lualine_c_replace",
        "lualine_x_replace",
        "lualine_y_replace",
        "lualine_z_replace",

        "lualine_a_inactive",
        "lualine_b_inactive",
        "lualine_c_inactive",
        "lualine_x_inactive",
        "lualine_y_inactive",
        "lualine_z_inactive",

        "StatusLine",
        "StatusLineNC",
      }) do
        vim.api.nvim_set_hl(0, group, transparent)
      end
    end,
  },
}
