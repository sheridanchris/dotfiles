{
  pkgs,
  inputs,
  ...
}: {
  systemd.user.services.discordfetch = {
    enable = true;
    description = "discordfetch";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${inputs.discordfetch.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/discordfetch \
          --button "GitHub" "https://github.com/sheridanchris" \
          --button "I use NixOS btw" "https://nixos.org"
      '';
      Restart = "on-failure";
    };
    after = ["network.target"];
    wantedBy = ["default.target"];
  };
}
