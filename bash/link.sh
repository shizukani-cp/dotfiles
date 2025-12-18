local DOTFILE_PATHS="$HOME/workspace/dotfiles"

if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  ln -s "$DOTFILES_PATH/neovim/" "$HOME/.config/nvim"
  ln -s "$DOTFILES_PATH/bash/.shfunc" "$HOME/.shfunc"
  ln -s "$DOTFILES_PATH/bash/.shopts" "$HOME/.shopts"
  ln -s "$DOTFILES_PATH/.wezterm.lua" "$HOME/.wezterm.lua"
  ln -s "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"
  ln -s "$DOTFILES_PATH/bash/link.sh" "$HOME/.local/bin/link.sh"
fi
