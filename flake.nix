{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      color-palette = {
        bg = "#24283b";
        bg_dark = "#1f2335";
        bg_dark1 = "#1b1e2d";
        bg_highlight = "#292e42";
        bg_popup = "#1f2335";
        bg_statusline = "#1f2335";
        bg_visual = "#3d59a1";
        black = "#1b1e2d";
        blue = "#7aa2f7";
        blue0 = "#3d59a1";
        blue1 = "#2ac3de";
        blue2 = "#0db9d7";
        blue5 = "#89ddff";
        blue6 = "#b4f9f8";
        blue7 = "#394b70";
        border_highlight = "#2ac3de";
        comment = "#565f89";
        cyan = "#7dcfff";
        dark3 = "#545c7e";
        dark5 = "#737aa2";
        error = "#db4b4b";
        fg = "#c0caf5";
        fg_dark = "#a9b1d6";
        fg_gutter = "#3b4261";
        green = "#9ece6a";
        green1 = "#73daca";
        green2 = "#41a6b5";
        info = "#0db9d7";
        magenta = "#bb9af7";
        magenta2 = "#ff007c";
        orange = "#ff9e64";
        purple = "#9d7cd8";
        red = "#f7768e";
        red1 = "#db4b4b";
        teal = "#1abc9c";
        terminal_black = "#414868";
        warning = "#e0af68";
        yellow = "#e0af68";
      };
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "widevine-cdm" ];
        };
      };
    in
    {
      nixosConfigurations."shizukani-cp" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
          inherit color-palette;
        };
        modules = [
          ./modules/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
              inherit color-palette;
            };
            home-manager.users.shizukani-cp = import ./modules/home.nix;
          }
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          deno
          lua-language-server
          nil
          nixfmt
          nodejs_24
          python314Packages.python-lsp-server
          stylua
        ];
        shellHook = ''
          echo "Entered dotfiles!"
        '';
      };
    };
}
