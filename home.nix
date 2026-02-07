{ config, pkgs, plasma-manager, ... }:

{
  imports = [
    plasma-manager.homeModules.plasma-manager
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
    deno
    fd
    ffmpeg
    foot
    gcc
    gh
    gitFull
    glibc
    gnumake
    lazygit
    mpc
    ncmpcpp
    neovim
    nerd-fonts.bitstream-vera-sans-mono
    nodejs_24
    noto-fonts-cjk-sans
    ripgrep
    rustup
    stylua
    tmux
    tree-sitter
    uv
    wl-clipboard
    zsh
    (writeShellScriptBin "vime" ''
      export XDG_RUNTIME_DIR="/run/user/1001"
      export WAYLAND_DISPLAY=wayland-0
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
      rm = "gio trash";
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
  programs.plasma = {
    enable = true;
    shortcuts = {
    "kwin" = {
      "Walk Through Windows" = "Alt+Tab";
      "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
      "Walk Through Windows Alternative" = [ ];
      "Overview" = "Meta+Tab";
    };
  };
    panels = [{
      location = "left";
      lengthMode = "fill";
      height = 33;
      widgets = [
        "org.kde.plasma.kickoff"
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General = {
              launchers = [
                "applications:brave-browser.desktop"
                "applications:foot.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          };
        }
        # "org.kde.plasma.weather"
        # "org.kde.plasma.systemmonitor.diskusage"
        # "org.kde.plasma.systemmonitor.diskquota"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
      ];
    }];
    kwin.virtualDesktops.number = 4;
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
