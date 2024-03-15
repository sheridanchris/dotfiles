{
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    # TODO: catppuccin integration.
    home.file."cascade-firefox-theme" = {
      target = ".mozilla/firefox/christian/chrome/includes";
      source = "${inputs.cascade-firefox}/chrome/includes";
    };

    home.file."cascade-firefox-theme-catppuccin-integration" = {
      target = ".mozilla/firefox/christian/chrome/integrations/catppuccin";
      source = "${inputs.cascade-firefox}/integrations/catppuccin";
    };

    programs.firefox = {
      enable = true;
      profiles.${username} = {
        id = 0;
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com/";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
          @import 'includes/cascade-config-mouse.css';
          @import 'integrations/catppuccin/cascade-mocha.css';

          @import 'includes/cascade-layout.css';
          @import 'includes/cascade-responsive.css';
          @import 'includes/cascade-floating-panel.css';

          @import 'includes/cascade-nav-bar.css';
          @import 'includes/cascade-tabs.css';
        '';
        search = {
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@nw"];
            };
            "Home Manager Options Search" = {
              urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
              iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@hm"];
            };
          };
        };
      };
    };
  };

  xdg.mime.defaultApplications = let
    defaultBrowser = "firefox.desktop";
  in {
    "text/html" = defaultBrowser;
    "x-scheme-handler/http" = defaultBrowser;
    "x-scheme-handler/https" = defaultBrowser;
    "x-scheme-handler/about" = defaultBrowser;
    "x-scheme-handler/unknown" = defaultBrowser;
  };
}
