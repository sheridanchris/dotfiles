{ config, pkgs, lib, inputs, ... }: {
  xdg.configFile."btop/themes/catppuccin_mocha.theme".source = (pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "btop";
      rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
      sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
    } + /themes/catppuccin_mocha.theme);

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
    };
  };
}
