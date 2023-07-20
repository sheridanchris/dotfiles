{ config, pkgs, inputs, ...}: {
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
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = [];
        modules-right = ["clock" "tray"];

        "clock" = {
          "format" = "{: %a %B %d %G  %I:%M %p}";
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
            name = "Nix";
            bookmarks = [
              {
                name = "NixOS Wiki";
                url = "https://nixos.wiki/";
                tags = [ "nix" "nix-os" "wiki" ];
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
            ];
          }
          {
            name = "F#";
            bookmarks = [
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
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          duckduckgo-privacy-essentials
          privacy-badger
          sponsorblock
          clearurls
          istilldontcareaboutcookies
        ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    discord
    thunderbird
    gnome.nautilus
    bitwarden
    flameshot
    wofi
    wofi-emoji
    (kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [ netflix ]))
    easyeffects
    hyprpaper
    grim
    slurp
    dunst
  ];

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
      package = pkgs.hyprland;
      plugins = [ 
        split-monitor-workspaces
      ];
      extraConfig = ''
        exec-once = waybar
        exec-once = hyprpaper
        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        env = XCURSOR_SIZE,24
        env = WLR_NO_HARDWARE_CURSORS,1
        monitor = DP-1,1920x1080@144,0x0,1
        bind = SUPER, Q, killactive
        bind = SUPER, Space, togglefloating
        bind = SUPER_CONTROL_SHIFT, Q, exit
        bind = SUPER, Return, exec, alacritty
        bind = SUPER_SHIFT, Return, exec, nautilus
        bind = SUPER, O, exec, wofi --show drun
        bind = SUPER_SHIFT, W, exec, firefox
        bind = SUPER, Print, exec, grim -g "$(slurp)"
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
