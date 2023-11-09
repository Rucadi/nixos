{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.font-awesome
    pkgs.font-awesome_4
    pkgs.font-awesome_5
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Inconsolata" ]; })
    pkgs.noto-fonts # For microsoft websites like Github and Linkedin on Chromium browsers
    pkgs.dejavu_fonts
    pkgs.feather-font # package comes from dustinlyons/nixpkgs
    pkgs.jetbrains-mono
    pkgs.font-awesome
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
  ];
}
