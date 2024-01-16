{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./options.nix
    ./languages.nix
    ./telescope.nix
    ./treesitter.nix
    ./colorscheme.nix
    ./git.nix
    ./plugins.nix
  ];

  programs.nixvim.enable = true;
}
