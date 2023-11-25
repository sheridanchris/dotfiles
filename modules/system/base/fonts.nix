{ config, pkgs, lib, inputs, ... }: {
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
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Math TeX Gyre" "DejaVu Serif" "Noto Serif" ];
        sansSerif = [ "DejaVu Sans" "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "CommitMono" "DejaVu Sans Mono" ];
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" "Noto Emoji" ];
      };
    };
  };
}
