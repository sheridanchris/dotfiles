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
    users.${username} = {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
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
