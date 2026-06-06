{
  pkgs,
  config,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
      languages = {
        language = [
          {
            name = "markdown";
            soft-wrap.enable = true;
          }
          {
            name = "nix";
            auto-format = true;
            formatter.command = "alejandra";
          }
          {
            name = "gleam";
            auto-format = true;
          }
        ];
        language-server = {
          nixd = {
            command = "nixd";
            args = ["--semantic-tokens=true"];
            config.nixd = let
              myFlake = ''(builtins.getFlake "/home/${username}/dotfiles")'';
              nixosOpts = "${myFlake}.nixosConfigurations.${config.networking.hostName}.options";
            in {
              nixpkgs.expr = "import ${myFlake}.inputs.nixpkgs { }";
              formatting.command = ["alejandra"];
              options = {
                nixos.expr = nixosOpts;
                home-manager.expr = "${nixosOpts}.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
      settings = {
        editor = {
          mouse = false;
          cursorline = true;
          true-color = true;
          color-modes = true;
          line-number = "relative";
          bufferline = "always";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        keys.normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
          C-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
          C-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
        };
      };
    };
    stylix.targets.helix = {
      enable = true;
      colors.enable = true;
    };
  };
}
