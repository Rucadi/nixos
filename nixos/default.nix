{ config, inputs, pkgs, fehpkgs, upkgs, ... }:

let user = "rucadi";
in
{

  imports = [
    ./hardware-configuration.nix
    ./boot
    ./gpu/nvidia.nix
    ./virt
    ./desktops/plasma.nix
    ./network
    ./audio
    ./bluetooth
    ./fonts
    ./system
    #./home-manager.nix
    ../shared
    ../shared/cachix
    ./users/git.nix
    ./printer
    ./appimage
    ./games
  ];


# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  
     # Nix Configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];    
    auto-optimise-store = true;
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  

  # Manages keys and such
  programs.gnupg.agent.enable = true;


  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.variables.CLIPBOARD_NOAUDIO = "1";
  environment.variables.CLIPBOARD_SILENT = "1";
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";




  # Better support for general peripherals
  services.xserver.libinput.enable = true;
  boot.kernelModules = [ "uinput" ];
  services.upower.enable = true;
  programs.dconf.enable = true;
  services.dbus.enable = true;
  services.envfs.enable = true;
  services.dbus.packages = with pkgs; [
  	xfce.xfconf
  	gnome2.GConf
  ];
  programs.light.enable = true;
  services.mpd.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true; 
  services.fwupd.enable = true;
  services.auto-cpufreq.enable = true;
  security.pam.services.swaylock = {};
  services.sshd.enable = true;

  security.allowSimultaneousMultithreading = true;



  # Add docker daemon
  virtualisation.docker.enable = true;
  virtualisation.docker.logDriver = "json-file";


  # It's me, it's you, it's everyone
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "docker" "tss" "vboxusers"  ];
    shell = pkgs.bash;
    packages = [
      pkgs.discord
      pkgs.tdesktop
      pkgs.custompkg.fehviewer
    ];
  };


  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
       {
         command = "${pkgs.systemd}/bin/reboot";
         options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  # Let's be able to SSH into this machine
  services.openssh.enable = true;

  # My shell
  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.gitAndTools.gitFull
    pkgs.inetutils
    pkgs.egl-wayland
    pkgs.emacs
    pkgs.vuze
  ];


   programs.direnv.enable = true;
  programs.direnv = {
      package = pkgs.direnv;
      silent = false;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  system.stateVersion = "23.05"; # Don't change this

}
