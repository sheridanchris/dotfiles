{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # TODO: Path-based user-name and email address for Work. (if required)
  programs.git = {
    enable = true;
    userName = "sheridanchris";
    userEmail = "christiansheridan@outlook.com";
    signing = {
      key = "85BC3B03CAF4E5CD";
      signByDefault = true;
    };
  };
  programs.gh = {
    enable = true;
    extensions = [pkgs.gh-dash];
  };
}
