return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      local opts = {
        preset = "modern",
        delay = 800,
        sort = { "manual", "order", "group", "loacal" },
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true,    -- misc bindings to work with windows
            z = true,      -- bindings for folds, spelling and others prefixed with z
            g = true,      -- bindings for prefixed with g
          },
        }
      }

      wk.setup(opts)

      wk.add({ "<leader>f", group = "File", icon = ""})
      wk.add({ "<leader>t", group = "Terminal", icon = ""})
      wk.add({ "<leader>u", group = "UI", icon = ""})
      wk.add({ "<leader>s", group = "Search", icon = ""})
      wk.add({ "<leader>l", group = "LSP", icon = "" })
      wk.add({ "<leader>x", group = "Trouble", icon = "󰃤"})
      wk.add({ "<leader>d", group = "Delete", icon = "󰆴"})
      wk.add({ "<leader>q", group = "Quit/Close", icon = "󰅗" })
      wk.add({
        { "<leader>w", proxy = "<c-w>", group = "Windows", icon = ""},
      })
    end,
  }
}
