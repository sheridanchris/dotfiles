{
  pkgs,
  username,
  ...
}: {
  # TODO: display manager.

  imports = [
    ./i3.nix
  ];

  environment.systemPackages = with pkgs; [
    xrandr
    flameshot
  ];

  home-manager.users.${username} = {
    services.dunst.enable = true;
    stylix.targets.dunst = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };

    programs.rofi.enable = true;
    stylix.targets.rofi = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };
}
