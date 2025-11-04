{username, ...}: {
  imports = [
    ./git.nix
    ./helix.nix
    ./vscode.nix
  ];

  # environment.sessionVariables.EDITOR = "hx";

  home-manager.users.${username} = {
    home.sessionVariables.EDITOR = "hx";
  };
}
