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
    kdePackages.ark
    bitwarden-desktop
    feh
    xdo
    mpv
    yt-dlp
    lazydocker
    (prismlauncher.override {jdks = [jdk8 jdk11 jdk17 jdk];})
    libreoffice
    element-desktop
    slack
    ripgrep
    lazygit
    obs-studio
    zoom-us
    dbeaver-bin
    transmission_4-gtk
  ];
}
