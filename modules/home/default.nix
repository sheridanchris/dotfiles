{ config, pkgs, lib, ... }: {
  imports = [
    ./base
    ./develop
    ./browser
  ];
}
