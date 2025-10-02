-- init functions
local function set_leader(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key
  vim.keymap.set({"n", "v"}, key, "<nop>", { silent = true})
end

-- set leader before we start anything
set_leader(" ")

require("core.lazy")
require("core.autocmd")
require("core.options")
require("core.keymaps")
