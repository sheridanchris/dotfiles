{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  defaultBrowser = ["firefox.desktop"];
in {
  imports = [
    # ./librewolf.nix
    # ./chromium.nix
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
