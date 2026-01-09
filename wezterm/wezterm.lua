local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'main', '-c', wezterm.home_dir .. "/scratch/" }
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true

config.keys = require('keybinds').keys
config.key_tables = require('keybinds').key_tables
config.disable_default_key_bindings = true

config.font = wezterm.font_with_fallback({
    'BitstromWera Nerd Font Mono',
    'Noto Sans CJK JP', --Japanese
})

wezterm.on('window-config-reloaded', function(window, pane)
    window:maximize()
end)

return config
