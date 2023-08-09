{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  home.username = "christian";
  home.homeDirectory = "/home/christian";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
  };

  programs.exa = {
    enable = true;
    git = true;
    icons = true;
    enableAliases = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "zsh";
      };
      font = {
        size = 15;
        normal = {
          family = "JetBrains Mono";
        };
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ionide.ionide-fsharp
      bbenoist.nix
      eamodio.gitlens
      vscode-icons-team.vscode-icons
      mkhl.direnv
      ms-azuretools.vscode-docker
      haskell.haskell
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-template-fsharp-highlight";
        publisher = "alfonsogarciacaro";
        version = "1.7.0";
        sha256 = "sha256-yht+l6PcGK1w+xShv6psrQ4WP1pV7B5ALSyTqn9oE6g=";
      }
      {
        name = "vscode-nuget-gallery";
        publisher = "patcx";
        version = "0.0.24";
        sha256 = "sha256-qinjKSc0890V/uNGhd23pcY05WxWRWEGO4yjMIpMj70=";
      }
      {
        name = "discord-vscode";
        publisher = "icrawl";
        version = "5.8.0";
        sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
      }
    ];
    userSettings = {
      "workbench.iconTheme" = "vscode-icons";
      "gitlens.codelens.enabled" = true;
      "editor.formatOnSave" = true;
      "editor.mouseWheelZoom" = true;
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'JetBrains Mono', 'Font Awesome 6 Free', 'monospace', monospace";
      "FSharp.inlayHints.enabled" = false;
      "FSharp.inlayHints.typeAnnotations" = false;
      "FSharp.inlayHints.parameterNames" = false;
      "haskell.manageHLS" = "PATH";
      "[fsharp]" = { "editor.defaultFormatter" = "ionide.ionide-fsharp"; };
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar-hyprland;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "DP-1" ];
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "clock" "tray" ];

        "clock" = {
          "format" = "{:%a %B %d %G %I:%M %p}";
        };
      }
    ];
    style = ''
      * {
        font-family: Source Code Pro;
        font-size: 13px;
      }
      
      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }

      #workspaces button {
        padding: 0 5px;
        color: #ffffff;
      }

      #workspaces button:hover {
        background-color: #2986cc;
      }

      #workspaces button.active {
        background-color: #2986cc;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #window,
      #workspaces,
      #clock,
      #tray {
        padding: 0 10px;
        color: #ffffff;
      }
    '';
  };

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
            name = "Feedly";
            url = "https://feedly.com/";
            tags = [ "reading" ];
          }
          {
            name = "Nix";
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
            ];
          }
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
            ];
          }
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
                name = "Hoogle";
                url = "https://hoogle.haskell.org/";
                tags = [ "haskell" "programming" "docs" ];
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
                name = "OCaml Programming: Correct + Efficient + Beautiful";
                url = "https://cs3110.github.io/textbook/cover.html";
                tags = [ "ocaml" "reading" "learning" ];
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
            name = "Fancy Stuff";
            bookmarks = [
              {
                name = "Category Theory for Programmers";
                url = "https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/";
                tags = [ "category-theory" "reading" ];
              }
              {
                name = "Every Clojure Talk Ever";
                url = "https://www.youtube.com/watch?v=jlPaby7suOc";
                tags = [ "clojure" "parody" ];
              }
            ];
          }
          {
            name = "Hyprland";
            bookmarks = [
              {
                name = "Hyprland";
                url = "https://hyprland.org/";
                tags = [ "hyprland" ];
              }
              {
                name = "Hyprland Repo";
                url = "https://github.com/hyprwm/Hyprland";
                tags = [ "hyprland" "github-repo" ];
              }
              {
                name = "Awesome Hyprland";
                url = "https://github.com/hyprland-community/awesome-hyprland";
                tags = [ "hyprland" "awesome" "linux" ];
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };

  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
    };
  };

  home.packages =
    # TODO: This program results in an error, need to fix.
    let
      xwaylandvideobridge = pkgs.stdenv.mkDerivation {
        pname = "xwaylandvideobridge";
        version = "2023-08-02-git";

        # https://github.com/KDE/xwaylandvideobridge
        src = pkgs.fetchFromGitHub {
          owner = "KDE";
          repo = "xwaylandvideobridge";
          rev = "5103ac";
          sha256 = "sha256-nvhpxNxOye5iIBnW5H4bYs/FZFweWpOPLByoA5esFEQ=";
        };

        nativeBuildInputs = with pkgs; [
          cmake
          extra-cmake-modules
          libsForQt5.kdoctools
          libsForQt5.qt5.wrapQtAppsHook
        ];

        buildInputs = with pkgs; [
          libsForQt5.qt5.qtx11extras
          libsForQt5.kio
          (libsForQt5.kpipewire.overrideAttrs (oldAttrs: {
            version = "5.27.7";
            src = pkgs.fetchFromGitHub {
              owner = "KDE";
              repo = "kpipewire";
              rev = "92778d5";
              sha256 = "sha256-Ec/YWgrHt7lVKXS2Nb5yjesVpJ0FSwuBqAnbIS+bviU=";
            };
          }))
        ];

        patches = [
          (
            pkgs.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/cursor-mode.patch?h=xwaylandvideobridge-cursor-mode-2-git";
              sha256 = "sha256-649kCs3Fsz8VCgGpZ952Zgl8txAcTgakLoMusaJQYa4=";
            }
          )
        ];
      };
    in
    with pkgs; [
      discord
      thunderbird
      gnome.nautilus
      bitwarden
      (kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [ netflix ]))
      easyeffects
      hyprpaper
      grim
      slurp
      dunst
      mpv
      yt-dlp
      obsidian
      wl-clipboard
      clipman
      btop
      xwaylandvideobridge
    ];

  programs.wofi = {
    enable = true;
    # This style.css was yoinked and modified from:
    # https://github.com/lokesh-krishna/dotfiles/blob/main/tokyo-night/config/wofi/style.css
    style = ''
      window {
        margin: 0px;
        border: 2px solid #48494E;
        border-radius: 5px;
        background-color: #000000;
        font-family: monospace;
        font-size: 12px;
      }
    
      #input {
        margin: 5px;
        border: 1px solid #000000;
        color: #ffffff;
        background-color: #000000;
      }

      #input image {
          color: #ffffff;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #000000;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #000000;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ffffff;
      } 

      #entry:selected {
          background-color: #334FCE;
          font-weight: normal;
      }

      #text:selected {
          background-color: #334FCE;
          font-weight: normal;
      }
    '';
  };

  wayland.windowManager.hyprland =
    let
      split-monitor-workspaces = pkgs.stdenv.mkDerivation {
        pname = "split-monitor-workspaces";
        version = "0.1";

        src = pkgs.fetchFromGitHub {
          owner = "Duckonaut";
          repo = "split-monitor-workspaces";
          rev = "44785ce";
          sha256 = "XxcUPMqytWItOmre7MV1XAhx/i2uyBbjHMKr5+B0IPE=";
        };

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [ pkgs.hyprland ] ++ pkgs.hyprland.buildInputs;

        buildPhase = ''
          export HYPRLAND_HEADERS=${pkgs.hyprland.src}
          make all
        '';

        installPhase = ''
          mkdir -p $out/lib
          cp split-monitor-workspaces.so $out/lib/libsplit-monitor-workspaces.so
        '';
      };
    in
    {
      enable = true;
      plugins = [ split-monitor-workspaces ];
      extraConfig = ''
        exec-once = waybar
        exec-once = hyprpaper
        exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = wl-paste -t text --watch clipman store --no-persist
        exec-once = xwaylandvideobridge
        env = XCURSOR_SIZE,24
        windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
        monitor = DP-1,1920x1080@144,0x0,1
        bind = SUPER, Q, killactive
        bind = SUPER, Space, togglefloating
        bind = SUPER_CONTROL_SHIFT, Q, exit
        bind = SUPER, Return, exec, alacritty
        bind = SUPER_SHIFT, Return, exec, nautilus
        bind = SUPER, P, exec, alacritty --command btop
        bind = SUPER, O, exec, wofi --show drun
        bind = SUPER, C, exec, clipman pick -t wofi
        bind = SUPER_SHIFT, W, exec, firefox
        bind = SUPER, Print, exec, grim -g "$(slurp)" | wl-copy
        bind = SUPER, 1, split-workspace, 1
        bind = SUPER, 2, split-workspace, 2
        bind = SUPER, 3, split-workspace, 3
        bind = SUPER, 4, split-workspace, 4
        bind = SUPER, 5, split-workspace, 5
        bind = SUPER, 6, split-workspace, 6
        bind = SUPER, 7, split-workspace, 7
        bind = SUPER, 8, split-workspace, 8
        bind = SUPER, 9, split-workspace, 9
        bind = SUPER, 0, split-workspace, 10
        bind = SUPER_SHIFT, 1, split-movetoworkspacesilent, 1
        bind = SUPER_SHIFT, 2, split-movetoworkspacesilent, 2
        bind = SUPER_SHIFT, 3, split-movetoworkspacesilent, 3
        bind = SUPER_SHIFT, 4, split-movetoworkspacesilent, 4
        bind = SUPER_SHIFT, 5, split-movetoworkspacesilent, 5
        bind = SUPER_SHIFT, 6, split-movetoworkspacesilent, 6
        bind = SUPER_SHIFT, 7, split-movetoworkspacesilent, 7
        bind = SUPER_SHIFT, 8, split-movetoworkspacesilent, 8
        bind = SUPER_SHIFT, 9, split-movetoworkspacesilent, 9
        bind = SUPER_SHIFT, 0, split-movetoworkspacesilent, 10
      '';
    };

  home.stateVersion = "23.05";
}
