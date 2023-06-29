local wezterm = require 'wezterm'

-- Padding for Window 
local padding = {
	left = "0.1cell",
	right = "0.1cell",
	top = "0.1cell",
	bottom = "0.1cell",
}

return {
    color_scheme = 'Tomorrow Night',

    -- Basic Warnings & Configurations
    warn_about_missing_glyphs = false,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = padding,

    -- Fonts 
    font = wezterm.font_with_fallback {
        'CaskaydiaCove Nerd Font',
        'SauceCodePro Nerd Font',
        'JetBrainsMono Nerd Font',
        'UbuntuMono Nerd Font',
    },
    font_size = 12,
    font_dirs = { '/home/uknth/.fonts' },
    line_height = 1.1,


    -- key bindings
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        {
          key = '|',
          mods = 'LEADER|SHIFT',
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = '-',
          mods = 'LEADER',
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'a',
          mods = 'LEADER|CTRL',
          action = wezterm.action.SendString '\x01',
        },
    },

}
