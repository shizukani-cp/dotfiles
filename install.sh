#!/usr/bin/zsh
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | zsh
curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install --determine-intel-64 --no-confirm # nix

git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd

mkdir ~/.diary
git clone https://github.com/shizukani-cp/diary.git ~/.diary

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
