{username, ...}: {
  imports = [
    ./git.nix
    ./vscode.nix
  ];

  home-manager.users.${username} = {
    home.sessionVariables.EDITOR = "hx";
  };
}
