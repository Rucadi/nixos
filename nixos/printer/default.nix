{ config, lib, pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];

  #---------------------------------------------------------------------
  #   Printers and printer drivers (To suit my HP LaserJet 600 M601)
  #---------------------------------------------------------------------
  printerDrivers = [
    pkgs.canon-cups-ufr2
    pkgs.epson-escpr
  ];

in {

  #---------------------------------------------------------------------
  #   Scanner and printing drivers
  #---------------------------------------------------------------------
  hardware.sane.enable = true;
  hardware.sane.extraBackends = extraBackends;
  services.printing.drivers = printerDrivers;
  #---------------------------------------------------------------------
  #   Enable CUPS to print documents.
  #---------------------------------------------------------------------
  services.printing.enable = true;



  #---------------------------------------------------------------------
  #   Enable automatic discovery of the printer from other Linux systems with avahi running.
  #   mDNS - This part may be optional for your needs, but I find it makes 
  #   browsing in Dolphin easier, and it makes connecting from a 
  #   local Mac possible.
  #---------------------------------------------------------------------
  services.printing.allowFrom =
    [ "all" ]; # this gives access to anyone on the interface
  services.printing.browsing = true;
  services.printing.defaultShared = true;

  # ---------------------------------------------------------------------
  #   Open avahi ports for sharing
  # ---------------------------------------------------------------------
  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];

  # ---------------------------------------------------------------------
  #   Configure avahi for sharing
  # ---------------------------------------------------------------------
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;

    publish = {
      addresses = true;
      domain = true;
      enable = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };

    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };

}