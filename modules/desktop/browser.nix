{
  pkgs,
  inputs,
  username,
  ...
}: {
  environment.systemPackages = [inputs.zen-browser.packages."${pkgs.system}".default];

  home-manager.users.${username} = {
    programs.firefox = {
      enable = true;
      profiles.${username} = {
        id = 0;
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com/";
        };
        search = {
          default = "DuckDuckGo";
          force = true;
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
            "NixOS Options Search" = {
              urls = [{template = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
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
            "GitHub" = {
              urls = [{template = "https://github.com/search?q={searchTerms}&type=Everything";}];
              iconUpdateURL = "https://github.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@gh"];
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
