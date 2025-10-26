local map = require("utils.keymap").safe_set

local tr_ok, trb = pcall(require, "trouble")

if tr_ok then
  map("n", "<leader>xx", function() trb.toggle() end, "Toggle Trouble Window")
  map("n", "<leader>xw", function() trb.toggle("workspace_diagnostics") end, "Trouble Workspace Diagnostics")
  map("n", "<leader>xd", function() trb.toggle("document_diagnostics") end, "Trouble Document Diagnostics")
  map("n", "<leader>xq", function() trb.toggle("quickfix") end, "Trouble quickfix")
  map("n", "<leader>xl", function() trb.toggle("loclist") end, "Trouble loclist")
  map("n", "gR", function() trb.toggle("lsp_references") end, "LSP Reference")
end