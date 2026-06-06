{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./niri
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
    grim
    slurp
    (pkgs.writeShellScriptBin "random-wallpaper" (builtins.readFile ../../../../scripts/random-wallpaper.sh))
  ];

  home-manager.users.${username} = {
    services.mako.enable = true;
    stylix.targets.mako = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };

    programs.fuzzel.enable = true;
    stylix.targets.fuzzel = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };

    services.cliphist.enable = true;
  };
}
