-- CONFIGURATIONS
-- vim configurations
local options = {
  shiftwidth = 4,
  tabstop = 4,
  expandtab = true,
  wrap = false,
  termguicolors = true,
  conceallevel = 1,

  -- colorscheme
  background = "dark",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Other Vim Properties
-- make buffer modifiable
vim.cmd.set("ma")
-- set line number
vim.cmd.set("nu")
-- sets line number relative
vim.cmd.set("relativenumber")


-- COLORSCHEME
vim.cmd.colorscheme(
    require("utils.cs").colorscheme("github_light_colorblind")
)
