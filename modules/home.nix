{
  config,
  pkgs,
  pkgs-unstable,
  color-palette,
  no-hash-color-palette,
  ...
}:

{
  imports = [
    ./cli.nix
    ./env.nix
    ./mpd.nix
    ./qutebrowser.nix
    ./desktop.nix
    ./sway.nix
  ];
  home.packages = with pkgs; [
    clamtk
    deno
    ffmpeg
    ghq
    glibc
    gnumake
    krita
    libreoffice-fresh
    mpc
    nil
    nixfmt
    pkgs-unstable.neovim
    shotcut
    trash-cli
    tree
    tree-sitter
    unzip
    uv
    wl-clipboard
  ];
  programs.home-manager.enable = true;
}
