return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        modes = {
            -- sources define their own modes, which you can use directly,
            -- or override like in the example below
            lsp_references = {
              -- some modes are configurable, see the source code for more details
              params = {
                include_declaration = true,
              },
            },
            -- The LSP base mode for:
            -- * lsp_definitions, lsp_references, lsp_implementations
            -- * lsp_type_definitions, lsp_declarations, lsp_command
            lsp_base = {
              params = {
                -- don't include the current location in the results
                include_current = false,
              },
            },
        },
    },
    keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
