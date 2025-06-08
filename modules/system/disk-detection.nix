{config, ...}:
#---------------------------------------------------------------------
# Automatically detect and manage storage devices connected to your
# system. This includes handling device mounting and unmounting,
# as well as providing a consistent interface for accessing USB and
# managing disk-related operations.
#---------------------------------------------------------------------
# services.devmon.enable = true;
# services.udisks2.enable = true;
{
  services = {
    udisks2 = {
      enable = true;
    };

    devmon = {
      enable = true;
    };

    udev = {
      enable = true;

      # enable high precision timers if they exist
      # (https://gentoostudio.org/?page_id=420)

      extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
      '';
    };
  };
}
