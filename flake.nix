{
  description = "Christian Sheridan's NixOS System and User Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-rofi = {
      url = "github:catppuccin/rofi";
      flake = false;
    };
    catppuccin-polybar = {
      url = "github:catppuccin/polybar";
      flake = false;
    };
    cascade-firefox = {
      url = "github:cascadefox/cascade";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    ...
  } @ inputs: let
    username = "christian";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
    with pkgs; {
      formatter.${system} = alejandra;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs username;};
          modules = [
            (import ./hosts/nixos/configuration.nix)
          ];
        };
      };

      checks.${system} = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true;
          };
        };
      };
      devShell.${system} = mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        packages = [nixd];
      };
    };
}
