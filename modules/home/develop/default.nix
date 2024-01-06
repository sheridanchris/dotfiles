{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./helix.nix
    ./neovim
    ./vscode.nix
  ];
}
