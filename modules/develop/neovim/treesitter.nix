{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
    };

    nvim-autopairs = {
      enable = true;
      disableInVisualblock = true;
    };

    rainbow-delimiters.enable = true;
  };
}
