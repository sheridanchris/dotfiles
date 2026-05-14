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
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle
        fullAppDisplay
      ];
    };
  };
}
