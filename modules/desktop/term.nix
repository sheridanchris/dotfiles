{
  config,
  pkgs,
  username,
  lib,
  inputs,
  ...
}: {
  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        import = ["${inputs.catppuccin-alacritty}/catppuccin-mocha.toml"];
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
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        }
        // builtins.fromTOML (builtins.readFile
          "${inputs.catppuccin-starship}/palettes/mocha.toml");
    };

    programs.eza = {
      enable = true;
      git = true;
      icons = true;
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
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
