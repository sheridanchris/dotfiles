{username, ...}: {
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Application Keybindings
      "super + Return" = "alacritty";
      "super + shift + Return" = "thunar";
      "super + p" = "alacritty --command btop";
      "super + o" = "rofi -show drun";
      "super + shift + w" = "xdg-open https://duckduckgo.com";
      "super + shift + c" = "discord";
      "super + Print" = "flameshot gui";

      # Bspwm Keybindings
      "super + q" = "xdo close && bspunhide";
      "super + shift + q" = "bspc wm -r";
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";
      "super + {0-9}" = "bspc desktop -f {0-9}";
      "super + shift + {0-9}" = "bspc node -d {0-9} && bspunhide";
      "super + space" = "bspc node focused.tiled -t floating || bspc node focused.floating -t tiled";
      "ctrl + alt + {h,j,k,l}" = "bspc node -z {left -20 0, bottom 0 20, top 0 -20, right 20 0}";
      "ctrl + super + {h,j,k,l}" = "bspc node -z {right -20 0, top 0 20, bottom 0 -20, left 20 0}";
    };
  };
}
