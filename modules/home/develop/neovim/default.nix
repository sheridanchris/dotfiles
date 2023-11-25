{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./options.nix
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
    ./colorscheme.nix
  ];

  programs.nixvim = {
    enable = true;
    
  };
}
