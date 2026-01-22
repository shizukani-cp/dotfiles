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
    tmux
    uv
    deno
  ];
  programs.home-manager.enable = true;
}
