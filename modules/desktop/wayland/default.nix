{
  pkgs,
  username,
  inputs,
  ...
}: {
  imports = [
    ./niri
    # ./hyprland.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wbg
    (pkgs.writeShellScriptBin "random-wallpaper" (builtins.readFile ../../../scripts/random-wallpaper.sh))
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
