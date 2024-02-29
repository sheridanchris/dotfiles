{username, ...}: {
  home-manager.users.${username} = {
    services.dunst.enable = true;
  };
}
