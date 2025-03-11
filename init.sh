# curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/init.sh | sh
sudo apt-get update
sudo apt-get install git-all
curl https://sh.rustup.rs -sSf | sh
curl -LsSf https://astral.sh/uv/install.sh | sh
sudo apt-get install software-properties-common
sudo apt-get install build-essential
sudo apt-get update
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt-get update
sudo apt-get install helix
