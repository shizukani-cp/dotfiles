{
  pkgs,
  pkgs-unstable,
  lib,
  color-palette,
  ...
}:
let
  no-hash-color-palette = lib.mapAttrs (name: value: lib.removePrefix "#" value) color-palette;
in
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-save-interval '15'
          set -g @continuum-restore 'off'
        '';
      }
      vim-tmux-navigator
    ];
    shortcut = "s";
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format "#{b:pane_current_path}"

      set -g status-position top
      set -g status-justify left
      set -g status-style bg=default,fg=white
      set -g status-left ""
      set -g status-left-length 0
      setw -g window-status-format "#[fg=${color-palette.terminal_black},bg=default]#[fg=${color-palette.fg},bg=${color-palette.terminal_black}] #I:#W #[fg=${color-palette.terminal_black},bg=default]"
      setw -g window-status-current-format "#[fg=${color-palette.blue0},bg=default]#[fg=${color-palette.fg},bg=${color-palette.blue0},bold] #I:#W #[fg=${color-palette.blue0},bg=default]"
      setw -g window-status-separator ""
      setw -g window-status-separator ""
      set -g status-right-length 50
      set -g status-right "#{?client_prefix,#[bg=${color-palette.red}]#[fg=${color-palette.fg}][PREFIX]#[default],}#[bg=${color-palette.blue},fg=${color-palette.black},bold] #S #[default]"
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
    siteFunctions = {
      p = ''
        if [ -d "./.venv" ]; then
            deactivate
        fi
        cd "$PROJECTS_DIR/$1"
        if [ -d "./.venv" ]; then
            source ./.venv/bin/activate
        fi
      '';
      _p = ''
        #compdef p
        _path_files -W "$PROJECTS_DIR" -/
      '';
    };
    initContent = ''
      fpath=(~/.config/zsh/functions $fpath)
      if [ -n "$TMUX" ] && [ -z "$NVIM" ]; then
          if [ "$PWD" = "$HOME" ]; then
              cd $SCRATCH_DIR
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
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      blocks = [
        {
          alignment = "left";
          segments = [
            {
              foreground = color-palette.cyan;
              style = "plain";
              template = "┏[<${color-palette.fg}></> {{ .UserName }} from <${color-palette.fg}></> {{ .HostName }}]";
              type = "session";
            }
            {
              foreground = color-palette.magenta;
              properties = {
                style = "dallas";
                threshold = 0;
              };
              style = "diamond";
              template = "[<${color-palette.fg}></> {{ .FormattedMs }}s]";
              type = "executiontime";
            }
            {
              properties = {
                root_icon = "";
              };
              style = "diamond";
              template = "";
              type = "root";
            }
            {
              foreground = color-palette.cyan;
              properties = {
                time_format = "Monday at 3:04:05 PM";
              };
              style = "diamond";
              template = "[<${color-palette.fg}></> {{ .CurrentDate | date .Format }}]";
              type = "time";
            }
            {
              foreground = color-palette.magenta;
              properties = {
                fetch_stash_count = true;
                fetch_status = true;
                fetch_upstream_icon = true;
              };
              style = "plain";
              template = "[<${color-palette.fg}>{{ .UpstreamIcon }}</>{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} <${color-palette.fg}></> {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} <${color-palette.fg}></> {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} <${color-palette.fg}></> {{ .StashCount }}{{ end }}]";
              type = "git";
            }
            {
              foreground = color-palette.magenta;
              style = "plain";
              template = "[{{ .Profile }}{{if .Region}}@{{ .Region }}{{ end }}]";
              type = "aws";
            }
            {
              foreground = color-palette.magenta;
              style = "plain";
              template = "[{{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}}]";
              type = "kubectl";
            }
            {
              foreground = color-palette.magenta;
              style = "plain";
              template = "[]";
              type = "root";
            }
            {
              foreground = color-palette.magenta;
              style = "powerline";
              template = "[<${color-palette.fg}></> Error, check your command]";
              type = "status";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "left";
          newline = true;
          segments = [
            {
              foreground = "${color-palette.cyan}";
              style = "plain";
              template = "┖[<${color-palette.green1}>{{ .Path }}</>]";
              type = "path";
              options = {
                style = "full";
                max_depth = 0;
                mapped_locations = {
                  "~/workspace/github.com/shizukani-cp" = "󰃖";
                };
              };
            }
          ];
          type = "prompt";
        }
        {
          alignment = "left";
          newline = true;
          segments = [
            {
              foreground = "${color-palette.cyan}";
              style = "plain";
              template = "└─Δ";
              type = "text";
            }
          ];
          type = "prompt";
        }
      ];
      final_space = true;
      version = 3;
    };
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
      colors-dark = {
        foreground = no-hash-color-palette.fg;
        background = no-hash-color-palette.bg;
        selection-foreground = no-hash-color-palette.fg;
        selection-background = no-hash-color-palette.blue7;
        urls = no-hash-color-palette.green1;
        regular0 = no-hash-color-palette.black;
        regular1 = no-hash-color-palette.red;
        regular2 = no-hash-color-palette.green;
        regular3 = no-hash-color-palette.yellow;
        regular4 = no-hash-color-palette.blue;
        regular5 = no-hash-color-palette.magenta;
        regular6 = no-hash-color-palette.cyan;
        regular7 = no-hash-color-palette.fg_dark;
        bright0 = no-hash-color-palette.blue7;
        bright1 = no-hash-color-palette.red;
        bright2 = no-hash-color-palette.green;
        bright3 = no-hash-color-palette.yellow;
        bright4 = no-hash-color-palette.blue;
        bright5 = no-hash-color-palette.magenta;
        bright6 = no-hash-color-palette.cyan;
        bright7 = no-hash-color-palette.fg;
        "16" = no-hash-color-palette.orange;
        "17" = no-hash-color-palette.red1;
        alpha = "0.85";
      };
      csd = {
        preferred = "none";
        size = "0";
      };
    };
  };
  programs.bat = {
    enable = true;
    config = {
      pager = "${pkgs.ov}/bin/ov -F";
      theme = "Catppuccin Macchiato";
    };
  };
  programs.bluetuith = {
    enable = true;
    settings = {
      theme = {
        Text = color-palette.fg;
        Border = color-palette.border_highlight;
        Background = color-palette.bg_dark;
        StatusInfo = color-palette.blue;
        StatusError = color-palette.error;
        Adapter = color-palette.purple;
        AdapterPowered = color-palette.green;
        AdapterNotPowered = color-palette.dark3;
        AdapterDiscoverable = color-palette.cyan;
        AdapterScanning = color-palette.warning;
        AdapterPairable = color-palette.magenta;
        Device = color-palette.fg;
        DeviceType = color-palette.blue;
        DeviceAlias = color-palette.border_highlight;
        DeviceConnected = color-palette.green;
        DeviceDiscovered = color-palette.orange;
        DeviceProperty = color-palette.dark5;
        DevicePropertyConnected = color-palette.green1;
        DevicePropertyDiscovered = color-palette.orange;
        Menu = color-palette.bg_dark;
        MenuBar = color-palette.black;
        MenuItem = color-palette.fg;
        ProgressBar = color-palette.blue;
        ProgressText = color-palette.fg;
      };
    };
  };
  programs.bottom = {
    enable = true;
  };
  programs.fastfetch = {
    enable = true;
  };
  programs.fd = {
    enable = true;
  };
  programs.gcc = {
    enable = true;
  };
  programs.gh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      "filter \"lfs\"" = {
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
      };
      user = {
        name = "shizukani-cp";
        email = "shizukani.cp@gmail.com";
      };
      core = {
        autocrlf = false;
        pager = "${pkgs.ov}/bin/ov -cm";
        editor = "${pkgs-unstable.neovim}/bin/nvim";
      };
      init = {
        defaultBranch = "main";
      };
      alias = {
        tree = "log --graph --all --format=\"%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s\"";
        si = "switch";
        st = "status";
      };
      ghq = {
        root = "~/workspace";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      activeBorderColor = [
        color-palette.orange
        "bold"
      ];
      inactiveBorderColor = [ color-palette.bg_highlight ];
      searchingActiveBorderColor = [
        color-palette.orange
        "bold"
      ];
      optionsTextColor = [ color-palette.blue ];
      selectedLineBgColor = [ color-palette.bg_highlight ];
      cherryPickedCommitFgColor = [ color-palette.blue ];
      cherryPickedCommitBgColor = [ color-palette.magenta ];
      markedBaseCommitFgColor = [ color-palette.blue ];
      markedBaseCommitBgColor = [ color-palette.yellow ];
      unstagedChangesColor = [ color-palette.error ];
      defaultFgColor = [ color-palette.fg ];
    };
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.uv = {
    enable = true;
  };
}
