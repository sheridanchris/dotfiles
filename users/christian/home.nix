{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

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
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
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
        #arrterian.nix-env-selector
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
        {
          name = "marksman";
          publisher = "arr";
          version = "0.3.3";
          sha256 = "sha256-x+u2AD4uQAWvSAi3+ZzC8mLUfDntxOwBW67uiZfsgAQ=";
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
    wofi = {
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
    waybar = {
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

    # TODO: Figure out which plugins need configuring
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
      # TODO: Should I Include `fsautocomplete`?
      # or should that be included in individual development flakes?
      extraPackages = with pkgs; [ ripgrep ];
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
  };

  home.packages =
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
      amberol
      jetbrains.rider
      xwaylandvideobridge
    ];

  wayland.windowManager.hyprland =
    {
      enable = true;
      enableNvidiaPatches = true;
      xwayland.enable = true;
      plugins = [ inputs.hy3.packages.x86_64-linux.hy3 ];
      extraConfig = ''
        general {
            layout = hy3
            gaps_in = 0
            gaps_out = 0
        }

        decoration {
            #rounding = 10
            blur {
                enabled = true
                size = 3
                passes = 1
                new_optimizations = true
            }
        }

        exec-once = waybar
        exec-once = hyprpaper
        exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = wl-paste -t text --
        watch clipman store --no-persist
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
        bind = SUPER, Print, exec, grim -g "$(slurp)"

        # Move focus with super + arrow keys, hjkl
        bind = SUPER, left, hy3:movefocus, l
        bind = SUPER, h, hy3:movefocus, l
        bind = SUPER, right, hy3:movefocus, r
        bind = SUPER, l, hy3:movefocus, r
        bind = SUPER, up, hy3:movefocus, u
        bind = SUPER, k, hy3:movefocus, u
        bind = SUPER, down, hy3:movefocus, d
        bind = SUPER, j, hy3:movefocus, d

        # Move window positions with super + arrow keys, hjkl
        bind = SUPER_SHIFT, left, hy3:movewindow, l
        bind = SUPER_SHIFT, h, hy3:movewindow, l
        bind = SUPER_SHIFT, right, hy3:movewindow, r
        bind = SUPER_SHIFT, l, hy3:movewindow, r
        bind = SUPER_SHIFT, up, hy3:movewindow, u
        bind = SUPER_SHIFT, k, hy3:movewindow, u
        bind = SUPER_SHIFT, down, hy3:movewindow, d
        bind = SUPER_SHIFT, j, hy3:movewindow, d

        bind = SUPER, 1, workspace, 1
        bind = SUPER, 2, workspace, 2
        bind = SUPER, 3, workspace, 3
        bind = SUPER, 4, workspace, 4
        bind = SUPER, 5, workspace, 5
        bind = SUPER, 6, workspace, 6
        bind = SUPER, 7, workspace, 7
        bind = SUPER, 8, workspace, 8
        bind = SUPER, 9, workspace, 9
        bind = SUPER, 0, workspace, 10
        bind = SUPER_SHIFT, 1, movetoworkspace, 1
        bind = SUPER_SHIFT, 2, movetoworkspace, 2
        bind = SUPER_SHIFT, 3, movetoworkspace, 3
        bind = SUPER_SHIFT, 4, movetoworkspace, 4
        bind = SUPER_SHIFT, 5, movetoworkspace, 5
        bind = SUPER_SHIFT, 6, movetoworkspace, 6
        bind = SUPER_SHIFT, 7, movetoworkspace, 7
        bind = SUPER_SHIFT, 8, movetoworkspace, 8
        bind = SUPER_SHIFT, 9, movetoworkspace, 9
        bind = SUPER_SHIFT, 0, movetoworkspace, 10
      '';
    };
}
