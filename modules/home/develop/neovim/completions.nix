{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.nixvim.plugins = {
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;

    nvim-cmp = {
      enable = true;
      sources = [
        {name = "buffer";}
        {name = "path";}
        {name = "nvim_lsp";}
      ];
      mapping = {
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
}
