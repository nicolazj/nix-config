local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Tokyo Night'

-- config.font = wezterm.font 'VictorMono Nerd Font Mono'
config.font_size = 14

config.window_decorations = "RESIZE"

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false






return config