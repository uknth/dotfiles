local on_attach = function(client, bufnr)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(
    bufnr, 
    "Format", 
    function(_)
        vim.lsp.buf.format()
    end, 
    { desc = "Format current buffer with LSP" }
  )

  -- Attach and configure vim-illuminate
  require("illuminate").on_attach(client)
  -- Bind the keymap
  require("keymaps.lsp").keymaps(bufnr)
end

return {
  "on_attach" == on_attach
}