#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | bash
curl https://sh.rustup.rs -sSf | sh -s -- -y # rustup
curl -LsSf https://astral.sh/uv/install.sh | sh # uv
. "$HOME/.cargo/env"
sudo apt-get update
sudo apt-get install git-all -y # git
sudo apt-get install build-essential -y # gcc and other
mkdir ~/appimages/
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/appimages/nvim.appimage
chmod a+x ~/appimages/nvim.appimage
mkdir -p ~/.config/nvim/lua/plugins/
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/neovim/init.lua > ~/.config/nvim/init.lua
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/neovim/lua/plugins/lazy.lua > ~/.config/nvim/lua/plugins/lazy.lua
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh # oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
sudo apt-get install -y unzip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/bash/my-theme.omp.json > ~/.poshthemes/my-theme.omp.json
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/bash/.shfunc > ~/.shfunc
echo '. "$HOME/.shfunc"' >> ~/.bashrc
