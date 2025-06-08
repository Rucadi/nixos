{
  config,
  pkgs,
  ...
}:
# User account & console keymap
{
  users.users.rucadi = {
    isNormalUser = true;
    description = "rucadi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "qemu-libvirtd"
      "docker"
      "disk"
    ];
    packages = with pkgs; [kdePackages.kate];
  };
      nix.settings.trusted-users = [ "root" "rucadi" ];

  console.keyMap = "es";
}
