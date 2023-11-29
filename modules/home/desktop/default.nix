{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./terminal.nix
    ./rofi.nix
    ./btop.nix
    ./bspwm.nix
    ./spotify.nix
  ];
}
