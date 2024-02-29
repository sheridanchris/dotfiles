{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
    ../../modules/develop
    ../../modules/runtimes
    ../../modules/virtualisation
  ];
}
