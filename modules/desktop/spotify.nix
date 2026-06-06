{
  pkgs,
  username,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  home-manager.users.${username} = {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle
        fullAppDisplay
      ];
    };
    stylix.targets.spicetify = {
      enable = true;
      colors.enable = true;
    };
  };
}
