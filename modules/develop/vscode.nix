{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      # TODO: configure extensions and user settings.
    };
  };
}
