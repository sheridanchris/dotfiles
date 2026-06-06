{username, ...}: {
  programs.dconf.enable = true;

  home-manager.users.${username} = {
    dconf = {
      enable = true;
    };
  };
}
