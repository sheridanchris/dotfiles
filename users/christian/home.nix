{ config, pkgs, ...}: {
  home.username = "christian";
  home.homeDirectory = "/home/christian";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "zsh";
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ionide.ionide-fsharp
      bbenoist.nix
      eamodio.gitlens
      vscode-icons-team.vscode-icons
    ];
  };

  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    discord
    firefox
  ];
 
  home.stateVersion = "23.05";
}
