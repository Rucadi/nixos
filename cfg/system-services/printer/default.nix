{ config, lib, pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];

  #---------------------------------------------------------------------
  #   Printers and printer drivers (To suit my HP LaserJet 600 M601)
  #---------------------------------------------------------------------
  printerDrivers = [
    pkgs.canon-cups-ufr2
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

}
