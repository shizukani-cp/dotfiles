{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown (S)";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot (R)";
        keybind = "r";
      }
      {
        label = "lock";
        action = "swaylock";
        text = "Lock (L)";
        keybind = "l";
      }
      {
        label = "logout";
        action = "swaymsg exit";
        text = "Logout (E)";
        keybind = "e";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate (H)";
        keybind = "h";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend (U)";
        keybind = "u";
      }
    ];
  };
  programs.rofi = {
    enable = true;
    theme = {
      "*" = {
        bg = mkLiteral "#24283b";
        hv = mkLiteral "#9274ca";
        primary = mkLiteral "#C5C8C6";
        ug = mkLiteral "#0B2447";
        font = "Monospace 11";
        background-color = mkLiteral "@bg";
        border = mkLiteral "0px";
        kl = mkLiteral "#7aa2f7";
        black = mkLiteral "#000000";
        transparent = mkLiteral "rgba(46,52,64,0)";
      };

      "window" = {
        width = 700;
        orientation = mkLiteral "horizontal";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        transparency = "screenshot";
        border-color = mkLiteral "@primary";
        border = mkLiteral "3px";
        border-radius = mkLiteral "6px";
        spacing = 0;
        children = map mkLiteral [ "mainbox" ];
      };

      "mainbox" = {
        spacing = 0;
        children = map mkLiteral [
          "inputbar"
          "message"
          "listview"
        ];
      };

      "inputbar" = {
        color = mkLiteral "@kl";
        padding = mkLiteral "11px";
        border = mkLiteral "0 0 2px 0";
        border-color = mkLiteral "@primary";
      };

      "message" = {
        padding = 0;
      };

      "textbox" = {
        color = mkLiteral "@kl";
        padding = mkLiteral "10px";
      };

      "entry, prompt, case-indicator" = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        cursor = mkLiteral "pointer";
      };

      "prompt" = {
        margin = mkLiteral "0px 5px 0px 0px";
      };

      "listview" = {
        layout = mkLiteral "vertical";
        padding = mkLiteral "8px";
        lines = 12;
        columns = 1;
        dynamic = false;
      };

      "element" = {
        padding = mkLiteral "2px";
        vertical-align = 1;
        color = mkLiteral "@kl";
        font = mkLiteral "inherit";
      };

      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element selected.normal" = {
        color = mkLiteral "@black";
        background-color = mkLiteral "@hv";
      };

      "element normal active" = {
        background-color = mkLiteral "@hv";
        color = mkLiteral "@black";
      };

      "element-text, element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element normal urgent" = {
        background-color = mkLiteral "@primary";
      };

      "element selected active" = {
        background = mkLiteral "@hv";
        foreground = mkLiteral "@bg";
      };

      "button" = {
        padding = mkLiteral "6px";
        color = mkLiteral "@primary";
        horizontal-align = mkLiteral "0.5";

        border = mkLiteral "2px 0px 2px 2px";
        border-radius = mkLiteral "4px 0px 0px 4px";
        border-color = mkLiteral "@primary";
      };

      "button selected normal" = {
        border = mkLiteral "2px 0px 2px 2px";
        border-color = mkLiteral "@primary";
      };

      "scrollbar" = {
        enabled = true;
      };
    };
    extraConfig = {
      modi = "combi";
      show-icons = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "left";
        width = 40;
        spacing = 5;
        modules-left = [
          "sway/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [ ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "network"
          "custom/bluetooth"
          "clock"
          "battery"
        ];

        cpu = {
          interval = 1;
          format = "C{usage}%";
        };
        memory = {
          interval = 1;
          format = "M{percentage}%";
          tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB ({percentage}%)";
        };
        pulseaudio = {
          format = "{icon}\n{volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
        };
        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰤮";
          on-click = "foot nmtui";
        };
        "custom/bluetooth" = {
          format = "";
          on-click = "foot bluetuith";
        };
        clock = {
          format = "{:%m/%d\n%H:%M}";
        };
        battery = {
          interval = 1;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}%";
          format-charging = "[{capacity}%]";
          format-plugged = "[{capacity}%]";
        };
        "wlr/taskbar" = {
          format = "{icon}";
          on-click = "activate";
          on-click-middle = "close";
          sort-by-number = true;
          all-outputs = true;
          ignore-list = [ ];
          active-first = false;
        };
      }
    ];
    style = ''
      * {
        font-family: monospace;
        font-size: 14px;
      }

      window#waybar {
        background: rgba(43, 48, 59, 0.5);
        color: #ffffff;
      }

      #workspaces button {
        padding: 0 5px;
        color: #ffffff;
      }

      #taskbar button {
        padding: 5px;
        border-left: 3px solid transparent;
      }

      #taskbar button.active {
        background-color: rgba(255, 255, 255, 0.1);
        border-left: 3px solid #ffffff;
        color: #ffffff;
      }

      #taskbar button:hover {
        background-color: rgba(255, 255, 255, 0.2);
      }

      #battery {
        color: #ffffff;
        margin-top: 10px;
      }

      #battery.charging,
      #battery.plugged {
        color: #26A65B;
        font-weight: bold;
      }

      #memory.warning {
        color: #f1c40f;
      }

      #memory.critical {
        color: #e74c3c;
      }
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        layer = "top";
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = "(0, 300)";
        offset = "(30, 30)";
        origin = "bottom-left";
        transparency = 10;
        font = "BitstromWera Nerd Font Mono 13, Noto Sans Mono CJK JP 13";
        frame_width = 1;
        frame_color = "#888888";
      };
      urgency_normal = {
        background = "#222436";
        foreground = "#c8d3f5";
        frame_color = "#c8d3f5";
        timeout = 10;
      };
      urgency_low = {
        background = "#1e2030";
        foreground = "#c8d3f5";
        frame_color = "#c8d3f5";
        timeout = 5;
      };
      urgency_critical = {
        background = "#2f334d";
        foreground = "#c53b53";
        frame_color = "#c53b53";
        timeout = 20;
      };
    };
  };
}
