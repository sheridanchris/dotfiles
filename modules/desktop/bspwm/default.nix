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
        "xrandr --output DP-0 --primary --mode 1920x1080 --rate 144.00"
        "feh --bg-fill ~/dotfiles/wallpapers/cat_pacman.png"
        "polybar"
      ];
    };
  };
}
