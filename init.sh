#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/init.sh | bash
read -p '(aarch64 or x86_64)' ARC
read -p 'helix version: ') HX_VER
sudo apt-get update
sudo apt-get install git-all
curl https://sh.rustup.rs -sSf | sh
curl -LsSf https://astral.sh/uv/install.sh | sh
sudo apt-get install software-properties-common
sudo apt-get install build-essential
curl -SsSf "https://github.com/helix-editor/helix/releases/download/$HX_VER/helix-$HX_VER-$ARC-linux.tar.xz" > helix.tar.xz
tar xJf helix.tar.xz -O "helix-$HX_VAR-$ARC-linux/hx" > /usr/bin/hx
rm helix.tar.xz
