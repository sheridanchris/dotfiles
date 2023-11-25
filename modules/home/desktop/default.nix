{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./theme.nix
    ./terminal.nix
    ./rofi.nix
    ./btop.nix
    ./bspwm.nix
  ];
}
