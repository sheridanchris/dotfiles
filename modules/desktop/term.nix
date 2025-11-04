{
  pkgs,
  username,
  lib,
  ...
}: {
  users.users.${username}.shell = pkgs.zsh;

  home-manager.users.${username} = {
    catppuccin.alacritty.enable = true;
    catppuccin.alacritty.flavor = "mocha";

    programs.alacritty = {
      enable = true;
      settings = {
        terminal.shell.program = "zsh";
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
    };
    # programs.nushell = {
    #   enable = true;
    #   shellAliases = let
    #     git = lib.getExe pkgs.git;
    #   in {
    #     ga = "${git} add";
    #     gc = "${git} commit";
    #     gs = "${git} status";
    #     gl = "${git} log";
    #     gp = "${git} push origin main";
    #   };
    # };
    catppuccin.starship.enable = true;
    catppuccin.starship.flavor = "mocha";
    programs.starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        format = "$all";
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    catppuccin.yazi.enable = true;
    catppuccin.yazi.flavor = "mocha";
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    catppuccin.btop.enable = true;
    catppuccin.btop.flavor = "mocha";
    programs.btop.enable = true;
  };
}
