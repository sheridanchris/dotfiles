{
  username,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs username;};
    backupFileExtension = "backup";
    users.${username} = {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
        inputs.catppuccin.homeModules.catppuccin
      ];
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "23.05";
      };

      programs.home-manager.enable = true;
    };
  };
}
