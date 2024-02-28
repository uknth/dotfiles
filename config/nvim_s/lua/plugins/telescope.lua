return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 }
    },
    config = function()
        pcall(require("telescope").load_extension, "fzf")

        local map = require("helpers.keys").map
        -- <space><space> = search in open buffers
        map("n", "<leader><space>", require("telescope.builtin").find_files, "Open buffers")
        map("n", "<leader>b", require("telescope.builtin").buffers, "Open buffers")
        -- <space>/ = search in current buffer
        map("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, "Search in current buffer")
        -- <space>sf = search in files
        map("n", "<leader>sf", require("telescope.builtin").find_files, "Files")

        -- <space>sm = search across 'marks'
        map("n", "<leader>sm", require("telescope.builtin").marks, "Marks")

        -- other useful mappings
        map("n", "<C-p>", require("telescope.builtin").find_files, "Files")
        map("n", "<leader>g", require("telescope.builtin").live_grep, "Grep")
        map("n", "<leader>sc", require("telescope.builtin").commands, "Files")
        map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
        map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
        map("n", "<leader>sg", require("telescope.builtin").live_grep, "Grep")
        map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")
        map("n", "<leader>sk", require("telescope.builtin").keymaps, "Search keymaps")
    end,
}
