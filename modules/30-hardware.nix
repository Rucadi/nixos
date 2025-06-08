{
  config,
  pkgs,
  ...
}:
# Bootloader, kernel, GPU, Bluetooth
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_iommu=on" ];
  boot.initrd.kernelModules = [
    "kvm-intel"
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
  };

  fileSystems."/drives/GAMES" = {
    device = "UUID=963851cf-44cf-4ea2-9883-fff1a425ec1a";
    fsType = "btrfs";
    options = [
      "defaults"
      "noatime"
      "compress=zstd"
    ];
  };
}
