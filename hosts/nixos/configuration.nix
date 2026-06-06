{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
    ../../modules/dev
    ../../modules/virtualisation
  ];
}
