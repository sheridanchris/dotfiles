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

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$character";
        right_format = "$git_branch $git_metrics | $directory";
        add_newline = false;
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
        git_branch = {
          symbol = "";
          format = "$symbol $branch";
        };
        git_metrics = {
          disabled = false;
          format = "[+$added](fg:green) [-$deleted](fg:red)";
        };
        directory = {
          format = " $path";
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
