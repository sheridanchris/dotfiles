{
  pkgs,
  username,
  ...
}: {
  # https://wiki.hypr.land/
  # https://github.com/hyprland-community/awesome-hyprland
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper
    wl-clipboard
    grim
    slurp
  ];

  home-manager.users.${username} = {
    catppuccin.mako.enable = true;
    catppuccin.mako.flavor = "mocha";
    services.mako.enable = true;

    catppuccin.fuzzel.enable = true;
    catppuccin.fuzzel.flavor = "mocha";
    programs.fuzzel.enable = true;

    services.cliphist.enable = true;
  };
}
