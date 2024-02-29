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
      jetbrains-mono
      twitter-color-emoji
      font-awesome
      commit-mono
      monaspace
      geist-font
      (nerdfonts.override {
        fonts = ["JetBrainsMono"];
      })
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["DejaVu Math TeX Gyre" "DejaVu Serif" "Noto Serif"];
        sansSerif = ["DejaVu Sans" "Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font" "CommitMono" "DejaVu Sans Mono"];
        emoji = ["Twitter Color Emoji" "Noto Color Emoji" "Noto Emoji"];
      };
    };
  };

  home-manager.users.${username} = {
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
          accents = ["pink"];
          size = "compact";
          tweaks = ["rimless" "normal"];
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
  };
}
