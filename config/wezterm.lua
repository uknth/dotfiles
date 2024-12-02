local wezterm = require("wezterm")

local config = {
  use_fancy_tab_bar = false,
  enable_wayland = true,

  --
  --[[
  -- Light Frame
	window_frame = {
    inactive_titlebar_bg = "#2a2a2a",
		active_titlebar_bg = "#fafafa",
    active_titlebar_fg = "#070707",
    inactive_titlebar_fg = "#070707",
    active_titlebar_border_bottom = "#282828",
    button_fg = "#222222",
    button_bg = "#bababa",
	},
  ]] --

  window_frame = {
    active_titlebar_bg = "#1a1a1a",
    active_titlebar_fg = "#efefef",
    inactive_titlebar_bg = "#1a1a1a",
    inactive_titlebar_fg = "#afafaf",
  },

  -- Basic Warnings & Configurations
  warn_about_missing_glyphs = false,
  hide_tab_bar_if_only_one_tab = true,
  -- tab_bar_at_bottom = true,
  window_decorations = "TITLE|RESIZE",
  -- freetype_load_flags = "NO_HINTING|NO_BITMAP",

  -- Fonts
  font = wezterm.font_with_fallback({
    "AnonymicePro Nerd Font",
    "M+CodeLat60 Nerd Font Mono",
    "M+1Code Nerd Font Propo",
    "UbuntuMono Nerd Font",
    "JetBrainsMono Nerd Font",
    "CaskaydiaCove Nerd Font",
    "SauceCodePro Nerd Font",
  }),

  font_size = 12,
  font_dirs = { "/home/uknth/.fonts" },
  line_height = 1.15,

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
  audible_bell = "Disabled",
}

local flexoki_light = {
  ansi = {
    "#100F0F",
    "#AF3029",
    "#66800B",
    "#AD8301",
    "#205EA6",
    "#A02F6F",
    "#24837B",
    "#DAD8CE",
  },

  brights = {
    "#B7B5AC",
    "#D14D41",
    "#879A39",
    "#D0A215",
    "#4385BE",
    "#CE5D97",
    "#3AA99F",
    "#E6E4D9",
  },

  foreground = "#100F0F",
  background = "#FFFCF0",

  cursor_bg = "#403E3C",
  cursor_border = "#403E3C",
  cursor_fg = "#FFFCF0",

  selection_fg = "#100F0F",
  selection_bg = "#E6E4D9",
}

local flexoki_dark = {
  ansi = {
    "#100F0F",
    "#AF3029",
    "#66800B",
    "#AD8301",
    "#205EA6",
    "#5E409D",
    "#24837B",
    "#CECDC3",
  },
  brights = {
    "#575653",
    "#D14D41",
    "#879A39",
    "#D0A215",
    "#4385BE",
    "#8B7EC8",
    "#3AA99F",
    "#FFFCF0",
  },

  foreground = "#CECDC3",
  background = "#100F0F",

  cursor_bg = "#CECDC3",
  cursor_border = "#CECDC3",
  cursor_fg = "#100F0F",
  selection_bg = "#282726",
  selection_fg = "#CECDC3",
}

local default_colors = {
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
}

-- config.color_scheme = "Nightfly (Gogh)"
-- config.color_scheme = "Moonfly (Gogh)"
config.color_scheme = "Github (base16)"
-- config.color_scheme = 'flexoki-light'
-- config.color_scheme = "Github Light (Gogh)"
-- config.color_scheme = "Github Dark (base16)"
-- config.color_scheme = 'PencilLight'
-- config.color_scheme = 'Everforest Dark (Gogh)'
-- config.color_scheme = '3024 Day (Gogh)'
-- config.color_scheme = 'Brewer (light) (terminal.sexy)'
-- config.color_scheme = 'Classic Light (base16)'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Eighties (light) (terminal.sexy)'
-- config.color_scheme = 'Catppuccin Latte'
-- config.color_scheme = "Vs Code Light+ (Gogh)"
-- config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "ayu"
-- config.color_scheme = "Github Light (base16)"
--
config.colors = default_colors

return config
