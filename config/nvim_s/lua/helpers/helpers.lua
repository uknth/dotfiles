-- safe_colorscheme checks if the colorscheme exists either as lua
-- or with vim, if not it returns "default" colorscheme
local function safe_colorscheme(name, opts)
  local ok, mod = pcall(require, name)
  if ok then

    if opts == nil then
      opts = {}
    end

    mod.setup(opts)

    return name
  end

  local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
  if vim_ok then
    return name
  end

  return "default"
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


fns.bufremove = function(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

return fns
