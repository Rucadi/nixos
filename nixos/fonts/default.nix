{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.font-awesome
    pkgs.font-awesome_4
    pkgs.font-awesome_5
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Inconsolata" ]; })
    pkgs.noto-fonts # For microsoft websites like Github and Linkedin on Chromium browsers
    pkgs.dejavu_fonts
    pkgs.jetbrains-mono
    pkgs.font-awesome
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
  ];
}
