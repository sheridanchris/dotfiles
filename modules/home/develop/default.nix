{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./helix.nix
    ./neovim.nix
    ./vscode.nix
  ];
}
