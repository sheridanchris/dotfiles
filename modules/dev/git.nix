{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "sheridanchris";
          email = "christiansheridan@outlook.com";
        };
      };
      signing = {
        key = "85BC3B03CAF4E5CD";
        signByDefault = true;
      };
    };
    programs.gh = {
      enable = true;
      extensions = [pkgs.gh-dash];
    };
  };
}
