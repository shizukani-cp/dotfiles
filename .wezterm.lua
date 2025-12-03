local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Ubuntu'
config.font_size = 16

if not config.keys then
    config.keys = {}
end

local ctrl_slash_key = {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SendString('\x1f'),
}

table.insert(config.keys, ctrl_slash_key)

config.font = wezterm.font 'BitstromWera Nerd Font Mono'

return config
