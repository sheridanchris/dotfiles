# https://nixos.org/manual/nixpkgs/unstable/#dotnet
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nuget-packageslock2nix = {
      url = "github:mdarocha/nuget-packageslock2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    pre-commit-hooks,
    nuget-packageslock2nix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      with pkgs; {
        # TODO: I don't know if this works.
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              fantomas = {
                enable = true;
                name = "fantomas";
                description = "Format your F# code with fantomas.";
                entry = "dotnet fantomas";
                files = "(\\.fs$)|(\\.fsx$)";
              };
            };
          };
        };
        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = [
            fsautocomplete # (OPTIONAL) fsharp language server
            dotnet-sdk_8
          ];
          DOTNET_ROOT = "${dotnet-sdk_8}";
        };
        packages.default = buildDotnetModule rec {
          pname = "<name>";
          version = "<version>";
          src = ./placeholder_src;

          nugetDeps = nuget-packageslock2nix.lib {
            inherit system;
            name = "<name>";
            lockfiles = [./placeholder_lockfile];
          };

          # (OPTIONAL) Include any dotnetModules that are referenced by this project.
          projectReferences = [];

          dotnet-sdk = dotnet-sdk_8;
          dotnet-runtime = dotnet-runtime_8;

          # (OPTIONAL)
          # packNupkg = true;

          buildType = "Release";

          # (OPTIONAL)
          executables = ["<executable>"];
        };
      });
}
