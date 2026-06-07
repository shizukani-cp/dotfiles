{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    ./chromium.nix
    ./host/hardware-configuration.nix
    ./keyd.nix
    ./sway.nix
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

  networking.hostName = "shizukani-cp";
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.allowPing = true;

  i18n.defaultLocale = "ja_JP.UTF-8";
  console.keyMap = "jp106";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.bluetooth.enable = true;

  services.xserver = {
    xkb.layout = "jp";
  };

  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
  security.rtkit.enable = true;

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

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  virtualisation.waydroid.enable = true;

  services.gvfs.enable = true;

  services.power-profiles-daemon.enable = true;

  services.earlyoom.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  users.users.shizukani-cp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  home-manager.backupFileExtension = "backup";

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
  ];
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.steam = {
    enable = true;
  };
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
      "steam-unwrapped"
    ];

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

  system.stateVersion = "26.05";
}
