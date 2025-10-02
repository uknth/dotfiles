return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "danielfalk/smart-open.nvim",               branch = "0.2.x", dependencies = { "kkharji/sqlite.lua" } },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        smart_open = {
          match_algorithm = "fzf",
          disable_devicons = false,
        },
        persisted = {
          layout_config = { width = 0.55, height = 0.55 }
        },
      }
    })

    -- load extension
    local ts = require('telescope')

    ts.load_extension('fzf')
    ts.load_extension("smart_open")

    -- load other extensions
    ts.load_extension('persisted')
  end
}
