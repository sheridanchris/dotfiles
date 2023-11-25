{ config, pkgs, lib, inputs, ... }:
let
  theme =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
        sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
      };
in
{
  # TODO: I don't know where to put this :(
  programs.alacritty =
    {
      enable = true;
      settings = {
        import = [ "${theme}/catppuccin-mocha.yml" ];
        font = {
          size = 15;
          normal = {
            family = "CommitMono";
          };
        };
        window = {
          opactiy = 0.8;
        };
      };
    };
}
