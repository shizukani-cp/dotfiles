DOTFILES_PATH="$HOME/workspace/dotfiles"

if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  ln -sf "$DOTFILES_PATH/" "$HOME/.config/home-manager"
  ln -sf "$DOTFILES_PATH/zsh/link.sh" "$HOME/.local/bin/link.sh"
  ln -sf "$DOTFILES_PATH/zsh/input.sh" "$HOME/.local/bin/input.sh"
fi
