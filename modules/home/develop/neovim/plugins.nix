{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.plugins = {
    which-key.enable = true;
    lualine.enable = true;
    todo-comments.enable = true;
    oil = {
      enable = true;
      useDefaultKeymaps = true;
      columns = {
        icon.enable = true;
        type.enable = true;
      };
    };
  };
}
