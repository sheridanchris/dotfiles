{username, ...}: {
  imports = [
    ./git.nix
    ./vscode.nix
    ./helix.nix
  ];

  home-manager.users.${username} = {
    home.sessionVariables.EDITOR = "code";
  };
}
