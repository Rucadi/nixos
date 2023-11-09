{ config, inputs, pkgs, ... }:

let user = "rucadi";
in
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  
   environment.systemPackages = with pkgs; [
        nordic
    ];

}
