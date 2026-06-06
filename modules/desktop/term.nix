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
        zstyle ':fzf-tab:*' fzf-flags --height=60% --layout=reverse --border --ansi
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
          format = "[  ](fg:#89b4fa bg:#313244)[|](fg:#585b70 bg:#313244)[ +$added](bg:#313244 fg:#a6e3a1)[ -$deleted ](bg:#313244 fg:#f38ba8)";
        };
        directory = {
          format = "[  ](fg:#89b4fa bg:#313244)[|](fg:#585b70 bg:#313244)[ $path ](bg:#313244 fg:#cdd6f4)";
        };
      };
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
