{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    flavour = "mocha";
    background.dark = "mocha";
    integrations = {
      cmp = true;
      telescope.enabled = true;
    };
  };
}
