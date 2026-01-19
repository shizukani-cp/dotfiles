#!/usr/bin/zsh
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | zsh
curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install --determine-intel-64 --no-confirm # nix

sudo apt-get update
sudo apt-get install zsh -y # zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y # rustup
curl -LsSf https://astral.sh/uv/install.sh | sh # uv
curl -fsSL https://deno.land/install.sh | sh # deno

sudo apt-get install git-all -y # git
sudo apt-get install build-essential -y # gcc and other
sudo apt-get install gdb -y # gdb
sudo apt-get install bat -y # bat
sudo apt-get install tmux -y #tmux
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh # nvm
nvm install --lts --latest-npm # node.js latest lts & latest npm
nvm use --lts
sudo apt-get install ripgrep -y # ripgrep
sudo apt-get install fd-find -y # fd
npm install -g @google/gemini-cli # gemini-cli
uv tool install debugpy # debugpy
sudo snap install nvim --classic # NeoVim
sudo snap install gh # GitHub CLI
sudo snap install tetris-thefenriswolf # tetris
sudo snap install bottom # bottom

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh # oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
sudo apt-get install -y unzip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

git clone https://github.com/shizukani-cp/dotfiles.git ~/.cache/dotfiles
cp ~/.cache/dotfiles/zsh/my-theme.omp.json ~/.poshthemes/my-theme.omp.json

cp ~/.cache/dotfiles/zsh/.shfunc ~/.config/zsh/.shfunc
cp ~/.cache/dotfiles/zsh/.shopts ~/.config/zsh/.shopts
cp -r ~/.cache/dotfiles/neovim/ ~/.config/nvim/

mkdir ~/.diary
git clone https://github.com/shizukani-cp/diary.git ~/.diary

rm -rf ~/.cache/dotfiles/

echo '. "$HOME/.shfunc"' >> ~/.zshrc
echo '. "$HOME/.shopts"' >> ~/.zshrc
mkdir ~/.Trash/

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
