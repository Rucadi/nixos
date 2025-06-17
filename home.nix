{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  home.stateVersion = "25.05";

  #install pacakges
  home.packages = with pkgs; [
    curl
    jq
    material-symbols
    nerd-fonts.jetbrains-mono
    ibm-plex
    fd
    fish
    cava
    networkmanager
    bluez-tools
    ddcutil
    brightnessctl
  ];

  home.keyboard = {
    layout = "es";
    variant = "intl"; # or "altgr-intl" for AltGr accents
    options = ["lv3:ralt_switch"]; # optional: AltGr = Right Alt
  };

  imports = [./home-manager/default.nix];

  # git configuration
  programs.git = {
    enable = true;
    userName = "Rucadi";
    userEmail = "ruben.cano96@gmail.com";
  };
}
