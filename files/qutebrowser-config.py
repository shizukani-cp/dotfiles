LEADER = "k"

config.unbind(f"{LEADER}")
config.bind(f"{LEADER}t", "open -t https://translate.google.com/translate?sl=auto&tl=ja&u={url}")
config.bind(f"{LEADER}d", "config-cycle colors.webpage.darkmode.enabled")
config.bind(f"{LEADER}2", "jseval document.querySelector('video').playbackRate = 2.0")
config.bind(f"{LEADER}1", "jseval document.querySelector('video').playbackRate = 1.0")
config.bind(f"<F25>", "fake-key a")
config.bind(f"<Ctrl-v>", "fake-key <BackSpace> ;; fake-key <Ctrl-v> ;; mode-enter insert")
config.bind("<Shift-Down>", "tab-next")
config.bind("<Shift-Up>", "tab-prev")

config.unbind("f")
config.unbind("F")
config.bind("s", "hint")
config.bind("S", "hint all tab-bg")
config.bind("ff", "save")
config.bind("fk", "cmd-set-text -s :bind")
config.bind("fl", "cmd-set-text -s :set -t")
config.bind("fs", "cmd-set-text -s :set")
config.bind("Fb", "bookmark-list --jump")
config.bind("Fh", "history")
config.bind("Fq", "bookmark-list")
config.bind("Fs", "set")

darkmode_disables = ( "https://discord.com/", "http://localhost:3000/", "https://docs.google.com/", )
for s in darkmode_disables:
    config.set("colors.webpage.darkmode.enabled", False, s + "*")
for i in range(1, 10):
    config.bind(f"<Ctrl-{i}>", f"tab-focus {i}")

import os
local_script = os.path.expanduser("~/.config/qutebrowser/local_config.py")
if os.path.exists(local_script):
    config.source(local_script)
