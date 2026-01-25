#!/usr/bin/zsh
# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | zsh
curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install --determine-intel-64 --no-confirm # nix

sudo apt-get update

sudo snap install nvim --classic # NeoVim
sudo snap install tetris-thefenriswolf # tetris

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
