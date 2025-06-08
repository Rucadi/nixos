{
  pkgs,
  lib,
  config,
  ...
}:{
  # COpy ../quickshell folder to home 
  home.file.".config/quickshell" = {
    source = ../quickshell;
    recursive = true;
  };
}