-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local map = require("helpers.helpers").map

-- example --
-- keymap("n", "<C-l>", "<C-w>l", "some configuration reason")


-- Quick access to some common actions
map("n", "<leader>fw", "<cmd>w<cr>", "Write")
map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>dw", "<cmd>close<cr>", "Window")


-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")


-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")


-- Better window navigation
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })

map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")


-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")


-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", "resize up with ctrl + up arrow")
map("n", "<C-Down>", ":resize -2<CR>", "resize down with ctrl + down arrow")
map("n", "<C-Left>", ":vertical resize +2<CR>", "resize left with ctrl + left arrow")
map("n", "<C-Right>", ":vertical resize -2<CR>", "resize right with ctrl + right arrow")


-- Deleting buffers
local h = require("helpers.helpers")

map("n", "<leader>db", h.delete_this, "Current buffer")
map("n", "<leader>do", h.delete_others, "Other buffers")
map("n", "<leader>da", h.delete_all, "All buffers")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", "next buffer")
map("n", "<S-h>", ":bprevious<CR>", "previous buffer")

-- Stay in indent mode
map("v", "<", "<gv", "left indent")
map("v", ">", ">gv", "right indent")


-- Switch between light and dark modes
map("n", "<leader>ut", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, "Toggle between light and dark themes")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- PLUGINS Keymap
--------------------------------------------------------------------------------
--- Trouble
local tr_ok, trb = pcall(require, "trouble")
if tr_ok then
  map("n", "<leader>xx", function() trb.toggle() end, "Toggle Trouble Window")
  map("n", "<leader>xw", function() trb.toggle("workspace_diagnostics") end, "Trouble Workspace Diagnostics")
  map("n", "<leader>xd", function() trb.toggle("document_diagnostics") end, "Trouble Document Diagnostics")
  map("n", "<leader>xq", function() trb.toggle("quickfix") end, "Trouble quickfix")
  map("n", "<leader>xl", function() trb.toggle("loclist") end, "Trouble loclist")
  map("n", "gR", function() trb.toggle("lsp_references") end, "LSP Reference")
end

--- Telescope
local ts_ok, tsc = pcall(require, "telescope.builtin")
if ts_ok then
  map("n", "<leader><space>", tsc.find_files, "Find Files")
  map("n", "<leader>sf", tsc.find_files, "Find Files")
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

--- Neotree 
local nt_ok, _ = pcall(require, "neo-tree")
if nt_ok then
  map({"n", "v"}, "<leader>ue", "<cmd>Neotree toggle left<cr>", "[UI] Toggle File Explorer")
  map({"n", "v"}, "<leader>ub", "<cmd> Neotree toggle show buffers left<cr>", "[UI] Toggle Buffer Explorer")
  map({"n", "v"}, "<leader>ug", "<cmd> Neotree toggle show git_status left<cr>", "[UI] Toggle Git Status Explorer")
end

--- Whichkeys
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  map({"n", "v"}, "<leader>?", function() wk.show({global = false}) end, "Buffer Local Keymaps (which-key)")
end

--- Mason
local m_ok, _ = pcall(require, "mason")
if m_ok then
  map({"n", "v"}, "<leader>M", "<cmd>Mason<cr>", "Show Mason")
end

--- Outline
local ot_ok, _ = pcall(require, "outline")
if ot_ok then
  map("n", "<leader>uo", "<cmd>Outline<cr>", "Toggle Outline")
end

local lg_ok, _ = pcall(require, "lazygit")
if lg_ok then
  map({"n", "v"}, "<leader>gg", "<cmd>LazyGit<cr>", "LazyGit")
end



return {
  -- LSP Keymap, only used when LSP gets attached to the File
  lsp_keymaps = function(bufnr)
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
}
