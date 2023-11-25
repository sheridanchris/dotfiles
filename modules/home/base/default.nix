{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./git.nix
    ./shell.nix
    ./packages.nix
  ];
}
