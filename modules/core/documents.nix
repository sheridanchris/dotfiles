{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feh
    mpv
    zathura
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
}
