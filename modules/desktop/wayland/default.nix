{
  pkgs,
  username,
  ...
}: {
  # https://wiki.hypr.land/
  # https://github.com/hyprland-community/awesome-hyprland

  # TODO:
  # Bar (Waybar? HyprPanel?) Went with Hyprpanel which also uses its own notification daemon...
  # Launcher (Wofi? Tofi? Anyrun?)
  # Arandr? (wayland xrandr)
  # Screenshots (grim + slurp?)
  # Notification Daemon (dunst?, mako?) Hyprpanel's notification daemon, for now...
  # Screensharing
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
}
