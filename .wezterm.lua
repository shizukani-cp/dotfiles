local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.font_size = 16
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

if not config.keys then
    config.keys = {}
end

local ctrl_slash_key = {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SendString('\x1f'),
}

table.insert(config.keys, ctrl_slash_key)

config.font = wezterm.font_with_fallback({
    'BitstromWera Nerd Font Mono',
    'Noto Sans CJK JP', --Japanese
})

config.use_ime = true
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
    tab_bar = {
        inactive_tab_edge = "none",
    },
}
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#5c6d74"
    local foreground = "#FFFFFF"
    local edge_background = "none"


    if tab.is_active then
        background = "#ae8b2d"
        foreground = "#FFFFFF"
    end
    local edge_foreground = background

    local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

return config
