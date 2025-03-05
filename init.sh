# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/init.sh | sh
sudo apt update
sudo apt install git-all
curl https://sh.rustup.rs -sSf | sh
curl -LsSf https://astral.sh/uv/install.sh | sh
sudo apt install software-properties-common
sudo apt update
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
