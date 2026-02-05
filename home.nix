{ config, pkgs, inputs, ... }:

{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
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
  ];
  programs.home-manager.enable = true;
}
