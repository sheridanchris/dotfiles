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
        inputs.nixvim.homeManagerModules.nixvim
        inputs.spicetify-nix.homeManagerModule
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
