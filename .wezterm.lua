local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'main' }
config.default_cwd = wezterm.home_dir .. "/scratch/"
config.use_ime = true
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true

if not config.keys then
    config.keys = {}
end

table.insert(config.keys, {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SendString('\x1f'),
})

table.insert(config.keys, {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.Multiple {
        wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
        wezterm.action.SendKey { key = 'c' },
    },
})

table.insert(config.keys, {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.Multiple {
        wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
        wezterm.action.SendKey { key = 'n' },
    },
})

table.insert(config.keys, {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.Multiple {
        wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
        wezterm.action.SendKey { key = 'p' },
    },
})

config.font = wezterm.font_with_fallback({
    'BitstromWera Nerd Font Mono',
    'Noto Sans CJK JP', --Japanese
})

wezterm.on('window-config-reloaded', function(window, pane)
    window:maximize()
end)

return config
