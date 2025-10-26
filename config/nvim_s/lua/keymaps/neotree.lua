local map = require("utils.keymap").safe_set

--- Neotree
local nt_ok, _ = pcall(require, "neo-tree")
if nt_ok then
  map({ "n", "v" }, "<leader>ue", "<cmd>Neotree toggle left<cr>", "[UI] Toggle File Explorer")
  map({ "n", "v" }, "<leader>ub", "<cmd> Neotree toggle show buffers left<cr>", "[UI] Toggle Buffer Explorer")
  map({ "n", "v" }, "<leader>ug", "<cmd> Neotree toggle show git_status left<cr>", "[UI] Toggle Git Status Explorer")
end
