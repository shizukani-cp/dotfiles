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
  home.file = {
    ".gitconfig".source = ./.gitconfig;
    ".local/share/skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };
  xdg.enable = true;
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
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
    PROJECTS_DIR = "${config.home.homeDirectory}/workspace/github.com/shizukani-cp";
  };
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-save-interval '15'
          set -g @continuum-restore 'on'
        '';
      }
      vim-tmux-navigator
    ];
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set -g status-position top
      set -g status-justify left
      set -g status-style bg=default,fg=white
      set -g status-left ""
      set -g status-left-length 0
      setw -g window-status-format "#[fg=#5c6d74,bg=default]#[fg=#FFFFFF,bg=#5c6d74] #I:#W #[fg=#5c6d74,bg=default]"
      setw -g window-status-current-format "#[fg=#ae8b2d,bg=default]#[fg=#FFFFFF,bg=#ae8b2d,bold] #I:#W #[fg=#ae8b2d,bg=default]"
      setw -g window-status-separator ""
      setw -g window-status-separator ""
      set -g status-right-length 50
      set -g status-right "#[bg=blue,fg=black,bold] #S #[default] #[fg=green]CPU:#(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')%% #[fg=white]| #[fg=cyan]MEM:#(free -m | awk '/Mem:/ { printf(\"%.1f%%\", $3/$2*100) }') "
      set -g status-interval 1

      set -g status-keys vi
      set -g default-command ""
      unbind C-b

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -n M-Left previous-window
      bind -n M-Right next-window
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      bind -n M-0 select-window -t 0
    '';
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      rm = "trash-put";
      tree = "tree --gitignore";
      nv = "nvim";
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
  programs.brave = {
    enable = true;
    extensions = [
      "bhghoamapcdpbohphigoooaddinpkbai" # Authenticator
      "cpedeojecpbkcomgcolphimkjdnikbck" # Auto Clicker
      "mfmpnnhnknadgoafpindapobelgkblbk" # Cat-In-Tab
      "clldacgmdnnanihiibdgemajcfkmfhia" # Color Picker for Chrome
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
      "godiecgffnchndlihlpaajjcplehddca" # GhostText
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google オフライン ドキュメント
      "neebplgakaahbhdphmkckjjcegoiijjo" # Keepa
      "ckkdlimhmcjmikdlpkmbgfkaikojcbjk" # Markdown Viewer
      "ioijepjbllchodiajdakejdbjmdgggoj" # PLaMo Translate
      "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
      "jplgfhpmjnbigmhklmmbgecoobifkmpa" # Proton VPN
      "gmloihcgbhbonllenincdakeijmikcne" # QR Scanner
      "ldgfbffkinooeloadekpmfoklnobpien" # Raindrop.io
      "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
      "pnjaodmkngahhkoihejjehlcdlnohgmp" # RSS Feed Reader
      "fjnbnpbmkenffdnngjfgmeleoegfcffe" # Stylish
      "pncfbmialoiaghdehhbnbhkkgmjanfhe" # uBlacklist
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "gabfmnliflodkdafenbcpjdlppllnemd" # 画像を JPG/PNG/WebP として保存
    ];
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "BitstromWera Nerd Font Mono:size=13, Noto Sans Mono CJK JP:size=13";
        initial-window-mode = "maximized";
        pad = "0x0";
        term = "xterm-256color";
        shell = "tmux new-session -A -s main";
      };
      colors = {
        background = "1e1e2e";
        alpha = "0.85";
      };
      csd = {
        preferred = "none";
        size = "0";
      };
    };
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
