{ config, pkgs, ... }:
let
  huj8Table =
    pkgs.runCommand "huj8.lua"
      {
        buildInputs = with pkgs; [
          lua5_4
          luajit
        ];
      }
      ''
        lua ${../nvim/lua/data/huj8_gen.lua} > temp.lua
        luajit -b temp.lua $out
      '';
in
{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "25.11";
  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  home.file = {
    ".gitconfig".source = ../.gitconfig;
    ".local/share/skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };
  xdg.enable = true;
  xdg.configFile = {
    "nvim" = {
      source = ../nvim;
      recursive = true;
    };
    "nvim/lua/data/huj8.lua" = {
      source = huj8Table;
    };
    "zsh" = {
      source = ../zsh;
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
  };
  home.sessionVariables = {
    DOTFILES_DIR = "${config.home.sessionVariables.PROJECTS_DIR}/dotfiles";
    EDITOR = "nvim";
    LANG = "ja_JP.UTF-8";
    LESSCHARSET = "utf-8";
    PATH = "$HOME/.local/bin:$PATH";
    PROJECTS_DIR = "${config.home.homeDirectory}/workspace/github.com/shizukani-cp";
  };
}
