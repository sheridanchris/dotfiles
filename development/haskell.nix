{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell rec {
          packages = [
            haskellPackages.hoogle
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server
            haskellPackages.ormolu
            haskellPackages.retrie
            haskellPackages.hlint
          ];
        };
      });
}