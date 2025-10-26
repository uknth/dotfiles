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

return {
  colorscheme = safe_colorscheme
}
