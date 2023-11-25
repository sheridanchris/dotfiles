{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../../../modules/home
  ];

  xdg = {
    configFile = {
      "btop/themes/catppuccin_mocha.theme".source = (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "btop";
          rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
          sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
        } + /themes/catppuccin_mocha.theme);
    };
  };

  programs = {
    home-manager.enable = true;
    feh.enable = true;
    zathura.enable = true;
    lazygit.enable = true; # TODO: Catppuccin
    obs-studio.enable = true;
    
    rofi = {
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
      theme = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "rofi";
          rev = "5350da41a11814f950c3354f090b90d4674a95ce";
          sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
        } + /basic/.local/share/rofi/themes/catppuccin-mocha.rasi;
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha.theme";
      };
    };
  };
}
