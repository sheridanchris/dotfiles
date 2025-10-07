{username, ...}: {
  services.xserver.windowManager.bspwm.enable = true;

  home-manager.users.${username} = {
    imports = [
      ./polybar.nix
      ./sxhkd.nix
    ];

    xsession.windowManager.bspwm = {
      enable = true;
      monitors = {
        DP-0 = ["1" "2" "3" "4" "5"];
      };
      settings = {
        border_width = 2;
        window_gap = 6;

        split_ratio = 0.52;
        borderless_moncole = true;
        gapless_monocle = true;

        focused_border_color = "#f2cdcd"; # Catppuccin flamingo
        normal_border_color = "#1e1e2e"; # Catppuccin base
      };
      startupPrograms = [
        "xrandr --output HDMI-0 --off --output DP-0 --primary --mode 3440x1440 --rate 144.00 --pos 1920x0 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off"
        "feh --bg-fill ~/dotfiles/wallpapers/cat_car.jpg"
        "polybar"
      ];
    };
  };
}
