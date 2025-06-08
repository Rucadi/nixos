{
  config,
  pkgs,
  ...
}:
# Desktop, printing, audio, SSH, Hyprland
{
  services.xserver = {
    enable = true;
    xkb.layout = "es";
    xkb.variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.openssh.enable = true;

  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  powerManagement.cpuFreqGovernor = "performance";

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
