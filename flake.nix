{
  description = "Christian Sheridan's NixOS System and User Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
      overlays = [
        hyprland.overlays.default
      ];
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = overlays;
            }

            home-manager.nixosModules.home-manager
            (import ./system/configuration.nix)
          ];
        };
      };
    }; 
}
