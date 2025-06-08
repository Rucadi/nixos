{
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  services.displayManager.defaultSession = "niri";


  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  systemd.user.services.xwayland-satellite.wantedBy = [ "graphical-session.target" ];

  xdg.portal = {
    enable = true;
    lxqt = {
      enable = true;
      styles = [ pkgs.libsForQt5.qtstyleplugin-kvantum ];
    };
  };
}
