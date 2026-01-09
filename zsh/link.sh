DOTFILES_PATH="$HOME/workspace/dotfiles"

if [ $(basename $(pwd -P)) = "dotfiles" ]; then
  ln -sf "$DOTFILES_PATH/nvim" "$HOME/.config/"
  ln -sf "$DOTFILES_PATH/zsh/.shfunc" "$HOME/.shfunc"
  ln -sf "$DOTFILES_PATH/zsh/.shopts" "$HOME/.shopts"
  ln -sf "$DOTFILES_PATH/wezterm/" "$HOME/.config/"
  ln -sf "$DOTFILES_PATH/tmux/" "$HOME/.config/"
  ln -sf "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$DOTFILES_PATH/zsh/link.sh" "$HOME/.local/bin/link.sh"
  ln -sf "$DOTFILES_PATH/zsh/my-theme.omp.json" "$HOME/.poshthemes/my-theme.omp.json"
  ln -sf "$DOTFILES_PATH/gemini/settings.json" "$HOME/.gemini/settings.json"
  ln -sf "$DOTFILES_PATH/gemini/GEMINI.md" "$HOME/.gemini/GEMINI.md"
fi
