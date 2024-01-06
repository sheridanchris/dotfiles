{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    discord
    thunderbird
    xfce.thunar
    ark
    bitwarden
    (kodi.withPackages (kodiPkgs: with kodiPkgs; [netflix]))
    easyeffects
    feh
    xdo
    flameshot
    mpv
    yt-dlp
    lazydocker
    prismlauncher
    ngrok
    libreoffice
    element-desktop
    entr
    slack
    slides
    cmus
    ripgrep
    feh
    zathura
    lazygit
    obs-studio
  ];

  # TODO: Idk where to put this.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
