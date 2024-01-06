{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nix.nix
    ./fonts.nix
  ];
}
