{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    plasma-manager.url = "github:nix-community/plasma-manager";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in
    {
      nixosConfigurations."shizukani-cp" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit plasma-manager;
              pkgs-unstable = pkgs-unstable;
            };
            home-manager.users.shizukani-cp = import ./modules/home.nix;
          }
        ];
      };
    };
}
