{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.plugins.lsp-format.enable = true;
  programs.nixvim.plugins.lsp-lines.enable = true;
  programs.nixvim.plugins.lsp = {
    enable = true;
    enabledServers = [
      "nil_ls"
      "ocamllsp"
      "fsautocomplete"
    ];
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gr = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };
  };
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [ Ionide-vim ];
}
