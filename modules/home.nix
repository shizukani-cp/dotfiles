{
  config,
  pkgs,
  pkgs-unstable,
  color-palette,
  ...
}:

{
  imports = [
    ./cli.nix
    ./env.nix
    ./mpd.nix
    ./qutebrowser.nix
    ./desktop.nix
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
    lua-language-server
    mpc
    nil
    nixfmt
    nodejs_24
    pkgs-unstable.neovim
    python312Packages.python-lsp-server
    rustup
    shotcut
    stylua
    tailwindcss-language-server
    trash-cli
    tree
    tree-sitter
    typescript
    typescript-language-server
    unzip
    uv
    vscode-langservers-extracted
    wl-clipboard
  ];
  programs.home-manager.enable = true;
}
