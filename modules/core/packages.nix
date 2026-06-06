{pkgs, ...}: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  programs.obs-studio.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    pinentry-gtk2
    alejandra
    discord
    nautilus
    kdePackages.ark
    yt-dlp
    lazydocker
    ripgrep
    lazygit
    dbeaver-bin
    transmission_4-gtk
    imagemagick
    (pkgs.writeShellScriptBin "open-url" (builtins.readFile ../../scripts/open-url.sh))
    signal-desktop
    zoom-us
    drawy

    ngrok
    jdk
    jdk8
    jdk11
    jdk17
  ];
}
