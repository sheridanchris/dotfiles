{ config, pkgs, lib, inputs, ... }: {
  imports = [ ];

  home = {
    username = "christian";
    homeDirectory = "/home/christian";
    stateVersion = "23.05";
  };

  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
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
    lazygit.enable = true;
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
    };
    eza = {
      enable = true;
      git = true;
      icons = true;
      enableAliases = true;
    };
    alacritty = {
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
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ ];
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        zen-mode-nvim
        undotree
        plenary-nvim
        nui-nvim
        lualine-nvim
        barbar-nvim
        vim-floaterm
        todo-comments-nvim

        # File Tree
        neo-tree-nvim
        nvim-web-devicons

        # Color Scheme
        gruvbox-nvim
        catppuccin-nvim
        kanagawa-nvim

        # Nix Integration
        direnv-vim

        # Git
        vim-fugitive
        gitsigns-nvim

        # Treesitter
        nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        nvim-treesitter-textobjects

        # Telescope
        telescope-nvim
        telescope-fzf-native-nvim

        # Language Support
        nvim-lspconfig
        nvim-dap
        Ionide-vim
        haskell-tools-nvim
        vim-nix

        # Autocompletion
        luasnip
        nvim-cmp
        cmp-nvim-lsp
        cmp_luasnip
      ];
      extraPackages = with pkgs; [
        ripgrep
        fsautocomplete
        haskellPackages.haskell-debug-adapter
        rnix-lsp
        lua-language-server
      ];
      extraLuaConfig = lib.fileContents ../../config/neovim/init.lua;
    };
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
                    {
                      name = "Nix.dev";
                      url = "https://nix.dev/";
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
                      name = "Excercism";
                      url = "https://exercism.org/";
                      tags = [ "programming" "learning" ];
                    }
                    {
                      name = "Category Theory for Programmers";
                      url = "https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/";
                      tags = [ "category-theory" "reading" "functional-programming" ];
                    }
                    {
                      name = "Every Clojure Talk Ever";
                      url = "https://www.youtube.com/watch?v=jlPaby7suOc";
                      tags = [ "clojure" "parody" ];
                    }
                    {
                      name = "ARIA Authoring Practices Guide";
                      url = "https://www.w3.org/WAI/ARIA/apg/";
                      tags = [ "web-development" "accessibility" ];
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
                  name = "Vim";
                  bookmarks = [
                    {
                      name = "0 to LSP : Neovim RC From Scratch";
                      url = "https://www.youtube.com/watch?v=w7i4amO_zaE";
                      tags = [ "vim" "learning" ];
                    }
                    {
                      name = "Effective Neovim: Instant IDE";
                      url = "https://www.youtube.com/watch?v=stqUbv-5u2s";
                      tags = [ "vim" "learning" ];
                    }
                    {
                      name = "Neovim Configuration (typecraft)";
                      url = "https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcALR";
                      tags = [ "vim" "learning" ];
                    }
                    {
                      name = "Vim Cheatsheet";
                      url = "https://devhints.io/vim";
                      tags = [ "vim" ];
                    }
                    {
                      name = "Vim Colorschemes";
                      url = "https://vimcolorschemes.com/";
                      tags = [ "vim" ];
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
    gnome.nautilus
    bitwarden
    (kodi.withPackages (kodiPkgs: with kodiPkgs; [ netflix ]))
    easyeffects
    dunst
    mpv
    yt-dlp
    obsidian
    btop
    lazydocker
    rofi
    flameshot
    prismlauncher
    ngrok
    libreoffice
    element-desktop
    entr
    slack
  ];

  xsession.windowManager.i3 =
    {
      enable = true;
      config =
        let
          modifier = "Mod4";
        in
        {
          modifier = modifier;
          startup = [
            { command = "xrandr --output DP-0 --primary --mode 1920x1080 --rate 144.00"; }
            { command = "thunderbird"; }
            { command = "feh --bg-fill ~/.backgrounds/wallpaper.png"; }
          ];
          window = {
            titlebar = false;
          };
          gaps = {
            inner = 10;
            outer = 0;
            smartGaps = true;
          };
          keybindings = lib.mkOptionDefault
            {
              "${modifier}+q" = "kill";

              "${modifier}+Return" = "exec alacritty";
              "${modifier}+Shift+Return" = "exec nautilus";
              "${modifier}+o" = "exec rofi -show drun";
              "${modifier}+Shift+w" = "exec firefox";
              "${modifier}+p" = "exec alacritty --command btop";
              "${modifier}+Print" = "exec flameshot gui";

              "${modifier}+h" = "focus left";
              "${modifier}+j" = "focus down";
              "${modifier}+k" = "focus up";
              "${modifier}+l" = "focus right";

              "${modifier}+Shift+h" = "move left";
              "${modifier}+Shift+j" = "move down";
              "${modifier}+Shift+k" = "move up";
              "${modifier}+Shift+l" = "move right";
            };
        };
    };
}
