{ ... }:
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
