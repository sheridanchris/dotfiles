{ pkgs, ... }: {
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
}
