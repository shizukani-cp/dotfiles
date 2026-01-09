local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'main', '-c', wezterm.home_dir .. "/scratch/" }
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true

local function merge_lists(t1, t2)
    for _, v in ipairs(t2) do table.insert(t1, v) end
    return t1
end

config.keys = config.keys or {}
merge_lists(config.keys, {
    { key = '/', mods = 'CTRL', action = wezterm.action.SendString('\x1f') },
    {
        key = 'T',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.Multiple {
            { SendKey = { key = 'a', mods = 'CTRL' } }, { SendKey = { key = 'c' } }
        }
    },
    {
        key = 'Tab',
        mods = 'CTRL',
        action = wezterm.action.Multiple {
            { SendKey = { key = 'a', mods = 'CTRL' } }, { SendKey = { key = 'n' } }
        }
    },
    {
        key = 'Tab',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.Multiple {
            { SendKey = { key = 'a', mods = 'CTRL' } }, { SendKey = { key = 'p' } }
        }
    },
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.Multiple {
            { SendKey = { key = 'a', mods = 'CTRL' } }, { SendKey = { key = '&' } }
        }
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
