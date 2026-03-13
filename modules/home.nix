{
  config,
  pkgs,
  plasma-manager,
  ...
}:

{
  imports = [
    ./plasma.nix
    ./cli.nix
    ./mpd.nix
    ./browser.nix
    ./env.nix
  ];
  home.packages = with pkgs; [
    bat
    bottom
    brave
    clamtk
    deno
    fd
    ffmpeg
    foot
    gcc
    gh
    ghq
    gitFull
    glibc
    gnumake
    lazygit
    libreoffice-fresh
    lua-language-server
    mpc
    ncmpcpp
    neovim
    nerd-fonts.bitstream-vera-sans-mono
    nil
    nixfmt
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodejs_24
    noto-fonts-cjk-sans
    prismlauncher
    python312Packages.python-lsp-server
    ripgrep
    rustup
    skkDictionaries.l
    stylua
    superTuxKart
    tailwindcss-language-server
    temurin-bin-17
    tmux
    trash-cli
    tree
    tree-sitter
    uv
    vscode-langservers-extracted
    wl-clipboard
    zsh
    (writeShellScriptBin "vime" ''
      export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/shizukani-cp/bin:$PATH"

      FILE_PATH="/tmp/$(date +%Y%m%d%H%M%S).md"

      touch "$FILE_PATH"

      foot nvim "$FILE_PATH"

      if [ -f "$FILE_PATH" ]; then
        sleep 0.1
        printf %s "$(cat "$FILE_PATH")" | wl-copy
      fi
    '')
  ];
  programs.home-manager.enable = true;
}
