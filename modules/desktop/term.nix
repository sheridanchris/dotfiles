{
  config,
  pkgs,
  username,
  lib,
  inputs,
  ...
}: {
  users.users.${username}.shell = pkgs.zsh;

  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        import = ["${inputs.catppuccin-alacritty}/catppuccin-mocha.toml"];
        # shell.program = "zsh";
        shell.program = "nu";
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
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      # initExtra = "fortune | cowsay";
    };
    programs.nushell = {
      enable = true;
      shellAliases = let
        git = lib.getExe pkgs.git;
      in {
        ga = "${git} add";
        gc = "${git} commit";
        gs = "${git} status";
        gl = "${git} log";
        gp = "${git} push origin main";
      };
    };
    programs.starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings =
        {
          format = "$all";
          palette = "catppuccin_mocha";
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        }
        // builtins.fromTOML (builtins.readFile
          "${inputs.catppuccin-starship}/themes/mocha.toml");
    };

    programs.eza = {
      enable = true;
      git = true;
      icons = true;
      enableZshIntegration = true;
      # enableNushellIntegration = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    xdg.configFile."btop/themes/catppuccin_mocha.theme".source = "${inputs.catppuccin-btop}/themes/catppuccin_mocha.theme";
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha.theme";
      };
    };
  };
}
