{
  pkgs,
  config,
  inputs,
  username,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # TODO: This needs to be dynamic
  networking.networkmanager.enable = true;

  time.timeZone = "America/North_Dakota/New_Salem";

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.polkit.enable = true;

  services.dbus.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "Christian Sheridan";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  xdg.autostart.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
}
