{ config, pkgs, unstable, ... }:

{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "25.11";
  home.packages = (with pkgs; [
    bat
    bottom
    deno
    fd
    gcc
    gh
    gitFull
    glibc
    gnumake
    lazygit
    neovim
    nerd-fonts.bitstream-vera-sans-mono
    nodejs_24
    noto-fonts-cjk-sans
    ripgrep
    rustup
    stylua
    tmux
    uv
    zsh
  ]) ++ [
    unstable.theclicker
  ];
  home.file = {
    ".gemini/".source = ./gemini;
    ".gitconfig".source = ./.gitconfig;
  };
  xdg.enable = true;
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
    "foot" = {
      source = ./foot;
      recursive = true;
    };
    "zsh" = {
      source = ./zsh;
      recursive = true;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS_DIR = "${config.home.homeDirectory}/workspace";
    LANG = "ja_JP.UTF-8";
    LESSCHARSET = "utf-8";
  };
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      rm = "gio trash";
      tree = "tree --gitignore";
    };
    initContent = ''
      fpath=(~/.config/zsh/functions $fpath)
      autoload -Uz $(ls ~/.config/zsh/functions)
      if [ -n "$TMUX" ] && [ -z "$NVIM" ]; then
          if [ "$PWD" = "$HOME" ]; then
              s
          fi
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gh"
        "rust"
        "uv"
      ];
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = ./zsh/my-theme.omp.json;
  };
  programs.home-manager.enable = true;
}
