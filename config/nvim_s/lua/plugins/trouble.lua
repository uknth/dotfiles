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
}
