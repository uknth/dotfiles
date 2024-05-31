return {
    -- syncs terminal background and cursor with any neovim colorscheme
    { "EdenEast/nightfox.nvim" },
    { "sainnhe/everforest" },
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
}
