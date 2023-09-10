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
    exa = {
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
    vscode = {
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
        catppuccin.catppuccin-vsc
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
      ];
      userSettings = {
        "workbench.iconTheme" = "vscode-icons";
        "gitlens.codelens.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.mouseWheelZoom" = true;
        "editor.fontSize" = 15;
        "editor.fontFamily" = "'CommitMono', 'JetBrains Mono', 'Font Awesome 6 Free', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "FSharp.inlayHints.enabled" = false;
        "FSharp.inlayHints.typeAnnotations" = false;
        "FSharp.inlayHints.parameterNames" = false;
        "haskell.manageHLS" = "PATH";
        "[fsharp]" = { "editor.defaultFormatter" = "ionide.ionide-fsharp"; };
      };
    };
    # TODO: Nix LSP ??
    # TODO: F# ??
    # TODO: Haskell ??
    # TODO: Figure out keybinds
    # TODO: Figure out which plugins need to be configured
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

        # Autocompletion
        luasnip
        nvim-cmp
        cmp-nvim-lsp
        cmp_luasnip
      ];
      extraPackages = with pkgs; [
        ripgrep # Required to search for selections in files.
        fsautocomplete # FSAC - Required for Ionide (F#)
        haskellPackages.haskell-debug-adapter # Required by Haskell-tools
      ];
      extraLuaConfig = ''
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          vim.opt.termguicolors = true

          vim.g.mapleader = ' '
          vim.g.maplocalleader = ' '

          -- formatting
          vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function(ev)
            vim.lsp.buf.format()
          end,
          })

          require('neo-tree').setup {
            window = {
              mappings = {
                ['l'] = "open"
              }
            }
          }
          require('nvim-web-devicons').setup()
          require('lualine').setup()


          vim.cmd([[
            nnoremap <silent> <F2> <CMD>NeoTreeFloatToggle<CR>
            tnoremap <silent> <F2> <C-\><C-n><CMD>NeoTreeFloatToggle<CR>
            nnoremap <silent> <F1> <CMD>FloatermToggle<CR>
            tnoremap <silent> <F1> <C-\><C-n><CMD>FloatermToggle<CR>
          ]])

          require('catppuccin').setup({
            flavour = "mocha"
          })
          require('kanagawa').setup({
            theme = "dragon",
            background = {
              dark = "dragon",
              light = "lotus"
            },
          })

          require('zen-mode').setup({
            window = {
              width = 90,
              options = {
                number = true,
                relativenumber = true
              }
          }
          })

          require('telescope').setup()
          pcall(require('telescope').load_extension, 'fzf')
          do 
            local tsb = require('telescope.builtin')
            vim.keymap.set('n', '<leader>?'      , tsb.oldfiles   , { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', tsb.buffers    , { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>sf'     , tsb.find_files , { desc = '[SF] Search Files' })
            vim.keymap.set('n', '<leader>sF'     , tsb.git_files  , { desc = '[SF] Search Git Files' })
            vim.keymap.set('n', '<leader>sh'     , tsb.help_tags  , { desc = '[SH] Search Help' })
            vim.keymap.set('n', '<leader>sg'     , tsb.live_grep  , { desc = '[SG] Search by Grep' })
            vim.keymap.set('n', '<leader>sd'     , tsb.diagnostics, { desc = '[SD] Search Diagnostics' })
            vim.keymap.set('n', '<leader>sr'     , tsb.registers  , { desc = '[SR] Search Registers' })

          -- Configure Treesitter
          require('nvim-treesitter.configs').setup {
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
              },
            },
          }

          vim.keymap.set('n', '<leader>/', function()
            tsb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              previewer = false,
            })
            end, { desc = '[/] Fuzzily search in current buffer' })
          end

          vim.keymap.set('n', '<leader>zz', function()
            require('zen-mode').toggle()
          end)

          vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
          vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

          vim.o.background = 'dark'
          vim.cmd.colorscheme 'kanagawa'

          vim.opt.nu = true
          vim.opt.relativenumber = true
          vim.opt.tabstop = 4
          vim.opt.softtabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = true
          vim.opt.smartindent = true
          vim.opt.wrap = false
          vim.opt.hlsearch = false
          vim.opt.incsearch = true

          -- Configure Auto Complete
          local cmp = require('cmp')
          local luasnip = require('luasnip')

          luasnip.config.setup {}

          cmp.setup {
            snippet = {
              expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
            },
          mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          },
        }

        -- Haskell tools configuration

        local ht = require('haskell-tools')
        local def_opts = { noremap = true, silent = true, }
        ht.start_or_attach {
          hls = {
            on_attach = function(client, bufnr)
              local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
              -- haskell-language-server relies heavily on codeLenses,
              -- so auto-refresh (see advanced configuration) is enabled by default
              vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
              vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
              vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
            end,
          },
        }

        -- Suggested keymaps that do not depend on haskell-language-server:
        local bufnr = vim.api.nvim_get_current_buf()
        -- set buffer = bufnr in ftplugin/haskell.lua
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Toggle a GHCi repl for the current package
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        -- Toggle a GHCi repl for the current buffer
        vim.keymap.set('n', '<leader>rf', function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(0))
        end, def_opts)

        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        ht.dap.discover_configurations(bufnr)

        -- LSP Configuration
        -- Setup language servers.
        local lspconfig = require('lspconfig')

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)
        end,
        })
      '';
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
          # TODO: Tech Talks
          # https://www.youtube.com/watch?v=QyJZzq0v7Z4
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
                {
                  name = "Nix.dev";
                  url = "https://nix.dev/";
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
                  name = "Neovim Configuration (typecraft)";
                  url = "https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcALR";
                  tags = [ "vim" "learning" ];
                }
                {
                  name = "Vim Cheatsheet";
                  url = "https://devhints.io/vim";
                  tags = [ "vim" ];
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
    i3status = {
      enable = true;
      modules = {
        "wireless wlan0" = {
          position = 1;
          settings = {
            format_up = "W: (%quality at %essid, %bitrate) %ip";
            format_down = "W: down";
          };
        };
        "tztime local" = {
          position = 2;
          settings = {
            format = "%Y-%m-%d %H:%M:%S";
          };
        };
        "memory" = {
          position = 3;
          settings = {
            format = "%used";
            threshold_degraded = "10%";
            format_degraded = "MEMORY: %free";
          };
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
    wl-clipboard
    clipman
    btop
    lazydocker
    rofi
    flameshot
    prismlauncher
    ngrok
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
            { command = "feh --bg-fill ~/.backgrounds/nixos.png"; }
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
