if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  sudo mount --bind ~/.config/nvim/ ./neovim/
fi
