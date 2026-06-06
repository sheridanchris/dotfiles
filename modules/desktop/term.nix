{
  pkgs,
  lib,
  username,
  ...
}: {
  users.users.${username}.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    zsh-fzf-tab
  ];

  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings.terminal.shell.program = "zsh";
    };

    stylix.targets.alacritty = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ga = "git add";
        gc = "git commit";
        gs = "git status";
        gl = "git log";
        gp = "git push origin main";
        cat = "bat";
        mkdir = "mkdir -p";
      };
      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];
      initContent = ''
        zstyle ':completion:*' menu no
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always --level=2 $realpath'
        zstyle ':fzf-tab:*' use-fzf-default-opts
      '';
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    stylix.targets.fzf = {
      enable = true;
      colors.enable = true;
    };

    programs.carapace = {
      enable = true;
      ignoreCase = true;
      enableZshIntegration = true;
    };

    programs.vivid = {
      enable = true;
      enableZshIntegration = true;
    };
    stylix.targets.vivid = {
      enable = true;
      colors.enable = true;
    };

    # TODO: Use stylix???
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "[λ ](fg:#a6e3a1)";
        right_format = "$language_icon $git_metrics $directory";
        add_newline = false;
        git_metrics = {
          disabled = false;
          format = "[  ](fg:base0D bg:base02)[|](fg:base05 bg:base02)[ +$added](bg:base02 fg:green)[ -$deleted ](bg:base02 fg:red)";
        };
        directory = {
          format = "[  ](fg:base0D bg:base02)[|](fg:base05 bg:base02)[ $path ](bg:base02 fg:base05)";
        };
      };
    };
    stylix.targets.starship = {
      enable = true;
      colors.enable = true;
    };

    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    programs.btop.enable = true;
    stylix.targets.btop = {
      enable = true;
      colors.enable = true;
    };

    programs.bat.enable = true;
    stylix.targets.bat = {
      enable = true;
      colors.enable = true;
    };
  };
}
