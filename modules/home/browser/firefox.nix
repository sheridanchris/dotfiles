{pkgs, ...}: {
  # TODO: Use librewolf?
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
      };
    };
    profiles = {
      christian = {
        id = 0;
        name = "Christian";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://duckduckgo.com/";
        };

        search = {
          force = true;
          default = "DuckDuckGo";
          order = [
            "DuckDuckGo"
            "Google"
            "Nix Packages"
            "NixOS Wiki"
          ];
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
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
          };
        };
      };
    };
  };
}
