{pkgs, ...}: {
  imports = [
    ./git.nix
    # ./helix.nix
    ./vscode.nix
    # ./neovim
  ];

  environment.systemPackages = with pkgs; [jetbrains.rider];
}
