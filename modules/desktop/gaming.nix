{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lunar-client
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk11
        jdk17
        jdk
      ];
    })
  ];
}
