{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./docker.nix
    ./libvirtd.nix
  ];
}
