{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      which-key.enable = true;
      todo-comments.enable = true;
      comment-nvim.enable = true;
      floaterm.enable = true;
      oil = {
        enable = true;
        useDefaultKeymaps = true;
        columns = {
          icon.enable = true;
          type.enable = true;
        };
      };

      leap.enable = true;
      lualine.enable = true;
      barbar = {
        enable = true;
        autoHide = true;
      };
    };
    extraPlugins = with pkgs.vimPlugins; [];
  };
}
