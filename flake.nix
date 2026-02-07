{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    plasma-manager.url = "github:nix-community/plasma-manager";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations."shizukani-cp" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit plasma-manager; };
            home-manager.users.shizukani-cp = import ./home.nix;
          }
        ];
      };
    };
}
