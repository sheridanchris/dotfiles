{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.plugins.which-key.enable = true;
  programs.nixvim.plugins.treesitter.enable = true;
  programs.nixvim.plugins.lualine.enable = true;
  programs.nixvim.plugins.todo-comments.enable = true;
  programs.nixvim.plugins.fugitive.enable = true;
}
