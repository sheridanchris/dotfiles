{
  description = "Christian Sheridan's NixOS System and User Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, helix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
      overlays = [ ];
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
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
        ];
      };
    };
}
