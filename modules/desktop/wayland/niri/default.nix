{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = [
    pkgs.niri
    pkgs.polkit_gnome
    pkgs.xwayland-satellite
  ];

  services.gnome.gnome-keyring.enable = true;
  services.displayManager.sessionPackages = [pkgs.niri];

  xdg.portal = {
    enable = true;
    config.common.default = "gnome";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    configPackages = [pkgs.niri];
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["niri.service"];
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home-manager.users.${username} = {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
