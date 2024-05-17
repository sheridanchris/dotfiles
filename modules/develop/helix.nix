{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  # home-manager.users.${username} = {
  #   programs.helix = {
  #     enable = true;
  #     # package = pkgs.helix;
  #     package = inputs.helix.packages.${pkgs.system}.default;
  #     defaultEditor = true;
  #     languages = {
  #       grammar = [
  #         {
  #           name = "fsharp";
  #           source = {
  #             git = "https://github.com/ionide/tree-sitter-fsharp/";
  #             rev = "52389294922565d67e15acae45c99111793a848a";
  #           };
  #         }
  #       ];
  #       language = [
  #         {
  #           name = "markdown";
  #           soft-wrap.enable = true;
  #         }
  #       ];
  #       language-server = {
  #         nil = {
  #           config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
  #         };
  #       };
  #     };
  #     settings = {
  #       theme = "catppuccin_mocha";
  #       editor = {
  #         mouse = false;
  #         cursorline = true;
  #         true-color = true;
  #         color-modes = true;
  #         line-number = "relative";
  #         bufferline = "always";
  #         cursor-shape = {
  #           insert = "bar";
  #           normal = "block";
  #           select = "underline";
  #         };
  #       };
  #       keys.normal = {
  #         esc = ["collapse_selection" "keep_primary_selection"];
  #         C-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
  #         C-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
  #       };
  #     };
  #   };
  # };
}
