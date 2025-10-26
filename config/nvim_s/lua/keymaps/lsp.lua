local map = require("utils.keymap").safe_set

local keymaps = function(bufnr)
    map("n", "<leader>lr", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "Rename symbol" })
    map("n", "<leader>la", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code action" })
    map("n", "<leader>ld", vim.lsp.buf.type_definition, { silent = true, buffer = bufnr, desc = "Type definition" })

    map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = bufnr, desc = "Goto Definition" })
    map("n", "gI", vim.lsp.buf.implementation, { silent = true, buffer = bufnr, desc = "Goto Implementation" })
    map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "Hover Documentation" })
    map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "Goto Declaration" })

    map("n", "<leader>ff", "<cmd>Format<cr>", { silent = true, buffer = bufnr, desc = "Format" })

    local ok, ttsc = pcall(require, "telescope.builtin")
    if ok then
        map("n", "<leader>ls", ttsc.lsp_document_symbols,
        { silent = true, buffer = bufnr, desc = "Document symbols" })
        map("n", "gr", ttsc.lsp_references,
        { silent = true, buffer = bufnr, desc = "Goto References" })
    end
end


return {
    "keymaps" = keymaps
}