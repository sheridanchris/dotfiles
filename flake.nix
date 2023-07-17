{
  description = "Christian Sheridan's NixOS System and User Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in {
      #homeManagerConfigurations = {
      #  christian = home-manager.lib.homeManagerConfiguration {
      #    inherit pkgs;
      #    modules = [
      #      ./users/christian/home.nix
      #    ];
      # };
      #};
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.christian = import ./users/christian/home.nix;
            }
          ];
        };
      };
    }; 
}
