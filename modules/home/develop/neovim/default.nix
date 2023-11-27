{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./options.nix
    ./lsp.nix
    ./completions.nix
    ./telescope.nix
    ./treesitter.nix
    ./colorscheme.nix
    ./git.nix
    ./plugins.nix
  ];

  programs.nixvim.enable = true;
}
