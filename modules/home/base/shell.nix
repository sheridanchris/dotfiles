{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all";
      palette = "catppuccin_mocha";
    } // builtins.fromTOML (builtins.readFile
      (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "starship";
          rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
          sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
        } + /palettes/mocha.toml));
  };
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
    enableAliases = true;
  };

  # TODO: Should these be here?
  # External programs that rely on shell values.
  programs.direnv.enableZshIntegration = true;
  programs.alacritty.settings.shell.program = "zsh";
}
