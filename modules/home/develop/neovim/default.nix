{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./options.nix
    ./lsp.nix
    ./completions.nix
    ./telescope.nix
    ./colorscheme.nix
  ];

  programs.nixvim.enable = true;
}
