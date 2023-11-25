{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../../../modules/home/base
    ../../../modules/home/desktop
    ../../../modules/home/develop
    ../../../modules/home/browser
  ];

  home = {
    username = "christian";
    homeDirectory = "/home/christian";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
