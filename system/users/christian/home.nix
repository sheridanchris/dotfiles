{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModule
    # inputs.stylix.homeManagerModules.stylix
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
