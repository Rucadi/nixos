{ config, inputs, pkgs, ... }:
{

  networking.hostName = "rurumonte"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.eno2.useDHCP = true;
}
