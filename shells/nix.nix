{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
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
        formatter.${system} = alejandra;
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nil.enable = true;
              alejandra.enable = true;
            };
          };
        };
        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = [
            nil
            alejandra
          ];
        };
      });
}
