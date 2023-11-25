{ pkgs }: {
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
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
          };
        };
        bookmarks = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "DuckDuckGo";
                url = "https://duckduckgo.com/";
                tags = [ "search" ];
              }
              {
                name = "GitHub";
                url = "https://github.com";
                tags = [ "social" "programming" ];
              }
              {
                name = "YouTube";
                url = "https://youtube.com";
                tags = [ "social" "entertainment" ];
              }
              {
                name = "Notion";
                url = "https://www.notion.so";
                tags = [ "journal" "management-tool" ];
              }
              {
                name = "Trello";
                url = "https://trello.com/";
                tags = [ "project-management" ];
              }
              {
                name = "Nix & NixOS";
                bookmarks = [
                  {
                    name = "Nix Manual";
                    url = "https://nixos.org/manual/nix/stable/";
                    tags = [ "nix" "manual" ];
                  }
                  {
                    name = "Nixpkgs Manual";
                    url = "https://nixos.org/manual/nixpkgs/stable/";
                    tags = [ "nix" "manual" ];
                  }
                  {
                    name = "NixOS Manual";
                    url = "https://nixos.org/manual/nixos/stable/";
                    tags = [ "nix" "nix-os" "manual" ];
                  }
                  {
                    name = "NixOS Wiki";
                    url = "https://nixos.wiki/";
                    tags = [ "nix" "nix-os" "wiki" ];
                  }
                  {
                    name = "Noogle";
                    url = "https://noogle.dev/";
                    tags = [ "nix" "search" ];
                  }
                  {
                    name = "Home Manager Options";
                    url = "https://nix-community.github.io/home-manager/options.html";
                    tags = [ "nix" "home-manager" ];
                  }
                  {
                    name = "Nix User Repositories";
                    url = "https://nur.nix-community.org/";
                    tags = [ "nix" ];
                  }
                  {
                    name = "Zero to Nix";
                    url = "https://zero-to-nix.com/";
                    tags = [ "nix" "learning" ];
                  }
                  {
                    name = "Nix.dev";
                    url = "https://nix.dev/";
                    tags = [ "nix" "learning" ];
                  }
                  {
                    name = "NixOS & Flakes Book";
                    url = "https://nixos-and-flakes.thiscute.world/";
                    tags = [ "nix" "learning" ];
                  }
                  {
                    name = "Flake Hub";
                    url = "https://flakehub.com/";
                    tags = [ "nix" ];
                  }
                ];
              }
              {
                name = "Programming";
                bookmarks = [
                  {
                    name = "Blogs";
                    bookmarks = [
                      {
                        name = "Ploeh";
                        url = "https://blog.ploeh.dk/";
                        tags = [ "blogs" "programming" ];
                      }
                      {
                        name = "Tales from Dev";
                        url = "https://talesfrom.dev/";
                        tags = [ "blogs" "programming" ];
                      }
                      {
                        name = "CodeOpinion";
                        url = "https://codeopinion.com";
                        tags = [ "blogs" "programming" ];
                      }
                      {
                        name = "F# Weekly";
                        url = "https://sergeytihon.com/fsharp-weekly/";
                        tags = [ "blogs" "f#" "programming" ];
                      }
                      {
                        name = "F# for fun and profit";
                        url = "https://fsharpforfunandprofit.com/";
                        tags = [ "learning" "f#" "programming" ];
                      }
                      {
                        name = "Paul Blasucci's Weblog";
                        url = "https://paul.blasuc.ci/";
                        tags = [ "blogs" "programming" ];
                      }
                      {
                        name = "Event Driven IO";
                        url = "https://event-driven.io/";
                        tags = [ "blog" "programming" ];
                      }
                    ];
                  }
                  {
                    name = "Languages";
                    bookmarks = [
                      {
                        name = "F#";
                        bookmarks = [
                          {
                            name = "F# Software Foundation";
                            url = "https://fsharp.org/";
                            tags = [ "f#" ];
                          }
                          {
                            name = "F# Docs";
                            url = "https://learn.microsoft.com/en-us/dotnet/fsharp/";
                            tags = [ "docs" "f#" "programming" ];
                          }
                          {
                            name = "F# Core Library Documentation";
                            url = "https://fsharp.github.io/fsharp-core-docs/";
                            tags = [ "docs" "f#" "programming" ];
                          }
                          {
                            name = "Fable";
                            url = "https://fable.io/";
                            tags = [ "f#" "programming" "web-development" ];
                          }
                        ];
                      }
                      {
                        name = "Haskell";
                        bookmarks = [
                          {
                            name = "Haskell";
                            url = "https://haskell.org";
                            tags = [ "haskell" ];
                          }
                          {
                            name = "Hackage";
                            url = "https://hackage.haskell.org/";
                            tags = [ "haskell" ];
                          }
                          {
                            name = "Hoogle";
                            url = "https://hoogle.haskell.org/";
                            tags = [ "haskell" "programming" "docs" ];
                          }
                          {
                            name = "Monday Morning Haskell";
                            url = "https://mmhaskell.com/";
                            tags = [ "haskell" "programming" ];
                          }
                          {
                            name = "Learn You a Haskell for Great Good!";
                            url = "http://learnyouahaskell.com/chapters";
                            tags = [ "haskell" "programming" "reading" "learning" ];
                          }
                          {
                            name = "Haskell for Imperative Programmers";
                            url = "https://www.youtube.com/playlist?list=PLe7Ei6viL6jGp1Rfu0dil1JH1SHk9bgDV";
                            tags = [ "haskell" "programming" "learning" ];
                          }
                        ];
                      }
                      {
                        name = "OCaml";
                        bookmarks = [
                          {
                            name = "OCaml";
                            url = "https://ocaml.org/";
                            tags = [ "ocaml" ];
                          }
                          {
                            name = "OCaml 5.0 Manual";
                            url = "https://v2.ocaml.org/releases/5.0/manual/index.html";
                            tags = [ "ocaml" "reading" "learning" ];
                          }
                          {
                            name = "OCaml Programming: Correct + Efficient + Beautiful";
                            url = "https://cs3110.github.io/textbook/cover.html";
                            tags = [ "ocaml" "reading" "learning" ];
                          }
                          {
                            name = "OCaml Programming: Correct + Efficient + Beautiful (YouTube Playlist)";
                            url = "https://www.youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU";
                            tags = [ "ocaml" "learning" ];
                          }
                          {
                            name = "Real World OCaml";
                            url = "http://dev.realworldocaml.org/index.html";
                            tags = [ "ocaml" "learning" ];
                          }
                          {
                            name = "awesome-ocaml";
                            url = "https://github.com/ocaml-community/awesome-ocaml";
                            tags = [ "ocaml" "learning" ];
                          }
                          {
                            name = "Jane Street Open-Source";
                            url = "https://opensource.janestreet.com/";
                            tags = [ "ocaml" ];
                          }
                        ];
                      }
                      {
                        name = "Elm";
                        bookmarks = [
                          {
                            name = "Happiness in the Front-End Using Elm";
                            url = "https://www.youtube.com/watch?v=VJCP4_zgbPQ";
                            tags = [ "elm" "programming" "learning" ];
                          }
                        ];
                      }
                      {
                        name = "Elixir";
                        bookmarks = [
                          {
                            name = "Elixir";
                            url = "https://elixir-lang.org/";
                            tags = [ "elixir" "programming" ];
                          }
                          {
                            name = "Phoenix";
                            url = "https://www.phoenixframework.org/";
                            tags = [ "elixir" "programming" ];
                          }
                        ];
                      }
                    ];
                  }
                  {
                    name = "Htmx";
                    bookmarks = [
                      {
                        name = "Htmx";
                        url = "https://htmx.org";
                        tags = [ "htmx" "hypermedia" "programming" "web-development" ];
                      }
                      {
                        name = "Hypermedia Systems";
                        url = "https://hypermedia.systems/";
                        tags = [ "htmx" "hypermedia" "reading" "programming" "web-development" ];
                      }
                    ];
                  }
                  {
                    name = "YouTube Channels";
                    bookmarks = [
                      {
                        name = "Impure Pics";
                        url = "https://www.youtube.com/@impurepics";
                        tags = [ "videos" "programming" ];
                      }
                      {
                        name = "Tweag";
                        url = "https://www.youtube.com/@tweag";
                        tags = [ "videos" "programming" ];
                      }
                      {
                        name = "Tsoding";
                        url = "https://www.youtube.com/@Tsoding";
                        tags = [ "videos" "programming" ];
                      }
                      {
                        name = "Jesse Warden";
                        url = "https://www.youtube.com/@JesseWarden";
                        tags = [ "videos" "programming" ];
                      }
                    ];
                  }
                  {
                    name = "Helix";
                    bookmarks = [
                      {
                        name = "Helix";
                        url = "https://helix-editor.com/";
                        tags = [ "helix" ];
                      }
                    ];
                  }
                  {
                    name = "Git";
                    bookmarks = [
                      {
                        name = "Git Cheatsheet";
                        url = "https://education.github.com/git-cheat-sheet-education.pdf";
                        tags = [ "git" ];
                      }
                      {
                        name = "GitHub CLI";
                        url = "https://cli.github.com/";
                        tags = [ "git" "github" ];
                      }
                      {
                        name = "Keep a Changelog!";
                        url = "https://keepachangelog.com";
                        tags = [ "git" ];
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
          bitwarden
          ublock-origin
          duckduckgo-privacy-essentials
          privacy-badger
          sponsorblock
          clearurls
          istilldontcareaboutcookies
          terms-of-service-didnt-read
          user-agent-string-switcher
          don-t-fuck-with-paste
        ];
      };
    };
  };
}
