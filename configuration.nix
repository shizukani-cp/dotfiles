{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  users.users.shizukani-cp = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [ git neovim wget ];
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
