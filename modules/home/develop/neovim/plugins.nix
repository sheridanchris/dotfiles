{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.plugins = {
    which-key.enable = true;
    treesitter.enable = true;
    lualine.enable = true;
    todo-comments.enable = true;
    fugitive.enable = true;
  };
}
