{
  description = "Christian Sheridan's NixOS System and User Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nur.url = "github:nix-community/NUR";
  };
  outputs = { self, nixpkgs, home-manager, hyprland, nur, ... }@inputs:
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
      nurpkgs = import nixpkgs { inherit system; };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import nur {
                  inherit pkgs nurpkgs;
                  repoOverrides = { };
                };
              };
            }

            home-manager.nixosModules.home-manager
            (import ./system/configuration.nix)
          ];
        };
      };
    };
}
