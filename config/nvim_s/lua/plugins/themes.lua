return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        styles = {
          comments = 'NONE',
          types = 'bold',
        },
      })
    end,
  },
  {
    'Shatur/neovim-ayu', 
    lazy = false, 
    priority = 1001,
    config = function()
      local colors = require('ayu.colors')
      colors.generate() -- Pass `true` to enable mirage

      require('ayu').setup({
        mirage = false,
        terminal = true,
        overrides = function()
          return { Comment = { fg = colors.comment } }
        end
      })
    end
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1002, -- make sure to load this before all the other start plugins
    config = function()
      require("everforest").setup({
        -- Your config here
        background = "hard",
        disable_italic_comments = true,
        --
      })
    end,
  },
}
