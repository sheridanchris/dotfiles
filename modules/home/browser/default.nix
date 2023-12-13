{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./librewolf.nix
    ./firefox.nix
    ./qutebrowser.nix
  ];
}
