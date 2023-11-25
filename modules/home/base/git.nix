{ config, pkgs, lib, inputs, ... }: {
  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
  };
  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-dash ];
  };
}
