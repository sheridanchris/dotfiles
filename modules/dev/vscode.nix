{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      profiles.default.userSettings = {
        "editor.mouseWheelZoom" = true;
        "editor.semanticHighlighting.enabled" = true;
      };
    };
    stylix.targets.vscode = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };
}
