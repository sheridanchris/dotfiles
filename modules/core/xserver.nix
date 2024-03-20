{username, ...}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager = {
      gdm = {
        enable = true;
      };
      autoLogin = {
        enable = true;
        user = username;
      };
    };
  };
}
