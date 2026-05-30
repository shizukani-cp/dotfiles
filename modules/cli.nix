{
  pkgs,
  ...
}:
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
      setw -g window-status-format "#[fg=#5c6d74,bg=default]#[fg=#FFFFFF,bg=#5c6d74] #I:#W #[fg=#5c6d74,bg=default]"
      setw -g window-status-current-format "#[fg=#ae8b2d,bg=default]#[fg=#FFFFFF,bg=#ae8b2d,bold] #I:#W #[fg=#ae8b2d,bg=default]"
      setw -g window-status-separator ""
      setw -g window-status-separator ""
      set -g status-right-length 50
      set -g status-right "#[bg=blue,fg=black,bold] #S #[default]"
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
              foreground = "#7eb8da";
              style = "plain";
              template = "┏[<#ffffff></> {{ .UserName }} from <#ffffff></> {{ .HostName }}]";
              type = "session";
            }
            {
              foreground = "#be9ddf";
              properties = {
                style = "dallas";
                threshold = 0;
              };
              style = "diamond";
              template = "[<#ffffff></> {{ .FormattedMs }}s]";
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
              foreground = "#7eb8da";
              properties = {
                time_format = "Monday at 3:04:05 PM";
              };
              style = "diamond";
              template = "[<#ffffff></> {{ .CurrentDate | date .Format }}]";
              type = "time";
            }
            {
              foreground = "#ffa5d8";
              properties = {
                fetch_stash_count = true;
                fetch_status = true;
                fetch_upstream_icon = true;
              };
              style = "plain";
              template = "[<#ffffff>{{ .UpstreamIcon }}</>{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} <#ffffff></> {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} <#ffffff></> {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} <#ffffff></> {{ .StashCount }}{{ end }}]";
              type = "git";
            }
            {
              foreground = "#ffa5d8";
              style = "plain";
              template = "[{{ .Profile }}{{if .Region}}@{{ .Region }}{{ end }}]";
              type = "aws";
            }
            {
              foreground = "#ffa5d8";
              style = "plain";
              template = "[{{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}}]";
              type = "kubectl";
            }
            {
              foreground = "#ffa5d8";
              style = "plain";
              template = "[]";
              type = "root";
            }
            {
              foreground = "#ffa5d8";
              style = "powerline";
              template = "[<#ffffff></> Error, check your command]";
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
              foreground = "#7eb8da";
              style = "plain";
              template = "┖[<#98bfad>{{ .Path }}</>]";
              type = "path";
              options = {
                style = "full";
                max_depth = 0;
                mapped_locations = {
                  "~/workspace" = "󰃖";
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
              foreground = "#7eb8da";
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
}
