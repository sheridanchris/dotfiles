{ pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "middlemouse.paste" = false;
      "webgl.disabled" = false;
    };
  };
}
