{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
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
    theme =
      pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "rofi";
        rev = "5350da41a11814f950c3354f090b90d4674a95ce";
        sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
      }
      + /basic/.local/share/rofi/themes/catppuccin-mocha.rasi;
  };
}
