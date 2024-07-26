{pkgs, ...}: {
  imports = [
    ./git.nix
    # ./helix.nix
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [jetbrains.rider];
}
