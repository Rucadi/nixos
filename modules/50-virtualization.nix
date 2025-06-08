{
  config,
  pkgs,
  ...
}:
# libvirt/QEMU, virt-manager, nix-ld, envfs
{
  virtualisation.libvirtd = {
    enable = true;
    extraConfig = ''user = "${config.users.users.rucadi.name}" '';
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      verbatimConfig = ''
        namespaces = []
        user = "+${builtins.toString config.users.users.rucadi.uid}"
      '';
    };
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/docker_data";
    storageDriver = "btrfs";
  };

  programs.virt-manager.enable = true;
  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  boot.binfmt.emulatedSystems = [
    "wasm32-wasi"
    "wasm64-wasi"
    "aarch64-linux"
  ];
}
