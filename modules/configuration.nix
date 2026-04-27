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

  i18n.defaultLocale = "ja_JP.UTF-8";
  console.keyMap = "jp106";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.bluetooth.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "jp";
  };
  services.displayManager.sddm.enable = true;

  services.pipewire.pulse.enable = true;

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
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.gvfs.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.2";
  };

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
      "widevine-cdm"
    ];

  system.stateVersion = "25.11";
}
