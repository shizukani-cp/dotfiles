{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
        extraConfig = builtins.readFile ./keyd.conf;
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  users.users.shizukani-cp = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  home-manager.backupFileExtension = "backup";

  environment.systemPackages = with pkgs; [ git neovim wget ];
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
