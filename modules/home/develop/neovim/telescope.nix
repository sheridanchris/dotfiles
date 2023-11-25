{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>sf" = {
        action = "git_files";
        desc = "Telescope Git Files";
      };
      "<leader>sg" = {
        action = "live_grep";
        desc = "Telescope Live Grep";
      };
    };
  };
  programs.nixvim.extraPackages = with pkgs; [ ripgrep ];
}
