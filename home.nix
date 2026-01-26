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
    nodejs_24
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
    ".config/nvim/".source = ./nvim;
    ".config/zsh/".source = ./zsh;
    ".config/tmux/".source = ./tmux;
    ".config/foot/".source = ./foot;
    ".gemini/".source = ./gemini;
    ".gitconfig".source = ./.gitconfig;
    ".poshthemes/my-theme.omp.json".source = ./zsh/my-theme.omp.json;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS_DIR = "$HOME/workspace";
    LANG = "ja_JP.UTF-8";
    LESSCHARSET = "utf-8";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      rm = "gio trash";
      tree = "tree --gitignore";
    };
    initContent = ''
    . ~/.config/zsh/.shopts
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
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
  };
  programs.home-manager.enable = true;
}
