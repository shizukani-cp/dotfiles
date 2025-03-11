#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/init.sh | bash
read -p '(aarch64 or x86_64)' ARC
read -p 'helix version: ') HX_VER
curl -LsSf https://astral.sh/uv/install.sh | sh # uv
sudo apt-get update
sudo apt-get install git-all # git
curl https://sh.rustup.rs -sSf | sh # rustup
sudo apt-get install build-essential # gcc and other
curl -SsSf "https://github.com/helix-editor/helix/releases/download/$HX_VER/helix-$HX_VER-$ARC-linux.tar.xz" > helix.tar.xz
tar xJf helix.tar.xz -O "helix-$HX_VAR-$ARC-linux/hx" > /usr/bin/hx # helix editor
rm helix.tar.xz
