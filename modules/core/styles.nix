{
  pkgs,
  username,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      liberation_ttf
      dejavu_fonts
      noto-fonts
      noto-fonts-lgc-plus
      twitter-color-emoji
      font-awesome
      commit-mono
      monaspace
      geist-font
      nerd-fonts.jetbrains-mono
      ubuntu-classic
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["DejaVu Math TeX Gyre" "DejaVu Serif" "Noto Serif"];
        sansSerif = ["DejaVu Sans" "Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font" "CommitMono" "DejaVu Sans Mono"];
        emoji = ["Noto Color Emoji" "Noto Emoji" "Twitter Color Emoji"];
      };
    };
  };

  stylix.targets.gtk.enable = true;
  stylix.targets.qt.enable = true;

  home-manager.users.${username} = {
    stylix.enable = true;
    stylix.autoEnable = false;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    };

    stylix.targets.gtk = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };

    stylix.targets.qt = {
      enable = true;
      standardDialogs = "xdgdesktopportal";
    };
  };
}
