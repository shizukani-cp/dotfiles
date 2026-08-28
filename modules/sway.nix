{ pkgs, pkgs-unstable, ... }:
let
  coreutils_bin = "${pkgs.coreutils}/bin";
  modifier = "Mod4";
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-frappe.png";
    sha256 = "wtBffKK9rqSJo8+7Wo8OMruRlg091vdroyUZj5mDPfI=";
  };
  vime-client = pkgs.writeShellScriptBin "vime-client" ''
    export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/shizukani-cp/bin:$PATH"

    SOCK_PATH="/tmp/nvim-vime.sock"
    FILE_PATH="/tmp/$(${coreutils_bin}/date +%Y%m%d%H%M%S).md"

    MY_PIPE=$(${pkgs.netcat-openbsd}/bin/nc -U "$SOCK_PATH" <<< "GET")

    if [ -z "$MY_PIPE" ]; then
      ${pkgs.libnotify}/bin/notify-send -t 800 "Error" "Failed to get pipe from daemon"
      exit 1
    fi

    ${coreutils_bin}/touch "$FILE_PATH"

    ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-send "<Cmd>e $FILE_PATH<Cr>"
    ${pkgs.foot}/bin/foot -T "vime - foot" ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-ui "$FILE_PATH"

    ${pkgs-unstable.neovim}/bin/nvim --server "$MY_PIPE" --remote-send "<Cmd>qa!<Cr>" 2>/dev/null || true
    ${pkgs.netcat-openbsd}/bin/nc -U "$SOCK_PATH" <<< "RELEASE $MY_PIPE" >/dev/null

    if [ -f "$FILE_PATH" ]; then
      ${coreutils_bin}/sleep 0.1
      ${coreutils_bin}/printf %s "$(${coreutils_bin}/cat "$FILE_PATH")" | ${pkgs.wl-clipboard}/bin/wl-copy --type text/plain
      while [ "$(${pkgs.wl-clipboard}/bin/wl-paste | ${coreutils_bin}/tr -d '\n')" != "$(${coreutils_bin}/tr -d '\n' < "$FILE_PATH")" ]; do
        ${coreutils_bin}/sleep 0.05
      done

      ${pkgs.libnotify}/bin/notify-send -t 800 "Copy OK" "Sucessfully copied"
    fi
  '';
in
{
  home.packages = [
    vime-client
    pkgs.wf-recorder
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
      colors = {
        focused = {
          background = "#000000";
          border = "#000000";
          childBorder = "#000000";
          indicator = "#000000";
          text = "#000000";
        };
        unfocused = {
          background = "#000000";
          border = "#000000";
          childBorder = "#000000";
          indicator = "#000000";
          text = "#000000";
        };
      };
      floating.criteria = [ { title = "vime - foot"; } ];
      fonts = {
        names = [ "monospace" ];
        size = 1.0;
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
        };
      };
      keybindings = {
        "${modifier}+Return" =
          "exec ${pkgs.foot}/bin/foot , exec ${pkgs-unstable.qutebrowser}/bin/qutebrowser";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+v" =
          "exec ${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Shift+e" = "exec ${pkgs.wlogout}/bin/wlogout";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Tab" = "focus next";
        "${modifier}+n" = "focus right";
        "${modifier}+s" = "focus left";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+r" = "layout stacking";
        "${modifier}+Shift+space" = "floating toggle";
        "Henkan_Mode" = "exec ${vime-client}/bin/vime-client";
        "Shift+Henkan_Mode" = "exec ${pkgs.wtype}/bin/wtype -k F25 && ${vime-client}/bin/vime-client";
        "${modifier}+Shift+s" =
          "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - |"
          + " ${pkgs.coreutils}/bin/tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png |"
          + " ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send \"Captured screen\"";
        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      modifier = modifier;
      output = {
        "*" = {
          bg = "${wallpaper} fill";
        };
      };
      startup = [
        {
          command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway";
        }
      ];
      workspaceLayout = "tabbed";
    };
    extraConfig = ''
      titlebar_padding 1
      titlebar_border_thickness 1
    '';
  };
}
