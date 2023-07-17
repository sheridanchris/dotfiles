{ config, pkgs, ...}: {
  home.username = "christian";
  home.homeDirectory = "/home/christian";

  programs.home-manager.enable = true;
  #programs.vscode.enable = true;

  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
  };

  programs.zsh = {
    enable = true;
    #enableAutoSuggestions = true;
    #enableSyntaxHighlighting = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
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
