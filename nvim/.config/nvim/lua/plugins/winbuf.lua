return {
  "errty-r/winbuf.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    style = "thin",
  },
  keys = {
    {
      "<S-h>",
      function()
        require("winbuf").cycle(-1)
      end,
      desc = "Prev buffer",
    },
    {
      "<S-l>",
      function()
        require("winbuf").cycle(1)
      end,
      desc = "Next buffer",
    },
    {
      "[b",
      function()
        require("winbuf").cycle(-1)
      end,
      desc = "Prev buffer",
    },
    {
      "]b",
      function()
        require("winbuf").cycle(1)
      end,
      desc = "Next buffer",
    },

    {
      "<A-h>",
      function()
        require("winbuf").move_buf("h")
      end,
      desc = "Move buffer left",
    },
    {
      "<A-l>",
      function()
        require("winbuf").move_buf("l")
      end,
      desc = "Move buffer right",
    },
    {
      "<A-j>",
      function()
        require("winbuf").move_buf("j")
      end,
      desc = "Move buffer down",
    },
    {
      "<A-k>",
      function()
        require("winbuf").move_buf("k")
      end,
      desc = "Move buffer up",
    },

    {
      "<C-w>",
      function()
        require("winbuf").close_buf()
      end,
      desc = "Close buffer (window)",
    },
    {
      "<C-S-w>",
      function()
        require("winbuf").close_split()
      end,
      desc = "Close split",
    },
  },
}
