{
  pkgs,
  username,
  ...
}: {
  # TODO: Should I move something like polkit.enable = true; to the individual environments?
  # https://wiki.nixos.org/wiki/Niri
  environment.systemPackages = [
    pkgs.polkit_gnome
    pkgs.xwayland-satellite
  ];

  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = let
      session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = username;
      };
    in {
      initial_session = session;
      default_session = session;
    };
  };

  systemd.user.services.niri.enableDefaultPath = false;

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
