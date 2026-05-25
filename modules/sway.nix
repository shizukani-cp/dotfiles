{ pkgs, pkgs-unstable, ... }:
let
  coreutils_bin = "${pkgs.coreutils}/bin";
  vime = pkgs.writeShellScriptBin "vime" ''
    export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/shizukani-cp/bin:$PATH"

    FILE_PATH="/tmp/$(${coreutils_bin}/date +%Y%m%d%H%M%S).md"

    ${coreutils_bin}/touch "$FILE_PATH"

    VIME=1 ${pkgs.foot}/bin/foot ${pkgs-unstable.neovim}/bin/nvim "$FILE_PATH"

    if [ -f "$FILE_PATH" ]; then
      ${coreutils_bin}/sleep 0.1
      ${coreutils_bin}/printf %s "$(${coreutils_bin}/cat "$FILE_PATH")" | ${pkgs.wl-clipboard}/bin/wl-copy
      while [ "$(${pkgs.wl-clipboard}/bin/wl-paste | ${coreutils_bin}/tr -d '\n')" != "$(${coreutils_bin}/tr -d '\n' < "$FILE_PATH")" ]; do
        ${coreutils_bin}/sleep 0.05
      done

      ${pkgs.libnotify}/bin/notify-send -t 800 "Copy OK" "Sucessfly copied"
    fi
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
        user = "greeter";
      };
    };
  };

  security.polkit.enable = true;
  programs.nm-applet.enable = true;

  programs.sway.enable = true;

  environment.systemPackages = [ vime ];

  environment.etc."sway/config".text = ''
    set $mod Mod4
    workspace_layout tabbed

    bindsym $mod+Return exec ${pkgs.foot}/bin/foot , exec ${pkgs-unstable.qutebrowser}/bin/qutebrowser
    bindsym $mod+d exec ${pkgs.rofi}/bin/rofi -modi drun\,run -show drun
    bindsym $mod+Shift+q kill
    bindsym $mod+Shift+e exec ${pkgs.wlogout}/bin/wlogout
    bindsym $mod+Shift+c reload
    bindsym $mod+Tab focus next
    bindsym $mod+j focus right
    bindsym $mod+k focus left

    bindsym $mod+f fullscreen toggle
    bindsym $mod+w layout tabbed
    bindsym $mod+s layout stacking
    bindsym Henkan_Mode exec ${vime}/bin/vime

    bindsym $mod+Shift+s exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.coreutils}/bin/tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send "Captured screen"

    bindsym XF86AudioRaiseVolume exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindsym XF86AudioLowerVolume exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindsym XF86AudioMute exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

    bar {
      swaybar_command waybar
    }

    font pango:monospace 1
    titlebar_padding 1
    titlebar_border_thickness 1
    client.focused #000000 #000000 #000000 #000000 #000000
    client.unfocused #000000 #000000 #000000 #000000 #000000

    input "type:keyboard" {
      xkb_layout "jp"
    }

    exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
    exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    exec ${pkgs.dunst}/bin/dunst
  '';
  programs.waybar.enable = true;
}
