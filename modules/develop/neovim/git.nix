{pkgs, ...}: {
  # TODO: these
  programs.nixvim = {
    plugins = {
      fugitive.enable = true;
      gitsigns = {
        enable = true;
        attachToUntracked = true;
      };
    };
  };
}
