local map = require("utils.keymap").safe_set

--- Telescope
local ts_ok, tsc = pcall(require, "telescope.builtin")
if ts_ok then
  map("n", "<leader>ss", function() require("telescope").extensions.smart_open.smart_open() end, "Smart Open")
  map("n", "<leader>sf", tsc.find_files, "Find Files")
  map("n", "<leader><leader>", tsc.find_files, "Find Files")
  map("n", "<leader>sb", tsc.buffers, "Open buffers")
  map("n", "<leader>sg", tsc.live_grep, "Search by Grep")
  map("n", "<leader>sc", tsc.commands, "Search Commands")
  map("n", "<leader>sh", tsc.help_tags, "Search Help Tags")
  map("n", "<leader>sw", tsc.grep_string, "Current word")
  map("n", "<leader>sd", tsc.diagnostics, "Diagnostics")
  map("n", "<leader>sk", tsc.keymaps, "Search keymaps")
  map("n", "<leader>sm", tsc.marks, "Marks")

  -- in file/buffer lookup of term
  -- similar to `ctrl+f` of vscode/sublime-text
  local tt_ok, tscth = pcall(require, "telescope.themes")
  if tt_ok then
    map("n", "<leader>/", function()
      tsc.current_buffer_fuzzy_find(
        tscth.get_dropdown({
          winblend = 10,
          previewer = false,
        }))
    end, "Search in current buffer")
  end
end