{
  pkgs,
  username,
  ...
}: let
  defaultBrowser = ["vivaldi.desktop"];
in {
  home-manager.users.${username} = {
    home.packages = with pkgs; [vivaldi];
    xdg.mimeApps.defaultApplications = {
      "text/html" = defaultBrowser;
      "x-scheme-handler/http" = defaultBrowser;
      "x-scheme-handler/https" = defaultBrowser;
      "x-scheme-handler/about" = defaultBrowser;
      "x-scheme-handler/unknown" = defaultBrowser;
    };
  };
}
