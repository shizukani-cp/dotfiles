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
    configFile = ../zsh/my-theme.omp.json;
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
