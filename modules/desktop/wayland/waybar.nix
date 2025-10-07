{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    catppuccin.waybar.enable = true;
    catppuccin.waybar.flavor = "mocha";

    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          # height = 30;
          output = [
            "DP-1"
            "DP-2"
          ];
          modules-left = ["hyprland/workspaces"];
          modules-right = ["clock"];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              default = "";
              urgent = "";
              # urgent = "";
              # active = "";
              # visible = "";
              # default = "";
              # empty = "";
            };
            all-outputs = false;
          };
        }
      ];
      style = ''
        window#waybar {
          background-color: shade(@base, 0.9);
          border: 2px solid alpha(@crust, 0.3);
        }

        #workspaces {
          color: @text;
        }

        #workspaces button.active {
          color: @teal;
        }
      '';
    };
  };
}
