{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    # TODO: configure extensions and user settings.
  };
}
