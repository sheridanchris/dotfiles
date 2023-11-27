{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./firefox.nix
    ./qutebrowser.nix
  ];
}
