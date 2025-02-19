local wezterm = require("wezterm")

-- Padding for Window
local padding = {
	left = "0.1cell",
	right = "0.1cell",
	top = "0.1cell",
	bottom = "0.1cell",
}

local config = {
	use_fancy_tab_bar = true,

	window_frame = {
		-- active_titlebar_bg = "#fafafa",
		active_titlebar_bg = "#232323",
	},

	colors = {
		tab_bar = {
			inactive_tab_edge = "#232323",
			active_tab = {
				-- The color of the background area for the tab
				bg_color = "#dadada",
				-- The color of the text for the tab
				fg_color = "#010101",
			},

			inactive_tab = {
				bg_color = "#434343",
				fg_color = "#fafafa",
			},
		},
	},

	-- color_scheme = 'Github (base16)',
	-- color_scheme = "GitHub Dark",
    -- color_scheme = "dayfox",
    -- color_scheme = 'Everforest Dark (Gogh)',
    color_scheme = 'Brewer (light) (terminal.sexy)',

	-- Basic Warnings & Configurations
	warn_about_missing_glyphs = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_padding = padding,
	window_decorations = "RESIZE",

	-- Fonts
	font = wezterm.font_with_fallback({
		"CaskaydiaCove Nerd Font Mono",
		"CaskaydiaCove Nerd Font",
		"SauceCodePro Nerd Font",
		"JetBrainsMono Nerd Font",
		"UbuntuMono Nerd Font",
	}),
	font_size = 10,
	font_dirs = { "/home/uknth/.fonts" },
	line_height = 1.1,

	-- key bindings
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "a",
			mods = "LEADER|CTRL",
			action = wezterm.action.SendString("\x01"),
		},
	},
}

config.ssh_domains = {
  	{
    		name = 'workstation-1',
    		remote_address = '100.116.174.84',
    		multiplexing = 'None',
  	},
}

config.default_domain = 'workstation-1'
return config
