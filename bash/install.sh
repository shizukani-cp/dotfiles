#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/bash/install.sh | bash
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
mkdir ~/.config/helix/
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/helix/config.toml > ~/.config/helix/config.toml
curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/helix/language.toml > ~/.config/helix/language.toml
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
