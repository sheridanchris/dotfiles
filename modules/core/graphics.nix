{config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  services.xserver.videoDrivers = ["nvidia"];
}
