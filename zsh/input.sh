#!/bin/bash

FILE_PATH="/tmp/$(date +%Y%m%d%H%M%S).md"

touch "$FILE_PATH"

foot -e $HOME/.nix-profile/bin/nvim "$FILE_PATH"

if [ -f "$FILE_PATH" ]; then
    sleep 0.1
    printf %s "$(cat "$FILE_PATH")" | wl-copy
fi
