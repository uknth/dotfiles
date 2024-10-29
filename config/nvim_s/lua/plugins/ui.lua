-- UI Tweaks
return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      direction = "float",
      float_opts = {
        border = 'curved',
        title_pos = 'left',
      },
      -- Usually all other keymaps are done in
      -- core/keymaps.lua
      -- however, this is one exception to this
      -- as there is no easy way to bind this from
      -- that file
      --
      -- This supports pressing `ctrl + \` for
      -- creating an terminal and closing it
      open_mapping = [[<c-\>]],
      insert_mappings = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end
  },
  -- for buffers to show on top as tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        }
      }
    },
    config = function(_, opts)
      require("bufferline").setup(opts)

      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end
  },
  -- for beautified command, popupmenu & messages
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = {
      --     title = '',
      --     -- view = 'cmdline', -- change to classic
      -- },
      messages = {
        enabled = false
      },
      views = {
        notify = {
          replace = true,
        },
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          -- throttle = 1000 / 30,
          view = "notify",
        },
        -- override markdown rendering so that **cmp** and other plugins use **treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        --     hover = {enabled = false },
        --     signature = { enabled = false },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
      },

      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "muniftanjim/nui.nvim",
      -- optional:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   if not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },

}
