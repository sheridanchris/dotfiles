{ config, pkgs, lib, inputs, ... }:
let
  catppuccin = {
    flavor = "mocha";
    flavorTitleCase = "Mocha";
    accent = "pink";
    accentTitleCase = "Pink";
  };
in
{
  # TODO: Catppuccin Icons

  home = {
    username = "christian";
    homeDirectory = "/home/christian";
    stateVersion = "23.05";

    # TODO: this does not work.
    pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaSky;
      name = "Catppuccin-${catppuccin.flavorTitleCase}-Sky";
      size = 24;
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ catppuccin.accent ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = catppuccin.flavor;
      };
      name = "Catppuccin-${catppuccin.flavorTitleCase}-Compact-${catppuccin.accentTitleCase}-Dark";
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        accent = catppuccin.accent;
        flavor = catppuccin.flavor;
      };
      name = "Papirus-cat-${catppuccin.flavor}-${catppuccin.accent}";
    };
  };

  # TODO: Catppuccin
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "Adwaita-dark";
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs = {
    home-manager.enable = true;
    feh.enable = true;
    zathura.enable = true;
    lazygit.enable = true; # TODO: Catppuccin
    git = {
      enable = true;
      userName = "sheridanchris";
      userEmail = "christiansheridan@outlook.com";
    };
    gh = {
      enable = true;
      extensions = [ pkgs.gh-dash ];
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        eval "$(direnv hook zsh)"
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$all";
        palette = "catppuccin_${catppuccin.flavor}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${catppuccin.flavor}.toml));
    };
    eza = {
      enable = true;
      git = true;
      icons = true;
      enableAliases = true;
    };
    alacritty =
      let
        theme =
          pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "alacritty";
              rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
              sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
            };
      in
      {
        enable = true;
        settings = {
          import = [ "${theme}/catppuccin-${catppuccin.flavor}.yml" ];
          shell = {
            program = "zsh";
          };
          font = {
            size = 15;
            normal = {
              family = "CommitMono";
            };
          };
          window = {
            opactiy = 0.8;
          };
        };
      };
    rofi = {
      enable = true;
      extraConfig = {
        modi = "run";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "alacritty";
        drun-display-format = "{icon} {name}";
        location = 0;
        hide-scrollbar = true;
        display-drun = "  Apps ";
        sidebar-mode = true;
      };
      theme = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "rofi";
          rev = "5350da41a11814f950c3354f090b90d4674a95ce";
          sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
        } + /basic/.local/share/rofi/themes/catppuccin-${catppuccin.flavor}.rasi;
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ ];
    };
    helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.system}.default;
      defaultEditor = true;
      settings = {
        theme = "catppuccin_${catppuccin.flavor}";
        editor = {
          mouse = false;
          cursorline = true;
          true-color = true;
          color-modes = true;
          line-number = "relative";
          bufferline = "always";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          C-j = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
          C-k = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
        };
      };
    };
    # TODO: Catppuccin?
    firefox = {
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
  };

  home.packages = with pkgs; [
    discord
    thunderbird
    cinnamon.nemo
    bitwarden
    (kodi.withPackages (kodiPkgs: with kodiPkgs; [ netflix ]))
    easyeffects
    feh
    xdo
    flameshot
    mpv
    yt-dlp
    btop
    lazydocker
    prismlauncher
    ngrok
    libreoffice
    element-desktop
    entr
    slack
    slides
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      DP-0 = [ "1" "2" "3" "4" "5" ];
    };
    rules = {
      "Firefox" = {
        desktop = "^1";
        follow = true;
      };
      "Discord" = {
        desktop = "^4";
        follow = true;
      };
    };
    settings = {
      border_width = 2;
      gapless_monocle = true;
      split_ratio = 0.52;
    };
    startupPrograms = [
      "xrandr --output DP-0 --primary --mode 1920x1080 --rate 144.00"
      "feh --bg-fill ~/dotfiles/wallpapers/wallpaper.png"
      "polybar"
    ];
  };
  services = {
    # TODO: Catppuccin
    dunst =
      let
        theme = pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "dunst";
            rev = "a72991e56338289a9fce941b5df9f0509d2cba09";
            sha256 = "sha256-1LeSKuZcuWr9z6mKnyt1ojFOnIiTupwspGrOw/ts8Yk=";
          } + /src/${catppuccin.flavor}.conf;
      in
      {
        enable = true;
      };
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "super + o" = "rofi -show drun";

        # Bspwm Keybindings
        "super + q" = "xdo close && bspunhide";
        "super + shift + q" = "bspc wm -r";
        "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
        "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";
        "super + {0-9}" = "bspc desktop -f {0-9}";
        "super + shift + {0-9}" = "bspc node -d {0-9} && bspunhide";
        "super + f" = "bspfullscreen";
        "super + space" = "bspc node focused.tiled -t floating || bspc node focused.floating -t tiled";
      };
    };

    # TODO: Catppuccin
    polybar =
      let
        colorsConfig =
          pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "polybar";
              rev = "9ee66f83335404186ce979bac32fcf3cd047396a";
              sha256 = "sha256-bUbSgMg/sa2faeEUZo80GNmhOX3wn2jLzfA9neF8ERA=";
            } + /themes/${catppuccin.flavor}.ini;
      in
      {
        enable = true;
        settings = {
          "global/wm" = {
            include-file = "${colorsConfig}";
          };

          "bar/top" = {
            monitor = "DP-0";
            width = "100%";
            height = "3%";
            radius = 0;
            background = "\${colors.base}";
            border-color = "\${colors.crust}";
            foreground = "\${colors.surface0}";
            modules-left = "bspwm";
            modules-center = "window";
            modules-right = "cpu memory date";
            module-margin-right = 2;
            padding-left = 1;
            padding-right = 1;

            font-0 = "CommitMono:size=12";
            font-1 = "JetBrainsMono Nerd Font:size=12";
            font-2 = "Font Awesome 6 Free Solid:style=Solid:pixelsize=12";
            font-3 = "Font Awesome 6 Free Regular:style=Regular:pixelsize=12";
            font-4 = "Font Awesome 6 Brands:style=Regular:pixelsize=12";
          };

          "module/bspwm" = {
            type = "internal/bspwm";
            enable-click = false;
            enable-scroll = false;
            #format-background = "\${colors.green}";
            ws-icon-default = "";

            label-focused = "%icon%";
            label-focused-foreground = "\${colors.teal}";
            #label-focused-background = "\${colors.mantle}";
            label-focused-padding = 1;
            #label-focused-underline = "";

            label-occupied = "%icon%";
            label-occupied-foreground = "\${colors.flamingo}";
            label-occupied-padding = 1;
            #label-occupied-underline = "";

            label-urgent = "%icon%";
            label-urgent-foreground = "\${colors.red}";
            label-urgent-padding = 1;
            #label-urgent-background = "";
            #label-urgent-underline = "";

            label-empty = "%icon%";
            label-empty-foreground = "\${colors.text}";
            label-empty-padding = 1;
          };
          "module/window" = {
            type = "internal/xwindow";
            format = "<label>";
            format-foreground = "\${colors.text}";

            label = "%title%";
            label-empty = "No Active Window";
          };
          "module/cpu" = {
            type = "internal/cpu";
            interval = 1;
            warn-percentage = 90;
            label = " %percentage%%";
            label-foreground = "\${colors.text}";
            label-warn = " %percentage%%";
            label-warn-foreground = "\${colors.text}";
          };
          "module/memory" = {
            type = "internal/memory";
            interval = 1;
            warn-percentage = 90;
            label = " %gb_used%/%gb_total%";
            label-foreground = "\${colors.text}";
            label-warn = " %gb_used%/%gb_total%";
            label-warn-foreground = "\${colors.text}";
          };
          "module/date" = {
            type = "internal/date";
            interval = 1.0;
            date = "%m-%d-%Y";
            time = "%H:%M";
            format = "<label>";
            label = " %date% %time%";
            label-foreground = "\${colors.text}";
          };
        };
        script = "";
      };
  };
}
