{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
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

          "<Shift-Tab>" = "cmp.mapping.select_prev_item()";
          "<Tab>" = "cmp.mapping.select_next_item()";
        };
      };

      lsp-format.enable = true;
      lsp = {
        enable = true;
        enabledServers = [
          "ocamllsp" # OCaml
          # "fsautocomplete" # FSharp
          "rust_analyzer" # Rust
          "marksman" # Markdown
        ];
        # Nix
        # servers.nixd = {
        #   enable = true;
        #   installLanguageServer = false;
        #   settings.formatting.command = "alejandra";
        # };
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gr = "references";
            gD = "declaration";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
            rn = "rename";
            ca = "code_action";
          };
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      Ionide-vim
      rustaceanvim
    ];
  };
}
