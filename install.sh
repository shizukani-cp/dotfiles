#!/usr/bin/zsh
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | zsh
curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install --determine-intel-64 --no-confirm # nix

sudo nixos-rebuild switch --flake .#shizukani-cp
