{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./chromium.nix
    ./host/hardware-configuration.nix
    ./keyd.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };
  boot.kernelParams = [ "amd_pstate=active" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  i18n.defaultLocale = "ja_JP.UTF-8";
  console.keyMap = "us";

  networking = {
    hostName = "shizukani-cp";
    networkmanager.enable = true;
    nftables.enable = true;
    firewall.allowPing = true;
  };
  zramSwap = {
    enable = true;
    memoryPercent = 30;
    algorithm = "zstd";
  };
  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway "
          + "--theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
        user = "greeter";
      };
    };
  };
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
  services.xserver = {
    xkb.layout = "us";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.sway = {
      default = lib.mkForce ([
        "wlr"
        "gtk"
      ]);
    };
    config.common.default = [ "gtk" ];
  };
  fonts = {
    packages = with pkgs; [
      nerd-fonts.bitstream-vera-sans-mono
      nerd-fonts.symbols-only
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "BitstromWera Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "BitstromWera Nerd Font Mono"
        ];
        serif = [
          "Noto Serif CJK JP"
          "JetBrainsMono Nerd Font"
        ];
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;
  services.earlyoom.enable = true;
  services.logind = {
    settings = {
      Login.HandlePowerKey = "ignore";
    };
  };

  users.users.shizukani-cp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
  ];
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nm-applet.enable = true;
  programs.steam.enable = true;
  virtualisation.waydroid.enable = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
      "steam-unwrapped"
      "widevine-cdm"
    ];
  home-manager.backupFileExtension = "backup";

  system.stateVersion = "26.05";
}
