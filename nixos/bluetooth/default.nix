# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, pkgs, lib, modulesPath, ... }:
{
   # Enable Bluetooth
   hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    libbs2b #binaural audio
  ];
}