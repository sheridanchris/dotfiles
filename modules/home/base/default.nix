{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./theme.nix
    ./git.nix
    ./shell.nix
    ./packages.nix
  ];
}
