-- safe_colorscheme checks if the colorscheme exists either as lua
-- or with vim, if not it returns "default" colorscheme
local function safe_colorscheme(name, opts)
  local ok, mod = pcall(require, name)
  if ok then
    mod.setup(opts)
    return name
  end

  local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
  if vim_ok then
    return name
  end

  return "default"
end

--- noop function
local function noop()
  print("NOOP")
end

--- safely set keymap
local function safe_keymap_set(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  local modes = type(mode) == "string" and { mode } or mode

  ---@param m string
  modes = vim.tbl_filter(function(m)
    return not (keys.have and keys:have(lhs, m))
  end, modes)

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 and type(opts) ~= "string" then
    opts = opts or {}
    opts.silent = opts.silent ~= false

    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end

    vim.keymap.set(modes, lhs, rhs, opts)
  else
    vim.keymap.set(modes, lhs, rhs, { silent = true, desc = opts })
  end
end



local fns = {}

--- close_buffers
local ok, close_buffers = pcall(require, "close_buffers")
if ok then
  fns.delete_this = function()
    close_buffers.delete({ type = "this" })
  end
  fns.delete_all = function()
    close_buffers.delete({ type = "all", force = true })
  end
  fns.delete_others = function()
    close_buffers.delete({ type = "other", force = true })
  end
else
  fns.delete_this = function()
    vim.cmd.bdelete()
  end
  fns.delete_all = noop
  fns.delete_others = noop
end


--- colorscheme utility
fns.colorscheme = function(name, opts)
  return safe_colorscheme(name, opts)
end

--- keymapping utility
fns.map = function(mode, lhs, rhs, opts)
  safe_keymap_set(mode, lhs, rhs, opts)
end

fns.safe_map = function(mode, lhs, rhs, opts)
  safe_keymap_set(mode, lhs, rhs, opts)
end

fns.lsp_on_attach = function(client, bufnr)
  local keymaps = require("core.keymaps").lsp_keymaps

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  -- Attach and configure vim-illuminate
  require("illuminate").on_attach(client)

  keymaps(bufnr)
end

return fns
