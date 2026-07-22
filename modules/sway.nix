{ pkgs, pkgs-unstable, ... }:
let
  coreutils_bin = "${pkgs.coreutils}/bin";
  vime-client = pkgs.writeShellScriptBin "vime-client" ''
    export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/shizukani-cp/bin:$PATH"

    RUN_DIR="''${XDG_RUNTIME_DIR:-/tmp}"
    READY_PIPE="$RUN_DIR/nvim-vime-ready.pipe"
    MY_PIPE="$RUN_DIR/nvim-vime-$$.pipe"
    FILE_PATH="/tmp/$(${coreutils_bin}/date +%Y%m%d%H%M%S).md"

    while [ ! -S "$READY_PIPE" ]; do
      ${coreutils_bin}/sleep 0.05
    done

    ${coreutils_bin}/mv "$READY_PIPE" "$MY_PIPE"

    ${coreutils_bin}/touch "$FILE_PATH"

    ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-send "<Cmd>e $FILE_PATH<Cr>"
    ${pkgs.foot}/bin/foot -T "vime - foot" ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-ui "$FILE_PATH"

    ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-send "<Cmd>qa!<Cr>" 2>/dev/null || true
    rm -f "$MY_PIPE"

    if [ -f "$FILE_PATH" ]; then
      ${coreutils_bin}/sleep 0.1
      ${coreutils_bin}/printf %s "$(${coreutils_bin}/cat "$FILE_PATH")" | ${pkgs.wl-clipboard}/bin/wl-copy
      while [ "$(${pkgs.wl-clipboard}/bin/wl-paste | ${coreutils_bin}/tr -d '\n')" != "$(${coreutils_bin}/tr -d '\n' < "$FILE_PATH")" ]; do
        ${coreutils_bin}/sleep 0.05
      done

      ${pkgs.libnotify}/bin/notify-send -t 800 "Copy OK" "Sucessfully copied"
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

  environment.systemPackages = [
    vime-client
    pkgs.wf-recorder
  ];

  environment.etc."sway/config".text = ''
    set $mod Mod4
    workspace_layout tabbed

    bindsym $mod+Return exec ${pkgs.foot}/bin/foot , exec ${pkgs-unstable.qutebrowser}/bin/qutebrowser
    bindsym $mod+d exec ${pkgs.rofi}/bin/rofi -modi drun\,run -show drun
    bindsym $mod+Shift+q kill
    bindsym $mod+Shift+e exec ${pkgs.wlogout}/bin/wlogout
    bindsym $mod+Shift+c reload
    bindsym $mod+Tab focus next
    bindsym $mod+n focus right
    bindsym $mod+s focus left

    bindsym $mod+f fullscreen toggle
    bindsym $mod+w layout tabbed
    bindsym $mod+r layout stacking
    bindsym Henkan_Mode exec ${vime-client}/bin/vime-client

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
      xkb_layout "us"
    }

    for_window [title="vime - foot"] floating enable

    # curl -o ~/Pictures/Wallpapers/nixos-wallpaper-catppuccin-frappe.png "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-frappe.png"
    output * bg ~/Pictures/Wallpapers/nixos-wallpaper-catppuccin-frappe.png fill

    exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
    exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    exec ${pkgs.dunst}/bin/dunst
  '';
}
