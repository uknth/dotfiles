local map = require("utils.keymap").safe_set

--- Bufferline
local bl_ok, _ = pcall(require, "bufferline")
if bl_ok then
  map("n", "<leader>bd", function() vim.cmd.bdelete() end, "Delete Current Buffer")
  map({ "n", "v" }, "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", "Close Other Buffers")
  map({ "n", "v" }, "<leader>br", "<cmd>BufferLineCloseRight<cr>", "Close Buffers to Right")
  map({ "n", "v" }, "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", "Close Buffers to Left")
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer")
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next Buffer")
end
