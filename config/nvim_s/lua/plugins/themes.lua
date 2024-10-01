return {
    -- syncs terminal background and cursor with any neovim colorscheme
    { "EdenEast/nightfox.nvim" },
    { "sainnhe/everforest" },
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        opts = {
            styles = {
                comments = {
                    italic = false
                },
            },
            plugins = {
                "neogit",
                "neo-tree",
                "nvim-cmp",
                "telescope",
                "trouble",
                "which-key",
            },
            lualine_style = "stealth",
        },
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                -- Your config here
                background = "hard",
                transparent_background_level = 0,
                italics = false,
                disable_italic_comments = true,
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "dawn",
            styles = {
                italic = false,
            },
        }
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1001,
        opts = {
            no_italic = true,
            no_underline = true,
        }
    },
    {
        "Shatur/neovim-ayu",
        name = "ayu",
        priority = 1002,
        opts = {
            mirage = false,
            terminal = true,
            overrides = {},
        },
    },
}
