-- vim properties
--
local options = {
  shiftwidth = 4,
  tabstop = 4,
  expandtab = true,
  wrap = false,
  termguicolors = true,
  conceallevel = 1,
  -- colorscheme related
  background = "dark",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- make buffer modifiable
vim.cmd.set("ma")

-- set line number
vim.cmd.set("nu")
vim.cmd.set("relativenumber")

vim.cmd.colorscheme(
  require("helpers.helpers").colorscheme("everforest")
)
