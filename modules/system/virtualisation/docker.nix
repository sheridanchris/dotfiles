{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  virtualisation.docker.enable = true;
  users.users.christian.extraGroups = ["docker"];
}
