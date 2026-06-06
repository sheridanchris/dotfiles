{
  pkgs,
  username,
  ...
}: {
  services.xserver.windowManager.i3.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.i3}/bin/i3";
        user = username;
      };
      default_session = initial_session;
    };
  };

  # Is this needed?
  xdg.portal = {
    enable = true;
    config.common.default = "gnome";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  home-manager.users.${username} = {
    xsession.windowManager.i3 = {
      enable = true;
      config = let
        mod = "Mod4";
      in {
        modifier = mod;
        keybindings = {
          "${mod}+Return" = "exec alacritty";
          "${mod}+Shift+Return" = "exec nautilus";
          "${mod}+O" = "exec rofi -show drun";
          "${mod}+Shift+W" = "exec xdg-open https://duckduckgo.com";
        };
        startup = [
          {
            command = "xrandr --output HDMI-0 --off --output DP-0 --primary --mode 3440x1440 --rate 144.00 --pos 1920x0 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off";
            always = true;
          }
        ];
      };
    };
  };
}
