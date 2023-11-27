{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      extraOptions = {
        defaults = {
          mappings.i = {
            "<esc>" = "close";
            "<tab>" = "move_selection_next";
            "<S-tab>" = "move_selection_previous";
            "<C-/>" = "which_key";
          };
        };
      };
      keymaps = {
        "<leader>fg" = {
          action = "git_files";
          desc = "Telescope, Find Git Files";
        };
        "<leader>ff" = {
          action = "find_files";
          desc = "Telescope Find Files";
        };
        "<leader>fs" = {
          action = "live_grep";
          desc = "Telescope Live Grep";
        };
        "<leader>fb" = {
          action = "buffers";
          desc = "Telescope Buffers";
        };
      };
    };
    extraPackages = with pkgs; [ ripgrep ];
  };
}
