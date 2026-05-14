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
    nautilus
    kdePackages.ark
    feh
    mpv
    yt-dlp
    lazydocker
    (prismlauncher.override {jdks = [jdk8 jdk11 jdk17 jdk];})
    ripgrep
    lazygit
    dbeaver-bin
    transmission_4-gtk
    fzf
    imagemagick
    zathura
    calibre
    (pkgs.writeShellScriptBin "open-url" (builtins.readFile ../../scripts/open-url.sh))
    (pkgs.writeShellScriptBin "cliphist-fuzzel-img" (builtins.readFile ../../scripts/cliphist-fuzzel-img.sh))
    signal-desktop
  ];
}
