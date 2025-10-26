local map = require("utils.keymap").safe_set

--- Whichkeys
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  map({ "n", "v" }, "<leader>?", function() wk.show({ global = false }) end, "Buffer Local Keymaps (which-key)")
end

--- Mason
local m_ok, _ = pcall(require, "mason")
if m_ok then
  map({ "n", "v" }, "<leader>M", "<cmd>Mason<cr>", "Show Mason")
end

--- Outline
local ot_ok, _ = pcall(require, "outline")
if ot_ok then
  map("n", "<leader>uo", "<cmd>Outline<cr>", "Toggle Outline")
end

--- Lazygit
local lg_ok, _ = pcall(require, "lazygit")
if lg_ok then
  map({ "n", "v" }, "<leader>gg", "<cmd>LazyGit<cr>", "LazyGit")
end
