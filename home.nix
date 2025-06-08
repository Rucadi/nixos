{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
# packages install-deps git quickshell curl jq ttf-material-symbols-variable-git ttf-jetbrains-mono-nerd ttf-ibm-plex app2unit-git fd fish python-aubio python-pyaudio python-numpy cava networkmanager bluez-utils ddcutil brightnessctl
{
  home.stateVersion = "25.05";

  #install pacakges
  home.packages = with pkgs; [
    git
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

  # git configuration
  programs.git = {
    enable = true;
    userName = "Rucadi";
    userEmail = "ruben.cano96@gmail.com";
  };
}
