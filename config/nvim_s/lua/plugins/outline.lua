return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
            { "<F8>", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
}
