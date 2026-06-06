{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [
    feh
    mpv
    libreoffice
    calibre
  ];
  xdg.mime.defaultApplications = {
    "image/*" = "feh.desktop";
    "video/*" = "mpv.desktop";
    "audio/*" = "mpv.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
    "application/msword" = "libreoffice-writer.desktop";
  };

  home-manager.users.${username} = {
    programs.zathura = {
      enable = true;
      options = {
        adjust-open = "best-fit";
        pages-per-row = 1;
      };
    };
    stylix.targets.zathura = {
      enable = true;
      colors.enable = true;
    };
  };
}
