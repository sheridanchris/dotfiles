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

    # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.base16Scheme = ../../themes/chalk.yaml;

    stylix.fonts = {
      monospace = {
        package = pkgs.commit-mono;
        name = "CommitMono";
      };
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        popups = 12;
        desktop = 12;
        terminal = 16;
        applications = 12;
      };
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
      iconTheme = {
        package = pkgs.fluent-icon-theme;
        name = "Fluent-dark";
      };
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

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 48;
    };
  };
}
