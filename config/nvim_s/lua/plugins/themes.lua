return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,        -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,     -- make sure to load this before all the other start plugins
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
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1001,
    config = function()
      require('vscode').setup({
        italic_comments = false,
      })
    end
  },
}
