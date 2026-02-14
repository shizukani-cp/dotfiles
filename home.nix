{
  config,
  pkgs,
  plasma-manager,
  ...
}:

{
  imports = [
    ./plasma.nix
  ];

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
    lua-language-server
    mpc
    ncmpcpp
    neovim
    nerd-fonts.bitstream-vera-sans-mono
    nixfmt
    nodejs_24
    noto-fonts-cjk-sans
    prismlauncher
    python312Packages.python-lsp-server
    ripgrep
    rustup
    skkDictionaries.l
    stylua
    temurin-bin-17
    tmux
    trash-cli
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
  home.file = {
    ".gemini/".source = ./gemini;
    ".gitconfig".source = ./.gitconfig;
    ".local/share/skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };
  xdg.enable = true;
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
    };
    "foot" = {
      source = ./foot;
    };
    "zsh" = {
      source = ./zsh;
    };
  };
  home.sessionVariables = {
    DOTFILES_DIR = "${config.home.sessionVariables.PROJECTS_DIR}/dotfiles";
    EDITOR = "nvim";
    LANG = "ja_JP.UTF-8";
    LESSCHARSET = "utf-8";
    PATH = "$HOME/.local/bin:$PATH";
    PROJECTS_DIR = "${config.home.homeDirectory}/workspace";
  };
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      rm = "trash-put";
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
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music/bgm";
    extraConfig = ''
      audio_output {
        type    "httpd"
        name    "My BGM Stream"
        encoder "opus"
        port    "8000"
        bind_address "127.0.0.1"
        bitrate "128000"
        format  "48000:16:2"
      }
    '';
  };
  programs.home-manager.enable = true;
}
