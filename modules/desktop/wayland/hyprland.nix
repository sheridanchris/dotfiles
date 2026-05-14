{
  pkgs,
  inputs,
  username,
  ...
}: {
  # https://wiki.hypr.land/
  # https://github.com/hyprland-community/awesome-hyprland
  imports = [
    (import ./waybar.nix {
      username = username;
      workspace-module = "hyprland/workspaces";
    })
  ];

  programs.hyprland.enable = true;

  # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.enable
  home-manager.users.${username} = {
    catppuccin.hyprland.enable = true;
    catppuccin.hyprland.flavor = "mocha";

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      systemd = {
        enable = true;
        variables = ["--all"];
      };

      plugins = [
        # https://github.com/Duckonaut/split-monitor-workspaces
        inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces

        # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprscrolling
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      ];

      settings = {
        "$mod" = "SUPER";
        "$mod_shift" = "SUPER_SHIFT";
        bind =
          [
            "$mod, XF86ScrollUp, layoutmsg, move +col,"
            "$mod, XF86ScrollDown, layoutmsg, move -col,"

            "$mod, Q, killactive,"
            "$mod, Space, togglefloating,"
            "$mod, F, fullscreen,"

            "$mod_shift, W, exec, xdg-open https://duckduckgo.com"
            "$mod, Return, exec, alacritty"
            "$mod_shift, Return, exec, alacritty --command yazi"
            "$mod_shift, P, exec, alacritty --command btop"
            "$mod, O, exec, fuzzel --no-icons"
            "$mod, S, exec, open-url \"\$(fuzzel --dmenu --placeholder 'Enter Search Query' --prompt-only '> ')\""
            "$mod, C, exec, cliphist-fuzzel-img"
            "$mod, Print, exec, grim -g \"\$(slurp)\" - | wl-copy"
          ]
          ++ (
            builtins.concatLists (builtins.genList (
                workspaceIndex: let
                  workspaceNumber = workspaceIndex + 1;
                in [
                  "$mod, code:1${toString workspaceIndex}, split-workspace, ${toString workspaceNumber}"
                  "$mod SHIFT, code:1${toString workspaceIndex}, split-movetoworkspace, ${toString workspaceNumber}"
                ]
              )
              9)
          );
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        plugin = {
          split-monitor-workspaces = {
            count = 5;
            enable_persistent_workspaces = 1;
          };
          hyprscrolling = {
            column_width = 0.5;
            fullscreen_on_one_column = true;
          };
        };

        monitor = [
          "DP-1, 3440x1440@144.00, 1920x0, 1"
          "DP-2, 1920x1080@144.00, 0x0, 1"
        ];
        "exec-once" = [
          # "waybar"
          "random-wallpaper"
          "wl-paste --watch cliphist store"
        ];
      };
    };
  };
}
