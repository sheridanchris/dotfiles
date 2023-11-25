{ config, pkgs, lib, inputs, ... }: {
  # TODO: Snippets.
  programs.nixvim.plugins.luasnip.enable = true;

  programs.nixvim.plugins.nvim-cmp = {
    enable = true;
    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end
        '';
        modes = [
          "i"
          "s"
        ];
      };
    };
  };

  programs.nixvim.plugins.cmp-nvim-lsp.enable = true;
  programs.nixvim.plugins.cmp-buffer.enable = true;
}
