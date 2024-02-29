{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    imports = [
      ./options.nix
      ./languages.nix
      ./telescope.nix
      ./treesitter.nix
      ./colorscheme.nix
      ./git.nix
      ./plugins.nix
    ];

    programs.nixvim.enable = true;
  };
}
