{
  pkgs,
  username,
  ...
}: {
  # TODO: PaperWM settings, Monitor Resolution+Refresh Rate+Position

  services.displayManager = {
    gdm.enable = true;
    autoLogin = {
      enable = true;
      user = username;
    };
  };

  services.desktopManager.gnome.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "gnome";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.gnome = {
    games.enable = false;
    core-apps.enable = false;
    core-developer-tools.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
  ];

  home-manager.users.${username} = {
    dconf = {
      settings = {
        "org/gnome/shell" = {
          enabled-extensions = with pkgs.gnomeExtensions; [
            # paperwm.extensionUuid
          ];
        };
      };
    };
  };
}
