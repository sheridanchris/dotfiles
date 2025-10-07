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
    # home.pointerCursor = {
    #   package = pkgs.catppuccin-cursors.mochaPink;
    #   name = "Catppuccin-Mocha-Pink-Cursors";
    #   size = 32;
    # };

    catppuccin.cursors.enable = true;
    catppuccin.cursors.flavor = "mocha";

    catppuccin.gtk.icon.enable = true;
    catppuccin.gtk.icon.flavor = "mocha";

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
      # theme = {
      #   name = "Catppuccin-Mocha-Compact-Pink-Dark";
      #   package = pkgs.catppuccin-gtk.override {
      #     accents = ["pink"];
      #     size = "compact";
      #     tweaks = ["rimless" "normal"];
      #     variant = "mocha";
      #   };
      # };
      # iconTheme = {
      #   package = pkgs.catppuccin-papirus-folders.override {
      #     accent = "pink";
      #     flavor = "mocha";
      #   };
      #   name = "Papirus-Dark";
      # };
    };

    # TODO: Catppuccin
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        package = pkgs.adwaita-qt;
        name = "Adwaita-dark";
      };
    };
  };
}
