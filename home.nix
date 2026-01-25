{ config, pkgs, ... }:

{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    bat
    fd
    ripgrep
    bottom
    gh
    lazygit
    stylua
    tmux
    uv
    deno
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
  programs.home-manager.enable = true;
}
