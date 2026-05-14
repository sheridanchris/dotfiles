{username, ...}: {
  programs.dconf.enable = true;

  home-manager.users.${username} = {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
