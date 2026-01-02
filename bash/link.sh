DOTFILES_PATH="$HOME/workspace/dotfiles"

if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  ln -sf "$DOTFILES_PATH/nvim" "$HOME/.config/"
  ln -sf "$DOTFILES_PATH/bash/.shfunc" "$HOME/.shfunc"
  ln -sf "$DOTFILES_PATH/bash/.shopts" "$HOME/.shopts"
  ln -sf "$DOTFILES_PATH/.wezterm.lua" "$HOME/.wezterm.lua"
  ln -sf "$DOTFILES_PATH/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$DOTFILES_PATH/bash/link.sh" "$HOME/.local/bin/link.sh"
  ln -sf "$DOTFILES_PATH/bash/my-theme.omp.json" "$HOME/.poshthemes/my-theme.omp.json"
  ln -sf "$DOTFILES_PATH/gemini/settings.json" "$HOME/.gemini/settings.json"
  ln -sf "$DOTFILES_PATH/gemini/GEMINI.md" "$HOME/.gemini/GEMINI.md"
fi
