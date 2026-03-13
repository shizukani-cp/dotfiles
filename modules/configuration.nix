{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ./host/hardware-configuration.nix ];

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
  services.desktopManager.plasma6.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(capslock_layer, f9)";
            muhenkan = "overload(muhenkan_layer, muhenkan)";
          };
          "capslock_layer:S" = {
            b = "backspace";
            n = "delete";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            o = "enter";
            u = "noop";

            w = "up";
            a = "left";
            s = "down";
            d = "right";
            e = "enter";
            q = "backspace";
            r = "delete";
          };
          "muhenkan_layer" = {
            y = "1";
            u = "2";
            i = "3";
            o = "4";
            p = "5";
            h = "6";
            j = "7";
            k = "8";
            l = "9";
            ";" = "0";
          };
        };
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  services.gvfs.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.2";
  };

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

  system.stateVersion = "25.11";
}
