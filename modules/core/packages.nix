{pkgs, ...}: {
  programs.noisetorch.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    pavucontrol
    pinentry-gtk2
    alejandra
    discord
    thunderbird
    xfce.thunar
    ark
    bitwarden
    (kodi.withPackages (kodiPkgs: with kodiPkgs; [netflix]))
    # easyeffects
    feh
    xdo
    flameshot
    mpv
    yt-dlp
    lazydocker
    prismlauncher
    # ngrok
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
    zoom-us
    fortune
    cowsay
    dbeaver-bin
    arandr
    transmission_4-gtk
  ];
}
