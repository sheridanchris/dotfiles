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
          output = [
            "DP-1"
            "DP-2"
          ];
          modules-left = ["hyprland/workspaces"];
          modules-center = [];
          modules-right = ["clock"];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              # active = "";
              # empty = "";
              default = "";
              urgent = "";
            };
            all-outputs = false;
          };

          "clock" = {
            format = "{:%A, %B%e, %I:%M %p}";
            timezone = "America/Chicago";
          };
        }
      ];
      style = ''
        * {
          font-family: CommitMono, "JetBrainsMono Nerd Font", "Font Awesome 6 Free Solid", "Font Awesome 6 Free Regular", "Font Awesome 6 Brands";
          font-size: 14px;
        }

        window#waybar {
          background-color: shade(@base, 0.9);
          border: 2px solid alpha(@crust, 0.3);
        }

        #waybar > * {
          margin: 0 10px;
        }

        #workspaces {
          color: @text;
        }

        #workspaces button {
          color: @flamingo;
        }

        #workspaces button.empty {
          color: @text;
        }

        #workspaces button.active {
          color: @mauve;
        }

        #workspaces button.urgent {
          color: @red;
        }
      '';
    };
  };
}
