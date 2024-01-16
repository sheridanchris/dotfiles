{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  theme =
    pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "ce476fb41f307d90f841c1a4fd7f0727c21248b2";
      sha256 = "sha256-bpHznCqkNMbauDQjh98qj2+r1V8mXQIVmvKTldLcln0=";
    }
    + /catppuccin-mocha.toml;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = ["${theme}"];
      font = {
        size = 15;
        normal = {
          family = "CommitMono";
        };
      };
    };
  };
}
