{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
      with pkgs; {
        devShells.default = mkShell {
          packages = [
            elmPackages.elm
            elmPackages.elm-format
            elmPackages.elm-test
            elmPackages.elm-language-server
            elm2nix
          ];
        };
      });
}
