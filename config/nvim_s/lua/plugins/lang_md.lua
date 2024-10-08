return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
      "BufReadPre " .. vim.fn.expand "~" .. "/Syncthing/Obsidian/Tangerine/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Syncthing/Obsidian/Tangerine/*.md",
      "BufReadPre " .. vim.fn.expand "~" .. "/Syncthing/Obsidian/Tangerine/*/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Syncthing/Obsidian/Tangerine/*/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Tangerine",
          path = "~/Syncthing/Obsidian/Tangerine",
        },
      },
      use_advanced_uri = true,
      ui = { enable = false },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      indent = {
        enabled = true,
      },
      bullet = {
        left_pad = 1,
        right_pad = 1,
      }
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
}
