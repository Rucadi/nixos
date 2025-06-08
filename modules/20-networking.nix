{
  config,
  pkgs,
  ...
}:
# Hostname, networkmanager, Docker
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
}
