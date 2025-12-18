DOTFILES_PATH="$HOME/workspace/dotfiles"

if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  ln -sf "$DOTFILES_PATH/nvim" "$HOME/.config/"
  ln -sf "$DOTFILES_PATH/bash/.shfunc" "$HOME/.shfunc"
  ln -sf "$DOTFILES_PATH/bash/.shopts" "$HOME/.shopts"
  ln -sf "$DOTFILES_PATH/.wezterm.lua" "$HOME/.wezterm.lua"
  ln -sf "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$DOTFILES_PATH/bash/link.sh" "$HOME/.local/bin/link.sh"
fi
