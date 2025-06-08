{
  config,
  pkgs,
  ...
}:
# Global settings: timezone, locales, nix
{
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "es_ES.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

    gamescopeSession.enable = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  services.envfs.enable = true;

  environment.systemPackages = [
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.font-awesome
    pkgs.font-awesome_4
    pkgs.font-awesome_5
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.inconsolata
    pkgs.noto-fonts # For microsoft websites like Github and Linkedin on Chromium browsers
    pkgs.dejavu_fonts
    pkgs.jetbrains-mono
    pkgs.font-awesome
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
  ];
}
