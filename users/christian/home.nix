{ config, pkgs, inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  home.username = "christian";
  home.homeDirectory = "/home/christian";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "zsh";
      };
      font = {
        size = 15;
        normal = {
          family = "JetBrains Mono";
        };
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ionide.ionide-fsharp
      bbenoist.nix
      eamodio.gitlens
      vscode-icons-team.vscode-icons
    ];
    userSettings = {
      "workbench.iconTheme" = "vscode-icons";
      "gitlens.codelens.enabled" = true;
      "editor.formatOnSave" = true;
      "editor.mouseWheelZoom" = true;
      "editor.fontSize" = 13;
      "editor.fontFamily" = "'JetBrains Mono', 'Font Awesome 6 Free', 'monospace', monospace";
      "FSharp.inlayHints.enabled" = false;
      "FSharp.inlayHints.typeAnnotations" = false;
      "FSharp.inlayHints.parameterNames" = false;
      "[fsharp]" = { "editor.defaultFormatter" = "ionide.ionide-fsharp"; };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    firefox
    discord
    thunderbird
    gnome.nautilus
    bitwarden
    flameshot
    wofi
    wofi-emoji
  ];

  wayland.windowManager.hyprland =
    let 
      split-monitor-workspaces = pkgs.stdenv.mkDerivation {
        pname = "split-monitor-workspaces";
        version = "0.1";

        src = pkgs.fetchFromGitHub {
          owner = "Duckonaut";
          repo = "split-monitor-workspaces";
          rev = "44785ce";
          sha256 = "XxcUPMqytWItOmre7MV1XAhx/i2uyBbjHMKr5+B0IPE=";
        };

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [ pkgs.hyprland ] ++ pkgs.hyprland.buildInputs;

        buildPhase = ''
          export HYPRLAND_HEADERS=${pkgs.hyprland.src}
          make all
        '';

        installPhase = ''
          mkdir -p $out/lib
          cp split-monitor-workspaces.so $out/lib/libsplit-monitor-workspaces.so
        '';
      };
    in 
    {
      enable = true;
      package = pkgs.hyprland;
      plugins = [ 
        split-monitor-workspaces
      ];
      extraConfig = ''
        exec-once = waybar
        env = XCURSOR_SIZE,24
        env = WLR_NO_HARDWARE_CURSORS,1
        monitor = DP-1,1920x1080@144,0x0,1
        bind = SUPER, Q, killactive
        bind = SUPER, Space, togglefloating
        bind = SUPER_CONTROL_SHIFT, Q, exit
        bind = SUPER, Return, exec, alacritty
        bind = SUPER_SHIFT, Return, exec, nautilus
        bind = SUPER, O, exec, wofi --show run
        bind = SUPER_SHIFT, W, exec, firefox
        bind = SUPER, mouse_down, split-workspace, e+1
        bind = SUPER, mouse_up, split-workspace, e-1
        bind = SUPER, 1, split-workspace, 1
        bind = SUPER, 2, split-workspace, 2
        bind = SUPER, 3, split-workspace, 3
        bind = SUPER, 4, split-workspace, 4
        bind = SUPER, 5, split-workspace, 5
        bind = SUPER, 6, split-workspace, 6
        bind = SUPER, 7, split-workspace, 7
        bind = SUPER, 8, split-workspace, 8
        bind = SUPER, 9, split-workspace, 9
        bind = SUPER, 0, split-workspace, 10
        bind = SUPER_SHIFT, 1, split-movetoworkspacesilent, 1
        bind = SUPER_SHIFT, 2, split-movetoworkspacesilent, 2
        bind = SUPER_SHIFT, 3, split-movetoworkspacesilent, 3
        bind = SUPER_SHIFT, 4, split-movetoworkspacesilent, 4
        bind = SUPER_SHIFT, 5, split-movetoworkspacesilent, 5
        bind = SUPER_SHIFT, 6, split-movetoworkspacesilent, 6
        bind = SUPER_SHIFT, 7, split-movetoworkspacesilent, 7
        bind = SUPER_SHIFT, 8, split-movetoworkspacesilent, 8
        bind = SUPER_SHIFT, 9, split-movetoworkspacesilent, 9
        bind = SUPER_SHIFT, 0, split-movetoworkspacesilent, 10
      '';
  };
 
  home.stateVersion = "23.05";
}
