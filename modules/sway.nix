{ pkgs, ... }:

{
  security.polkit.enable = true;
  programs.nm-applet.enable = true;

  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    wlogout
  ];
  environment.etc."sway/config".text = ''
    set $mod Mod4
    workspace_layout tabbed

    bindsym $mod+Return exec ${pkgs.foot}/bin/foot
    bindsym $mod+d exec ${pkgs.fuzzel}/bin/fuzzel
    bindsym $mod+Shift+q kill
    bindsym $mod+Shift+e exec ${pkgs.wlogout}/bin/wlogout
    bindsym $mod+Shift+c reload
    bindsym $mod+Tab focus next
    bindsym $mod+j focus left
    bindsym $mod+k focus right

    bindsym $mod+f fullscreen toggle
    bindsym $mod+w layout tabbed
    bindsym $mod+s layout stacking
    bindsym Henkan_Mode exec vime

    bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

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
  '';
  programs.waybar.enable = true;
}
