{
  pkgs,
  inputs,
  username,
  ...
}: {
  # TODO: NVIDIA, BINDS, MULTI-MONITOR WORKSPACES, STARTUP PROGRAMS, ...

  programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  # programs.hyprland.xwayland.enable = true;
  # programs.hyprland.enableNvidiaPatches = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
  #   ];
  # };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.enable
  home-manager.users.${username} = {
    catppuccin.hyprland.enable = true;
    catppuccin.hyprland.flavor = "mocha";

    home.file.".config/hypr/hyprpaper.conf".text = ''
      preload = /home/${username}/Pictures/wallpaper.png
      wallpaper = ,/home/${username}/Pictures/wallpaper.png
    '';

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
        inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];

      settings = {
        "$mod" = "SUPER";
        "$mod_shift" = "SUPER_SHIFT";
        bind =
          [
            "$mod, Q, killactive,"
            "$mod, Space, togglefloating,"
            "$mod, F, fullscreen,"

            "$mod_shift, W, exec, xdg-open https://duckduckgo.com"
            "$mod, Return, exec, alacritty"
            "$mod_shift, Return, exec, thunar"
            "$mod, O, exec, rofi -show drun"
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
        };

        monitor = [
          "DP-1, 3440x1440@144.00, 1920x0, 1"
          "DP-2, 1920x1080@144.00, 0x0, 1"
        ];
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];
        "exec-once" = [
          "waybar"
          "hyprpaper"
        ];
      };
    };
  };
}
