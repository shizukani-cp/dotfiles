#!/usr/bin/bash
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | bash
curl https://sh.rustup.rs -sSf | sh -s -- -y # rustup
curl -LsSf https://astral.sh/uv/install.sh | sh # uv
curl -fsSL https://bun.sh/install | bash # bun

sudo apt-get update
sudo apt-get install git-all -y # git
sudo apt-get install build-essential -y # gcc and other
sudo apt-get install gdb -y # gdb
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash # nvm
nvm install --lts --latest-npm # node.js latest lts & latest npm
nvm use --lts
sudo apt-get install ripgrep -y # ripgrep
sudo apt-get install fd-find -y # fd
npm install -g @google/gemini-cli # gemini-cli
npm install -g gemistat # gemistat
uv tool install debugpy # debugpy
sudo snap install nvim --classic

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh # oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
sudo apt-get install -y unzip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

git clone https://github.com/shizukani-cp/dotfiles.git ~/.cache/dotfiles
cp ~/.cache/dotfiles/bash/my-theme.omp.json ~/.poshthemes/my-theme.omp.json

cp ~/.cache/dotfiles/bash/.shfunc ~/.shfunc
cp -r ~/.cache/dotfiles/neovim/ ~/.config/nvim/

mkdir ~/.diary
git clone https://github.com/shizukani-cp/diary.git ~/.diary

rm -rf ~/.cache/dotfiles/

echo '. "$HOME/.shfunc"' >> ~/.bashrc
mkdir ~/.Trash/
