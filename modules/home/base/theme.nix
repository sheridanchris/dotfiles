{ config, pkgs, lib, inputs, ... }: {
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaPink;
    name = "Catppuccin-Mocha-Pink-Cursors";
    size = 32;
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "pink";
        flavor = "mocha";
      };
      name = "Papirus-Dark";
    };
  };

  # TODO: Catppuccin
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "Adwaita-dark";
    };
  };

  # stylix = {
  #   # autoEnable = true;
  #   image = ../../../wallpapers/cat_pacman.png;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  #   targets = {
  #     helix.enable = true;
  #     alacritty.enable = true;
  #     bspwm.enable = true;
  #     dunst.enable = true;
  #     rofi.enable = true;
  #     gtk.enable = true;
  #     vim.enable = true;

  #     vscode.enable = false;
  #     # polybar.enable = true;
  #   };
  #   fonts = {
  #     serif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Serif";
  #     };

  #     sansSerif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans";
  #     };

  #     monospace = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans Mono";
  #     };

  #     emoji = {
  #       package = pkgs.noto-fonts-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };
  # };
}
