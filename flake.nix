{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
    in {
      homeConfigurations."shizukani-cp" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
    };
}
