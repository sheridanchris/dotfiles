{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    catppuccin.rofi.enable = true;
    catppuccin.rofi.flavor = "mocha";
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
    };
  };
}
