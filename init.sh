#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/init.sh | bash
curl https://sh.rustup.rs -sSf | sh -s -- -y # rustup
curl -LsSf https://astral.sh/uv/install.sh | sh # uv
. "$HOME/.cargo/env"
sudo apt-get update
sudo apt-get install git-all -y # git
sudo apt-get install build-essential -y # gcc and other
sudo apt-get update
echo | sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt-get update
sudo apt-get install -y helix
