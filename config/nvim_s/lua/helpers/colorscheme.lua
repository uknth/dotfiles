-- Fetch and setup colorscheme if available, otherwise just return 'default'
-- This should prevent Neovim from complaining about missing colorschemes on first boot
local function get_if_available(name, opts)
    local lua_ok, colorscheme = pcall(require, name)
    if lua_ok then
        colorscheme.setup(opts)
        return name
    end

    local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
    if vim_ok then
        return name
    end

    return "default"
end

-- Uncomment the colorscheme to use
-- local colorscheme = get_if_available("catppuccin-latte")
-- local colorscheme = get_if_available('gruvbox')
-- local colorscheme = get_if_available('rose-pine')
-- local colorscheme = get_if_available('melange')
-- local colorscheme = get_if_available('dayfox')
-- local colorscheme = get_if_available('catppuccin-mocha')
-- local colorscheme = get_if_available('catppuccin-latte')
local colorscheme = get_if_available('github_light_high_contrast')
-- local colorscheme = get_if_available('github_dark_high_contrast')
-- local colorscheme = get_if_available('ayu-dark')
-- local colorscheme = get_if_available('material')

return colorscheme
