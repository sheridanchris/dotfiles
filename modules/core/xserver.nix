{username, ...}: {
  # TODO: I should probably move this.
  services.displayManager.autoLogin = {
    enable = true;
    user = username;
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager = {
      gdm = {
        enable = true;
      };
    };
  };
}
