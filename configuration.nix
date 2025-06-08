{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/10-global.nix
    ./modules/20-networking.nix
    ./modules/30-hardware.nix
    ./modules/40-services.nix
    ./modules/50-virtualization.nix
    ./modules/60-users.nix
    ./modules/70-packages.nix
    ./modules/80-games.nix
    ./modules/90-printer.nix
    ./modules/100-system.nix
    ./modules/110-niri-desktop.nix
  ];

  # Define system state version
  system.stateVersion = "25.05";
}
