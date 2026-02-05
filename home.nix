{ config, pkgs, ... }:

{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    nerd-fonts.bitstream-vera-sans-mono
    noto-fonts-cjk-sans
    zsh
  ];
  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
  };
  programs.home-manager.enable = true;
}
