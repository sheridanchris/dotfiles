{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  defaultBrowser = "librewolf.desktop";
in {
  imports = [
    ./librewolf.nix
    ./firefox.nix
    ./qutebrowser.nix
  ];

  xdg.mimeApps.defaultApplications = {
    "text/html" = defaultBrowser;
    "x-scheme-handler/http" = defaultBrowser;
    "x-scheme-handler/https" = defaultBrowser;
    "x-scheme-handler/about" = defaultBrowser;
    "x-scheme-handler/unknown" = defaultBrowser;
  };
}
