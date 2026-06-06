{username, ...}: {
  imports = [
    # ./env/gnome.nix
    ./wm/wayland
    # ./wm/x11 <- BROKEN, I3 CAN'T OPEN DISPLAY
    ./spotify.nix
    ./browser.nix
    ./term.nix
    ./gaming.nix
  ];

  home-manager.users.${username} = {
    programs.obs-studio.enable = true;
  };
}
