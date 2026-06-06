{config, ...}: {
  hardware.enableAllFirmware = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;

  # Enable printing and discovery
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
