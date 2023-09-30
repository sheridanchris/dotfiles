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
          packages = with ocamlPackages; [
            ocaml
            dune_3
            ocamlformat
            merlin
            utop
            odoc
            ocaml-lsp
            ocamlformat-rpc-lib
          ];
        };
      });
}
