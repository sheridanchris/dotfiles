{
  username,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs username;};
    backupFileExtension = "backup";
    users.${username} = {
      imports = [
        inputs.stylix.homeModules.stylix
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
