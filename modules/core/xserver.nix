{username, ...}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    videoDrivers = ["nvidia"];
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
