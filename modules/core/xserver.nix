{username, ...}: {
  # TODO: I should probably move this.
  services.displayManager = {
    gdm.enable = true;
    autoLogin = {
      enable = true;
      user = username;
    };
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
}
