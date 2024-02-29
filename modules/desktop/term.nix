{
  config,
  pkgs,
  username,
  lib,
  inputs,
  ...
}: let
  theme =
    pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "ce476fb41f307d90f841c1a4fd7f0727c21248b2";
      sha256 = "sha256-bpHznCqkNMbauDQjh98qj2+r1V8mXQIVmvKTldLcln0=";
    }
    + /catppuccin-mocha.toml;
in {
  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        import = ["${theme}"];
        shell.program = "zsh";
        font = {
          size = 15;
          normal = {
            family = "CommitMono";
          };
        };
      };
    };
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings =
        {
          format = "$all";
          palette = "catppuccin_mocha";
        }
        // builtins.fromTOML (builtins.readFile
          (pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "starship";
              rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
              sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
            }
            + /palettes/mocha.toml));
    };

    programs.eza = {
      enable = true;
      git = true;
      icons = true;
      enableAliases = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    xdg.configFile."btop/themes/catppuccin_mocha.theme".source =
      pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "btop";
        rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
        sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
      }
      + /themes/catppuccin_mocha.theme;

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha.theme";
      };
    };
  };
}
