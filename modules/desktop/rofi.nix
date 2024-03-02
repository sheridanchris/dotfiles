{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "run";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "alacritty";
        drun-display-format = "{icon} {name}";
        location = 0;
        hide-scrollbar = true;
        display-drun = "  Apps ";
        sidebar-mode = true;
      };
      theme = "${inputs.catppuccin-rofi}/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
    };
  };
}
