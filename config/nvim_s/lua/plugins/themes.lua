return {
    -- syncs terminal background and cursor with any neovim colorscheme
    { "typicode/bg.nvim",      lazy = false },
    { "EdenEast/nightfox.nvim" },
    { "sainnhe/everforest" },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "dawn",
            styles = {
                italic = false,
            },
        }
    }
}
