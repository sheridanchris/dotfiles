{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../runtimes
    ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.christian = import ../users/christian/home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
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

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];
    displayManager = {
      gdm = {
        enable = true;
      };
      autoLogin = {
        enable = true;
        user = "christian";
      };
    };
    windowManager = {
      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };
    };
  };

  services.printing.enable = true;
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
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Sheridan";
    extraGroups = [ "docker" "networkmanager" "wheel" "libvirtd" ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    direnv
    virt-manager
  ];

  # Imagine only using Java for Minecraft!
  programs.java = {
    enable = true;
    additionalRuntimes = { inherit (pkgs) jdk17 jdk11 jdk8; };
    package = pkgs.jdk17;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
    mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "feh.desktop";
      "video/mp4" = "mpv.desktop";
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = with pkgs; [
            (OVMFFull.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
  };

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
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Math TeX Gyre" "DejaVu Serif" "Noto Serif" ];
        sansSerif = [ "DejaVu Sans" "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "DejaVu Sans Mono" ];
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" "Noto Emoji" ];
      };
    };
  };

  system = {
    stateVersion = "23.05";
  };
}
