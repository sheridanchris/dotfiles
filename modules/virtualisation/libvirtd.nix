{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [virt-manager];
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "start";
    onShutdown = "shutdown";
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf = {
      #   enable = true;
      #   packages = with pkgs; [
      #     (OVMFFull.override {
      #       secureBoot = true;
      #       tpmSupport = true;
      #     })
      #     .fd
      #   ];
      # };
    };
  };

  users.users.${username}.extraGroups = ["libvirtd"];
}
