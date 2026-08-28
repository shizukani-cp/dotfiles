leader = "k"

config.unbind(f'{leader}')
config.bind(f'{leader}t', 'open -t https://translate.google.com/translate?sl=auto&tl=ja&u={url}')
config.bind(f'{leader}d', 'config-cycle colors.webpage.darkmode.enabled')
config.bind(f'{leader}2', 'jseval document.querySelector("video").playbackRate = 2.0')
config.bind(f'{leader}1', 'jseval document.querySelector("video").playbackRate = 1.0')
config.bind('<Shift-Down>', 'tab-next')
config.bind('<Shift-Up>', 'tab-prev')

darkmode_disables = ( "https://discord.com/", "http://localhost:3000/", "https://docs.google.com/", )
for s in darkmode_disables:
    config.set('colors.webpage.darkmode.enabled', False, s + "*")
for i in range(1, 10):
    config.bind(f'<Ctrl-{i}>', f'tab-focus {i}')

import os
local_script = os.path.expanduser('~/.config/qutebrowser/local_config.py')
if os.path.exists(local_script):
    config.source(local_script)
