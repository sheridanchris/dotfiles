{
  pkgs,
  config,
  inputs,
  username,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  programs.dconf.enable = true;
  security.polkit.enable = true;

  services.dbus.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Christian Sheridan";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Imagine only using Java for Minecraft!
  programs.java = {
    enable = true;
    additionalRuntimes = {inherit (pkgs) jdk17 jdk11 jdk8;};
    package = pkgs.jdk17;
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
      config.common.default = "gtk";
    };
    mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/*" = "feh.desktop";
      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
    };
  };

  systemd.user.services.discordfetch = {
    enable = true;
    description = "discordfetch";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${inputs.discordfetch.packages.${pkgs.system}.default}/bin/discordfetch \
          --button "GitHub" "https://github.com/sheridanchris" \
          --button "I use NixOS btw" "https://nixos.org"
      '';
    };
    after = ["network.target"];
    wantedBy = ["default.target"];
  };
}
