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
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.guides.bracketPairsHorizontal" = true;

        "FSharp.inlayHints.parameterNames" = false;
        "FSharp.inlayHints.typeAnnotations" = false;
        "FSharp.pipelineHints.enabled" = false;
      };
    };
    stylix.targets.vscode = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };
}
