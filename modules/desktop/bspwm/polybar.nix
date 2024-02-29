{
  pkgs,
  username,
  ...
}: {
  services.polybar = let
    colorsConfig =
      pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "polybar";
        rev = "9ee66f83335404186ce979bac32fcf3cd047396a";
        sha256 = "sha256-bUbSgMg/sa2faeEUZo80GNmhOX3wn2jLzfA9neF8ERA=";
      }
      + /themes/mocha.ini;
  in {
    enable = true;
    settings = {
      "global/wm" = {
        include-file = "${colorsConfig}";
      };

      "bar/top" = {
        monitor = "DP-0";
        width = "100%";
        height = "3%";
        radius = 0;
        background = "\${colors.base}";
        border-color = "\${colors.crust}";
        foreground = "\${colors.surface0}";
        modules-left = "bspwm";
        modules-center = "window";
        modules-right = "cpu memory date";
        module-margin-right = 2;
        padding-left = 1;
        padding-right = 1;

        font-0 = "CommitMono:size=12";
        font-1 = "JetBrainsMono Nerd Font:size=12";
        font-2 = "Font Awesome 6 Free Solid:style=Solid:pixelsize=12";
        font-3 = "Font Awesome 6 Free Regular:style=Regular:pixelsize=12";
        font-4 = "Font Awesome 6 Brands:style=Regular:pixelsize=12";
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        enable-click = false;
        enable-scroll = false;
        ws-icon-default = "";

        label-focused = "%icon%";
        label-focused-foreground = "\${colors.teal}";
        label-focused-padding = 1;

        label-occupied = "%icon%";
        label-occupied-foreground = "\${colors.flamingo}";
        label-occupied-padding = 1;

        label-urgent = "%icon%";
        label-urgent-foreground = "\${colors.red}";
        label-urgent-padding = 1;

        label-empty = "%icon%";
        label-empty-foreground = "\${colors.text}";
        label-empty-padding = 1;
      };
      "module/window" = {
        type = "internal/xwindow";
        format = "<label>";
        format-foreground = "\${colors.text}";

        label = "%title%";
        label-empty = "No Active Window";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;
        warn-percentage = 90;
        label = " %percentage%%";
        label-foreground = "\${colors.text}";
        label-warn = " %percentage%%";
        label-warn-foreground = "\${colors.text}";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 1;
        warn-percentage = 90;
        label = " %gb_used%/%gb_total%";
        label-foreground = "\${colors.text}";
        label-warn = " %gb_used%/%gb_total%";
        label-warn-foreground = "\${colors.text}";
      };
      "module/date" = {
        type = "internal/date";
        interval = 1.0;
        date = "%m-%d-%Y";
        time = "%I:%M";
        format = "<label>";
        label = " %date% %time%";
        label-foreground = "\${colors.text}";
      };
    };
    script = "";
  };
}
